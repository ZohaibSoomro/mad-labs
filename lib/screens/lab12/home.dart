import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lab2_task/screens/lab12/dbHelper/db_helper.dart';
import 'package:lab2_task/screens/lab12/model/student.dart';

final labAppBar = AppBar(
  title: const Text('Lab 12'),
  centerTitle: true,
);

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: labAppBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width),
          buildButton(
            context,
            'Add Student',
            Icons.add,
            onPressed: () {
              navigateToPage(context, const AddOrEditStudent());
            },
          ),
          buildButton(
            context,
            'Edit Student Data',
            Icons.edit,
            onPressed: () {
              onEditPressed(context);
            },
          ),
          buildButton(
            context,
            'Delete a Student',
            Icons.delete,
            onPressed: () {
              onDeletePressed(context);
            },
          ),
          buildButton(
            context,
            'List Students',
            Icons.list,
            onPressed: () {
              navigateToPage(context, const ListStudents());
            },
          ),
          buildButton(
            context,
            'Search Student',
            Icons.search,
            onPressed: () async {
              final students = await DbHelper.instance.getAllStudents();
              // ignore: use_build_context_synchronously
              navigateToPage(context, SearchScreen(students: students));
            },
          ),
        ],
      ),
    );
  }

  void onEditPressed(context) async {
    final students = await DbHelper.instance.getAllStudents();
    navigateToPage(
      context,
      StudentSelection(students: students),
    );
  }

  void onDeletePressed(context) async {
    final students = await DbHelper.instance.getAllStudents();
    navigateToPage(
      context,
      StudentSelection(students: students, modeFor: SelectionMode.delete),
    );
  }
}

enum SelectionMode {
  edit,
  delete,
}

class StudentSelection extends StatelessWidget {
  const StudentSelection(
      {Key? key, required this.students, this.modeFor = SelectionMode.edit})
      : super(key: key);
  final List<Student> students;
  final SelectionMode modeFor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              'Select a student to ${modeFor == SelectionMode.edit ? 'edit' : 'delete'}'),
          centerTitle: true),
      body: students.isEmpty
          ? const Center(
              child: Text('No student data available.'),
            )
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) => StudentTile(
                student: students[index],
                onTapped: () {
                  modeFor == SelectionMode.edit
                      ? editStudent(context, students[index])
                      : deleteStudent(context, students[index]);
                },
              ),
            ),
    );
  }

  void editStudent(context, student) async {
    await navigateToPage(context, AddOrEditStudent(student: student), true);
  }

  void deleteStudent(context, student) async {
    try {
      await DbHelper.instance.deleteStudent(student.rollNo);
      Fluttertoast.showToast(
        msg: "Student '${student.rollNo.toUpperCase()}' Deleted Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 14.0,
      );
      Navigator.pop(context);
    } catch (e) {}
  }
}

class ListStudents extends StatefulWidget {
  const ListStudents({Key? key}) : super(key: key);

  @override
  State<ListStudents> createState() => _ListStudentsState();
}

class _ListStudentsState extends State<ListStudents> {
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
        title: const Text('List of Students'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : students.isEmpty
              ? const Center(child: Text('No records available.'))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 30, 0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'Total:${students.length}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: students.length,
                        itemBuilder: (context, index) => StudentTile(
                          student: students[index],
                          onTapped: () {
                            viewStudent(context, students[index]);
                          },
                        ),
                      ),
                    ),
                  ],
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
      students = stds.cast<Student>();
    });
    await Future.delayed(const Duration(milliseconds: 200));
    toggleIsLoading();
  }
}

class StudentTile extends StatelessWidget {
  StudentTile({Key? key, required this.student, required this.onTapped})
      : super(key: key);
  final Student student;
  final VoidCallback onTapped;
  final DbHelper dbHelper = DbHelper.instance;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: const BorderSide(width: 0.1),
      ),
      child: ListTile(
        onTap: onTapped,
        title: Text(
          student.rollNo.toUpperCase(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: CircleAvatar(
          radius: 27,
          child: Text(
            student.name.toUpperCase().characters.first,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        subtitle: Text("${student.name}(${student.age})"),
        contentPadding: const EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

class AddOrEditStudent extends StatefulWidget {
  const AddOrEditStudent({Key? key, this.student}) : super(key: key);
  final Student? student;

  @override
  State<AddOrEditStudent> createState() => _AddOrEditStudentState();
}

class _AddOrEditStudentState extends State<AddOrEditStudent> {
  final formKey = GlobalKey<FormState>();
  final rollNoController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    isCreateMode = widget.student == null;
    if (!isCreateMode) {
      setState(() {
        nameController.text = widget.student!.name;
        ageController.text = widget.student!.age.toString();
      });
    }
  }

  bool isCreateMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: labAppBar,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isCreateMode ? 'Add a Student' : 'Update a Student',
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 20),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 10),
                      buildButton(
                        context,
                        isCreateMode ? 'Add Student' : 'Update Student',
                        isCreateMode ? Icons.add : Icons.edit,
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
                            Fluttertoast.showToast(
                              msg: "Student added/updated succesffully.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 5,
                              backgroundColor: Colors.blue,
                              textColor: Colors.white,
                              fontSize: 14.0,
                            );
                            print("Data inserted/updated");
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
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

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.students}) : super(key: key);
  final List<Student> students;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchTextController = TextEditingController();
  List<Student> students = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      students = widget.students;
    });
    searchTextController.addListener(() {
      setState(() {
        filterStudents();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search a student',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: searchTextController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search with roll no or name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    searchTextController.clear();
                    setState(() {});
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Total:${students.length}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) => StudentTile(
                  student: students[index],
                  onTapped: () {
                    viewStudent(context, students[index]);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void filterStudents() {
    students = widget.students
        .where(
          (student) =>
              student.rollNo
                  .toLowerCase()
                  .contains(searchTextController.text.toLowerCase()) ||
              student.name
                  .toLowerCase()
                  .contains(searchTextController.text.toLowerCase()),
        )
        .toList();
  }
}

Widget buildButton(context, text, icon, {required VoidCallback onPressed}) {
  return Container(
    margin: const EdgeInsets.all(3),
    width: MediaQuery.of(context).size.width * 0.6,
    child: ElevatedButton.icon(
      onPressed: onPressed,
      label: Text(text),
      icon: Icon(icon),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10),
      ),
    ),
  );
}

Future navigateToPage(context, Widget widget, [bool replace = false]) {
  if (replace) {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget));
  } else {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => widget));
  }
}

void viewStudent(context, Student student) async {
  await showDialog(
    context: context,
    builder: (context) => Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
      padding: const EdgeInsets.all(20.0),
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.3,
          horizontal: MediaQuery.of(context).size.height * 0.07),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            child: Text(
              student.name.toUpperCase().characters.first,
              style: const TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            student.rollNo.toUpperCase(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "${student.name}\n(${student.age})",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
