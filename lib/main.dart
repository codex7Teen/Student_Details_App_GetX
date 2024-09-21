import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_details_getx/model/student_model.dart';
import 'package:student_details_getx/screens/splash_screen.dart';

Future<void> main() async {

  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register the Hive Adapter for your StudentModel
  Hive.registerAdapter(StudentModelAdapter());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Student Details Getx',
      debugShowCheckedModeBanner: false,
      home: ScreenSplash(),
    );
}
}