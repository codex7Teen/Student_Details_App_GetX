// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';

class ScreenViewStudent extends StatefulWidget {
  final String name;
  final String age;
  final String classs;
  final String gender;
  final String? imagePath;
  const ScreenViewStudent({super.key, required this.name, required this.age, required this.classs, required this.gender, this.imagePath});

  @override
  State<ScreenViewStudent> createState() => _ScreenViewStudentState();
}

class _ScreenViewStudentState extends State<ScreenViewStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.yellow[300],
        title: Text(
          widget.name,
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 120,
                  backgroundImage: widget.imagePath != null && widget.imagePath!.isNotEmpty ? FileImage(File(widget.imagePath!)) : AssetImage('assets/logo.png')
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.all(40),
                  height: MediaQuery.sizeOf(context).height * 0.3,
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.yellow[300],
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        overflow: TextOverflow.ellipsis,
                        "Name: ${widget.name}",
                        style: TextStyle(
                          color: Colors.black,
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        "Age: ${widget.age}",
                        style: TextStyle(
                          color: Colors.black,
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        "Class: ${widget.classs}",
                        style: TextStyle(
                          color: Colors.black,
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        "Gender: ${widget.gender}",
                        style: TextStyle(
                          color: Colors.black,
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
