import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lab2_task/screens/lab11/dbHelper/db_helper.dart';

import 'model/student.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Student> students = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 11'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : students.isEmpty
              ? const Center(child: Text('No records available.'))
              : ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) => StudentTile(
                    student: students[index],
                    action: () {
                      setState(
                        () {
                          loadStudents();
                        },
                      );
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            context: context,
            builder: (context) {
              return AddStudent(action: () {
                setState(() {
                  loadStudents();
                });
              });
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  toggleIsLoading() => setState(() {
        isLoading = !isLoading;
      });

  void loadStudents() async {
    toggleIsLoading();
    final instance = DbHelper.instance;
    final stds = await instance.getAllStudents();
      setState(() {
        students = stds;
      });
    await Future.delayed(const Duration(milliseconds: 200));
    toggleIsLoading();
  }
}

class StudentTile extends StatelessWidget {
  StudentTile({Key? key, required this.student, required this.action})
      : super(key: key);
  final Student student;
  final DbHelper dbHelper = DbHelper.instance;
  final VoidCallback action;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              await showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                context: context,
                builder: (context) {
                  return AddStudent(
                    student: student,
                    action: action,
                  );
                },
              );
            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.update,
            label: 'update',
          ),
          SlidableAction(
            onPressed: (c) async {
              await DbHelper.instance.deleteStudent(student.rollNo);
              action();
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'delete',
          ),
        ],
      ),
      child: Card(
        margin: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  'Swipe to update or delete',
                  style: TextStyle(fontSize: 10, color: Colors.blue),
                ),
              ),
              Text(student.rollNo),
            ],
          ),
          subtitle: Text("${student.name}\nage: ${student.age}"),
          contentPadding: const EdgeInsets.all(25.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key, this.student, required this.action})
      : super(key: key);
  final Student? student;
  final VoidCallback action;

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final formKey = GlobalKey<FormState>();
  final rollNoController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    isCreateMode = widget.student == null;
    if (!isCreateMode)
      setState(() {
        nameController.text = widget.student!.name;
        ageController.text = widget.student!.age.toString();
      });
  }

  bool isCreateMode = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height * 0.5,
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isCreateMode)
                  TextFormField(
                    controller: rollNoController,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "enter a roll no";
                      }
                      return null;
                    },
                    decoration: buildDecoration('roll number'),
                  ),
                TextFormField(
                  controller: nameController,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "enter a name";
                    }
                    return null;
                  },
                  decoration: buildDecoration('name'),
                ),
                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      "enter age";
                    }
                    try {
                      int.parse(val!);
                    } catch (e) {
                      return "enter a number";
                    }
                    return null;
                  },
                  decoration: buildDecoration('age'),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final instance = DbHelper.instance;
                        final student = Student(
                          rollNo: isCreateMode
                              ? rollNoController.text.toLowerCase()
                              : widget.student!.rollNo,
                          name: nameController.text,
                          age: int.parse(ageController.text),
                        );
                        await isCreateMode
                            ? instance.insertStudent(student)
                            : instance.updateStudent(student);
                        setState(() {});
                        widget.action();
                        print("Data inserted/updated");
                        Navigator.pop(context);
                      }
                    },
                    child: Text('${isCreateMode ? "Add" : "Update"} Student'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildDecoration(hint) => InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      hintText: hint);
}
