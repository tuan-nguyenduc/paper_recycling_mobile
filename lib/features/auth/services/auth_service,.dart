// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paper_recycling_shopper/common/bottom_bar.dart';
import 'package:paper_recycling_shopper/common/persistent_nav_bar.dart';
import 'package:paper_recycling_shopper/constants/error_handling.dart';
import 'package:paper_recycling_shopper/constants/global_variables.dart';
import 'package:http/http.dart' as http;
import 'package:paper_recycling_shopper/providers/user_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:paper_recycling_shopper/features/home/screens/home_screen.dart';

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
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            //print(json.encode(json.decode(res.body)['data']['user']));
            Provider.of<UserProvider>(context, listen: false)
                .setUser(json.encode(json.decode(res.body)['data']));

            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['data']['accessToken']);

            Navigator.pushNamedAndRemoveUntil(
                context, PersistentBottomBar.routeName, (route) => false);
            // Navigator.of(context).popUntil(ModalRoute.withName("/home"));
          });
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    }
  }

  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      final uri = Uri.parse('$API_URL/users/me');

      http.Response userRes = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      // var userProvider = Provider.of<UserProvider>(context, listen: false);
      // userProvider.setUser(jsonEncode(jsonDecode(userRes.body)['data']));
      // print(jsonEncode(jsonDecode(userRes.body)['data']));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
