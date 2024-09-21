import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_details_getx/model/student_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

class StudentDbFunctions extends ChangeNotifier {

  //! Add Student
 static Future<void> addStudentDetails(StudentModel value) async {
  final studentDb = await Hive.openBox<StudentModel>(StudentModel.boxName);

  await studentDb.add(value);

  studentListNotifier.value.add(value);

  studentListNotifier.notifyListeners();

  log('add success');
}

//! Get Student
 static Future<void> getStudentDetails() async {
  final studentDb = await Hive.openBox<StudentModel>(StudentModel.boxName);

  studentListNotifier.value.clear();

  studentListNotifier.value.addAll(studentDb.values);

  studentListNotifier.notifyListeners();

  log('get success');
}

//! Delete Student
 static Future<void> deleteStudent(int id) async {
  final studentDb = await Hive.openBox<StudentModel>(StudentModel.boxName);

  await studentDb.delete(id);
  await getStudentDetails();

  log('delete success');
}

//! Update Student
 static Future<void> updateStudent(int id, StudentModel newValue) async {
  final studentDb = await Hive.openBox<StudentModel>(StudentModel.boxName);

  await studentDb.put(id, newValue);

  await getStudentDetails();

  log('update success');
}

  
}
