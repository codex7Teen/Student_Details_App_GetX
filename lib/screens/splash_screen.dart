// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_details_getx/db/student_db.dart';
import 'package:student_details_getx/screens/home_screen.dart';

class ScreenSplash extends StatefulWidget {
   ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {

  @override
  void initState() {
    super.initState();
    StudentDbFunctions.getStudentDetails();
    Timer(Duration(seconds: 3), () => Get.off(ScreenHome())); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/logo.png", width: 180),
      ),
    );
  }
}