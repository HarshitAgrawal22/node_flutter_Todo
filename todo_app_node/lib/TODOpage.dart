import 'package:flutter/material.dart';

class todoPage extends StatelessWidget {
  String desc, title;
  todoPage({super.key, required this.desc, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text(
            "Lets get STARTED",
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.sizeOf(context).height / 30,
                    horizontal: MediaQuery.sizeOf(context).width / 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: TextStyle(
                        fontSize: MediaQuery.sizeOf(context).height / 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height / 30,
                    ),
                    Text(
                      desc,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.sizeOf(context).height / 45,
                      ),
                    )
                  ],
                ))));
  }
}
