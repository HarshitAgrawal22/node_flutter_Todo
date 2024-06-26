import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_node/RegisterPage.dart';
import 'package:todo_app_node/dashboard.dart';
import 'package:todo_app_node/myTextField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController(),
      passwordController = TextEditingController();
  String warning = "TODO -: AI Powered";
  late SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    if (usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      Map<String, String> credentials = {
        "email": usernameController.text,
        "password": passwordController.text
      };
      final response = await http.post(
          Uri.parse("http://192.168.1.28:3000/login"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(credentials));

      Map<String, dynamic> map = jsonDecode(response.body);
      if (map["status"]) {
        String token = map["token"];
        prefs.setString("token", token);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => dashBoard(token: token)));
      } else {
        setState(() {
          warning = "unable to signup";
        });
      }
    } else {
      setState(() {
        warning = "Email and Password are required";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size sizeConstraints = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: Padding(
        padding: EdgeInsets.only(bottom: sizeConstraints.height / 3.6),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: sizeConstraints.height / 50,
                    horizontal: sizeConstraints.width / 40),
                child: Row(
                  children: [
                    Text(
                      "Log in ",
                      style: TextStyle(
                          fontSize: sizeConstraints.height / 30,
                          fontWeight: FontWeight.w900),
                    )
                  ],
                ),
              ),
              Text(
                warning,
                style: TextStyle(fontSize: sizeConstraints.height / 50),
              ),
              MyTextfield(
                  fieldColor: Colors.white,
                  textToShow: "Username",
                  isPassword: false,
                  enabledBorderColor: Colors.purple,
                  givenController: usernameController),
              MyTextfield(
                  fieldColor: Colors.white,
                  textToShow: "password",
                  isPassword: true,
                  enabledBorderColor: Colors.purple,
                  givenController: passwordController),
              GestureDetector(
                onTap: () {
                  loginUser();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: sizeConstraints.height / 20,
                      horizontal: sizeConstraints.width / 40),
                  padding: EdgeInsets.symmetric(
                    vertical: sizeConstraints.height / 50,
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(sizeConstraints.height / 90),
                    color: Colors.purple,
                  ),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: sizeConstraints.width / 150,
                          fontWeight: FontWeight.w400,
                          fontSize: sizeConstraints.height / 46),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
      bottomSheet: Padding(
        padding: EdgeInsets.only(bottom: sizeConstraints.height / 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an accoount? "),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ));
              },
              child: Text(
                "Sign Up",
                style: TextStyle(
                    fontSize: sizeConstraints.height / 50,
                    color: Colors.blue.shade900),
              ),
            )
          ],
        ),
      ),
    );
  }
}
