import 'package:hive_flutter/adapters.dart';
part 'student_model.g.dart';

@HiveType(typeId: 1)
class StudentModel extends HiveObject{

  static const String boxName = 'Student_db';

  @HiveField(0)
  String name;

  @HiveField(1)
  String age;

  @HiveField(2)
  String classs;

  @HiveField(3)
  String gender;

  @HiveField(4)
  String? image;

  StudentModel(this.name, this.age, this.classs, this.gender, {this.image});
}