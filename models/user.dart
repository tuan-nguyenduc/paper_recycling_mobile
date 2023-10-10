import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final int id;
  final String name;
  final String email;
  final String role;
  final double paperPoint;
  final String studentId;
  final String phone;
  final int age;
  final String avatar;
  final int schoolId;
  final String token;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.paperPoint,
    required this.studentId,
    required this.phone,
    required this.age,
    required this.avatar,
    required this.schoolId,
    required this.token,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'paperPoint': paperPoint,
      'studentId': studentId,
      'phone': phone,
      'age': age,
      'avatar': avatar,
      'schoolId': schoolId,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      role: map['role'] as String,
      paperPoint: map['paperPoint'] as double,
      studentId: map['studentId'] as String,
      phone: map['phone'] as String,
      age: map['age'] as int,
      avatar: map['avatar'] as String,
      schoolId: map['schoolId'] as int,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);
}
