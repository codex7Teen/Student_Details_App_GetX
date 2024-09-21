// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_details_getx/db/student_db.dart';
import 'package:student_details_getx/model/student_model.dart';
import 'package:student_details_getx/screens/view_student.dart';
import 'package:student_details_getx/widgets/student_list_widget.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {

  List<StudentModel> searchResults = [];
  bool hasSearched = false;

  void filteredStudets(String query) {
    final results = studentListNotifier.value.where((student) {
      return student.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      searchResults = results;
      hasSearched = true;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
          color: Colors.black,
        ),
          backgroundColor: Colors.yellow[300],
          title: Text(
            'Serach Students',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Icon(Icons.search),
            )
          ],
        ),
        //! body
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: CupertinoSearchTextField(
                backgroundColor: Colors.white,
                padding: EdgeInsets.all(10),
                onChanged: (query) {
                  filteredStudets(query);
                },
              ),
            ),

            Expanded(
              child: hasSearched ? searchResults.isNotEmpty ? ListView.builder(
                          itemCount: searchResults.length,
                          itemBuilder: (context, index) {
                            //data
                            final data = searchResults[index];
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
                                  classs: data.classs,
                                  age: data.age,
                                ));
                          }) : Center(child: Text("NO MATCHING STUDENT FOUND!!!"),) : Center(child: Text("SEARCH FOR STUDENTS..."),)
            )
          ],
        ));
  }
}
