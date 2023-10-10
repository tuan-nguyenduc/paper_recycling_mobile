// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paper_recycling_shopper/constants/error_handling.dart';
import 'package:paper_recycling_shopper/constants/global_variables.dart';
import 'package:http/http.dart' as http;

class AuthService {
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final uri = Uri.parse('$API_URL/auth/login');
      http.Response res = await http.post(
        uri,
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            print("Login Successful!");
            print(jsonDecode(res.body));
          });
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    }
  }
}
