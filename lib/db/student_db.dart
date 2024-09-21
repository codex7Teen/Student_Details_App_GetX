import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_details_getx/model/student_model.dart';

class StudentController extends GetxController {
  
  // Main RxList to store student data
  var studentList = <StudentModel>[].obs;

  // List to store search results
  var searchResults = <StudentModel>[].obs;
  // To track if a search has been made
  var hasSearched = false.obs;
  // to track dark/white mode
  var darkModeToggle = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch data when controller initializes
    getStudentDetails();
  }

  //! Add Student
  Future<void> addStudentDetails(StudentModel value) async {
    final studentDb = await Hive.openBox<StudentModel>(StudentModel.boxName);

    await studentDb.add(value);

    // Automatically triggers UI update
    studentList.add(value);

    log('add success');
  }

//! Get Student
  Future<void> getStudentDetails() async {
    final studentDb = await Hive.openBox<StudentModel>(StudentModel.boxName);

    studentList.clear();
    // Automatically triggers UI update
    studentList.addAll(studentDb.values);

    log('get success');
  }

//! Delete Student
  Future<void> deleteStudent(int id) async {
    final studentDb = await Hive.openBox<StudentModel>(StudentModel.boxName);

    await studentDb.delete(id);
    getStudentDetails();

    log('delete success');
  }

//! Update Student
  Future<void> updateStudent(int id, StudentModel newValue) async {
    final studentDb = await Hive.openBox<StudentModel>(StudentModel.boxName);

    await studentDb.put(id, newValue);

    getStudentDetails();

    log('update success');
  }

  //! Filter Students
  void filteredStudets(String query) {
    final results = studentList.where((student) {
      return student.name.contains(query.toLowerCase());
    }).toList();

    searchResults.value = results;
    // Marking as searched
    hasSearched.value = true;
  }

  //! Change darkmode bool
  void changeDarkmodeBool() {
    darkModeToggle.value = !darkModeToggle.value;
  }
}
