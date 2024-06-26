import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app_node/loginPAge.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app_node/myTextField.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController(),
      passwordController = TextEditingController();
  String warning = "TODO";

  void registerUser() async {
    if (usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      var userData = {
        "email": usernameController.text,
        "password": passwordController.text
      };

      var response = await http.post(
          Uri.parse("http://192.168.1.28:3000/registration"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(userData));
      Map<String, dynamic> map = jsonDecode(response.body);
      if (map["status"]) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
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
                      "Sign Up",
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
                  registerUser();
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
                      "SignUp",
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text(
                "Log in",
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
