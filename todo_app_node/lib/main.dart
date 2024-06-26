import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_node/RegisterPage.dart';
import 'package:todo_app_node/dashboard.dart';
import 'package:todo_app_node/loginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(token: prefs.getString("token")));
}

class MyApp extends StatelessWidget {
  final token;

  MyApp({@required this.token, Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: (token == null || token!.isEmpty || JwtDecoder.isExpired(token!))
            ? LoginPage()
            : dashBoard(token: token));
  }
}
