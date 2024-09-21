// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_details_getx/db/student_db.dart';
import 'package:get/get.dart';
import 'package:student_details_getx/screens/add_student.dart';

class StudentListWidget extends StatelessWidget {
  final String name;
  final String gender;
  final int id;
  final String? imagePath;
  final String classs;
  final String age;

  const StudentListWidget({super.key, required this.name, required this.gender, required this.id, this.imagePath, required this.classs, required this.age});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: Colors.yellow[300],
            child: ListTile(
              leading: imagePath != null && imagePath!.isNotEmpty ? CircleAvatar(
                backgroundImage: FileImage(File(imagePath!)) ,
              ) : CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/logo.png')
              ),
              title: Text(name, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black),),
              subtitle: Text(gender, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black),),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(onPressed: () {
                      Get.to(ScreenAddStudent(heading: 'Update Student Details', addOrUpdate: 'Update student', name: name, classs: classs, age: age, gender: gender, studentId: id, imagePath: imagePath,));
                    }, icon: Icon(Icons.create,color: Colors.black)),
                    IconButton(onPressed: () async {
                      //delete
                      await StudentDbFunctions.deleteStudent(id);
                    }, icon: Icon(Icons.delete,color: Colors.black))
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
}