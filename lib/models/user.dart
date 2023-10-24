import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final int id;
  final String name;
  final String email;
  final String role;
  final String createdAt;
  final String updatedAt;
  final double paperPoint;
  final String studentId;
  final String phone;
  final int age;
  final String? avatar;
  final int schoolId;
  final String? token;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.paperPoint,
    required this.studentId,
    required this.phone,
    required this.age,
    this.avatar,
    required this.schoolId,
    this.token
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'paperPoint': paperPoint,
      'studentId': studentId,
      'phone': phone,
      'age': age,
      'avatar': avatar,
      'schoolId': schoolId,
      'token': token
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['user']['id'] as int,
      name: map['user']['name'] as String,
      email: map['user']['email'] as String,
      role: map['user']['role'] as String,
      createdAt: map['user']['createdAt'] as String,
      updatedAt: map['user']['updatedAt'] as String,
      paperPoint: map['user']['paperPoint'].toDouble() as double,
      studentId: map['user']['studentId'] as String,
      phone: map['user']['phone'] as String,
      age: map['user']['age'] as int,
      avatar: map['user']['avatar'] as String,
      schoolId: map['user']['schoolId'] as int,
      token: map['accessToken'] != null ? map['accessToken'] as String : null
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);
}
