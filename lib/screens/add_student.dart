// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_details_getx/db/student_db.dart';
import 'package:student_details_getx/model/student_model.dart';

class ScreenAddStudent extends StatefulWidget {
  final String heading;
  final String addOrUpdate;
  final String? name;
  final String? age;
  final String? classs;
  final String? gender;
  final String? imagePath;
  final int? studentId;
  const ScreenAddStudent(
      {super.key,
      required this.heading,
      required this.addOrUpdate,
      this.name,
      this.age,
      this.classs,
      this.gender,
      this.imagePath,
      this.studentId});

  @override
  State<ScreenAddStudent> createState() => _ScreenAddStudentState();
}

TextEditingController _userNameController = TextEditingController();
TextEditingController _ageController = TextEditingController();
TextEditingController _classController = TextEditingController();
TextEditingController _genderController = TextEditingController();

final formKey = GlobalKey<FormState>();

class _ScreenAddStudentState extends State<ScreenAddStudent> {
  File? imageFile;

  //! pick image function
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _userNameController.text = widget.name ?? '';
    _ageController.text = widget.age ?? '';
    _classController.text = widget.classs ?? '';
    _genderController.text = widget.gender ?? '';
    if (widget.imagePath != null && widget.imagePath!.isNotEmpty) {
      imageFile = File(widget.imagePath!);
    } else {
      imageFile = null;
    }
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
          widget.heading,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      //! body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                      radius: 50,
                      backgroundImage: imageFile != null
                          ? FileImage(imageFile!)
                          : AssetImage('assets/logo.png') as ImageProvider),
                  ElevatedButton(
                      onPressed: () {
                        pickImage();
                      },
                      child: Text('Pick Image')),
                  SizedBox(height: 30),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
                      } else {
                        return null;
                      }
                    },
                    controller: _userNameController,
                    decoration: InputDecoration(
                      hintText: " Enter your name",
                      labelText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter age';
                      }
                      return null;
                    },
                    controller: _ageController,
                    decoration: InputDecoration(
                      hintText: " Enter your age",
                      labelText: "Age",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter class';
                      }
                      return null;
                    },
                    controller: _classController,
                    decoration: InputDecoration(
                      hintText: " Enter your class",
                      labelText: "Class",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter gender';
                      }
                      return null;
                    },
                    controller: _genderController,
                    decoration: InputDecoration(
                      hintText: " Enter your gender",
                      labelText: "Gender",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _userNameController.clear();
                            _ageController.clear();
                            _classController.clear();
                            _genderController.clear();
                          });
                        },
                        child: Container(
                          width: 95,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Colors.red[100],
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(child: Text('Clear Data', style: TextStyle(color: Colors.black),)),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      InkWell(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            //save data
                            final String name = _userNameController.text;
                            final String age = _ageController.text;
                            final String classs = _classController.text;
                            final String gender = _genderController.text;

                            if (name.isNotEmpty &&
                                age.isNotEmpty &&
                                classs.isNotEmpty &&
                                gender.isNotEmpty) {
                              final data = StudentModel(
                                  name, age, classs, gender,
                                  image: imageFile?.path);

                              if (widget.addOrUpdate == 'Add Student') {
                                // Add Student
                                await StudentDbFunctions.addStudentDetails(data);      
                              } else {
                                await StudentDbFunctions.updateStudent(widget.studentId!, data);
                              }

                              Get.back();
                                  Get.showSnackbar(GetSnackBar(
                                    duration: Duration(seconds: 1),
                                    title: 'Save data success',
                                    message: '_',
                                  ));
                            }

                            _userNameController.clear();
                            _ageController.clear();
                            _classController.clear();
                            _genderController.clear();

                            log('fully data saved');
                          }
                        },
                        child: Container(
                          width: 120,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(child: Text(widget.addOrUpdate, style: TextStyle(color: Colors.black))),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
