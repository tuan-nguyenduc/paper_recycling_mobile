import 'package:flutter/material.dart';
import 'package:paper_recycling_shopper/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: -1,
      name: '',
      email: '',
      role: '',
      createdAt: '',
      updatedAt: '',
      paperPoint: -1,
      studentId: '',
      phone: '',
      age: -1,
      avatar: '',
      schoolId: -1,
      token: ''
  );

  User get user => _user;

  void setUser(String user) {
    
    _user = User.fromJson(user);
    //print(_user.toJson());
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}