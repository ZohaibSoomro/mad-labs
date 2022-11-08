import 'dart:async';

import 'package:lab2_task/screens/lab12/model/student.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper instance = DbHelper._init();
  DbHelper._init();
  Database? _database;
  static String dbName = "Mydb.db";
  static String tableName = "Students";
  Future<Database> get database async => _database ??= await openDatabase(
        join(await getDatabasesPath(), dbName),
        onCreate: onCreate,
        version: 1,
      );

  Future<void> onCreate(Database db, int version) async {
    final result = await db.execute(
        "CREATE TABLE $tableName(rollNo Text Primary Key, name Text, age INTEGER)");
    print("Table created");
  }

  Future<void> insertStudent(Student student) async {
    final db = await instance.database;
    var result = await db.insert(tableName, student.toJson());
    print("data inserted ${result}");
  }

  Future<void> updateStudent(Student student) async {
    final db = await instance.database;
    var result = await db.update(
      tableName,
      student.toJson(),
      where: 'rollNo=?',
      whereArgs: [student.rollNo],
    );
    print("data inserted ${result}");
  }

  Future<void> deleteStudent(String rollNo) async {
    final db = await instance.database;
    var result = await db.delete(
      tableName,
      where: 'rollNo=?',
      whereArgs: [rollNo],
    );
    print("data deleted ${result}");
  }

  Future<List<Student>> getAllStudents() async {
    List<Student> students = [];
    final db = await instance.database;
    final result = await db.query(tableName);
    for (final data in result) {
      final student = Student.fromJson(data);
      students.add(student);
    }
    return students;
  }
}
