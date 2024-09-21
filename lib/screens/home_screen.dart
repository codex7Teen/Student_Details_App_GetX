// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_details_getx/db/student_db.dart';
import 'package:student_details_getx/screens/add_student.dart';
import 'package:student_details_getx/screens/search_screen.dart';
import 'package:student_details_getx/screens/view_student.dart';
import 'package:student_details_getx/widgets/student_list_widget.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  //! Injecting the StudentController
  final StudentController studentController = Get.find<StudentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.yellow,
            child: Icon(Icons.add, color: Colors.black),
            onPressed: () {
              Get.to(ScreenAddStudent(
                addOrUpdate: 'Add Student',
                heading: 'Add Student Details',
              ));
            }),
        appBar: AppBar(
          iconTheme: IconThemeData(
          color: Colors.black,
        ),
          leading: InkWell(
            onTap: () { 
                // calling function to toggle the darkmode bool which is set as observable
                studentController.changeDarkmodeBool();
                // getX listens to the boolchange automatically and rebuilds ui automaticlly
              studentController.darkModeToggle.value ? Get.changeTheme(ThemeData.light()) : Get.changeTheme(ThemeData.dark());
            },
            // wrapping with obx to rebuild the icon when the obs-bool change
            child: Obx(() {
              return studentController.darkModeToggle.value ? Icon(Icons.dark_mode_outlined, color: Colors.black,) :  Icon(Icons.light_mode_rounded,color: Colors.black);
            }) ),
          backgroundColor: Colors.yellow[300],
          title: Text(
            'Student Details',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: () => Get.to(ScreenSearch()),
                child: Icon(Icons.search,color: Colors.black)),
            )
          ],
        ),
        //! body
        body: Obx(() {
          if(studentController.studentList.isEmpty) {
            return Center(child: Text("NO STUDENT DATA"));
          }
          return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListView.builder(
                    itemCount: studentController.studentList.length,
                    itemBuilder: (context, index) {
                      //data
                      final data = studentController.studentList[index];
                      return InkWell(
                          onTap: () => Get.to(ScreenViewStudent(
                            imagePath: data.image,
                              name: data.name,
                              age: data.age,
                              classs: data.classs,
                              gender: data.gender)),
                          child: StudentListWidget(
                            name: data.name,
                            gender: data.gender,
                            id: data.key,
                            imagePath: data.image,
                            age: data.age,
                            classs: data.classs,
                          ));
                    }));
        })
   );
  }
}
