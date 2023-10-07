import 'package:flutter/material.dart';
import 'package:paper_recycling_shopper/constants/global_variables.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.bgColor,
      body: Stack(children: [
        Center(
          child: Image.asset('assets/images/bg_pattern.png'),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Image.asset('assets/images/logo.png'),
                    ),
                    Image.asset('assets/images/logo_name.png')
                  ],
                ),
              ),
              Container(
                  width: 350,
                  height: 400,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset("assets/images/headline.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: "Email",
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                                focusColor: Colors.black,
                            labelText: "Password",
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              style: const ButtonStyle(
                                  alignment: Alignment.topRight),
                              child: const Text("Forgot password?",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ))),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: GlobalVariables.primaryColor,
                          fixedSize: const Size(330, 60),
                        ),
                        child: const Text("Sign In"),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ]),
    );
  }
}
