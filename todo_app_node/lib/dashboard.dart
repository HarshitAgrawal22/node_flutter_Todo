import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app_node/TODOpage.dart';

class dashBoard extends StatefulWidget {
  final String token;
  dashBoard({super.key, required this.token});

  @override
  State<dashBoard> createState() => _dashBoardState();
}

class _dashBoardState extends State<dashBoard> {
  List? allTodos;
  TextEditingController descController = new TextEditingController(),
      titleController = new TextEditingController();

  void addTodo() async {
    if (descController.text.isNotEmpty && titleController.text.isNotEmpty) {
      String token = widget.token;
      Map<String, dynamic> tokenData = JwtDecoder.decode(token);

      Map<String, dynamic> newTodo = {
        "userId": tokenData["id"],
        "title": titleController.text,
        "desc": descController.text
      };
      print(newTodo);
      var response = await http.post(
        Uri.parse("http://192.168.1.28:3000/todo/create-todo"),
        body: jsonEncode(newTodo),
        headers: {"Content-Type": "application/json"},
      );
      if (jsonDecode(response.body)["status"]) {
        titleController.clear();
        descController.clear();
        Navigator.of(context).pop();
        getTODOList(tokenData["id"]);
      }
    } else {
      descController.text.isEmpty
          ? descController.text = "this is required field"
          : titleController.text = "this is required field";
    }
  }

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtdecodedToken = JwtDecoder.decode(widget.token);
    String email = jwtdecodedToken["email"];
    String userId = jwtdecodedToken["id"];

    getTODOList(userId);
  }

  void getTODOList(String userId) async {
    print("User id is => " + userId);
    var response = await http.post(
      Uri.parse("http://192.168.1.28:3000/todo/list-todo"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        {"userId": userId},
      ),
    );

    setState(() {
      Map<String, dynamic> re = jsonDecode(response.body);
      allTodos = re["success"];
      // for (int i = 0; i < allTodos!.length; i++) {
      //   print(allTodos![i]);
      // }
    });
  }

  void deleteTODO(String TodoId) async {
    // print(TodoId);
    // print(JwtDecoder.decode(widget.token)["id"]);

    var response = await http.post(
      Uri.parse("http://192.168.1.28:3000/todo/delete-todo"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        {"todoId": TodoId},
      ),
    );
    setState(() {
      getTODOList(JwtDecoder.decode(widget.token)["id"]);
    });
  }

  late String email;
  void createNewTODO() {
    showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            backgroundColor: Color.fromRGBO(248, 241, 255, 1),
            elevation: 10,
            content: Container(
              height: MediaQuery.of(context).size.height / 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Create Future",
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                  TextField(
                    controller: titleController,
                    style: const TextStyle(
                      color: Colors.purple,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Title",
                    ),
                    cursorColor: Colors.deepOrange,
                  ),
                  TextField(
                    controller: descController,
                    style: const TextStyle(
                      color: Colors.purple,
                    ),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Desc"),
                    cursorColor: Colors.deepOrange,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            titleController.clear();
                            descController.clear();

                            Navigator.of(context).pop();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(82, 72, 156, 1),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.of(context).size.height /
                                              100,
                                      horizontal:
                                          MediaQuery.of(context).size.height /
                                              100),
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Colors.white, letterSpacing: 1),
                                  )))),
                      GestureDetector(
                        onTap: () {
                          addTodo();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(27, 153, 139, 1),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height / 100,
                                horizontal:
                                    MediaQuery.of(context).size.height / 100),
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                  color: Colors.white, letterSpacing: 1),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        title: const Text("TODO"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 5 / 100),
        child: allTodos == null
            ? null
            : ListView.builder(
                itemCount: allTodos!.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 100),
                      child: Slidable(
                        endActionPane:
                            ActionPane(motion: ScrollMotion(), children: [
                          SlidableAction(
                            onPressed: (context) {
                              deleteTODO(allTodos![index]["_id"]);
                            },
                            backgroundColor: Color.fromRGBO(139, 139, 174, 1),
                            foregroundColor: Colors.yellow,
                            icon: Icons.delete,
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.height / 80),
                          ),
                        ]),
                        startActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => todoPage(
                                            desc: allTodos![index]["desc"],
                                            title: allTodos![index]["title"])));
                              },
                              icon: Icons.pages,
                              foregroundColor: Colors.yellow,
                              backgroundColor: Color.fromRGBO(231, 143, 142, 2),
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height / 80),
                            )
                          ],
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(236, 226, 208, 1),
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height / 80)),
                          width: MediaQuery.sizeOf(context).width,
                          padding: EdgeInsets.symmetric(
                              vertical: MediaQuery.sizeOf(context).height / 90,
                              horizontal:
                                  MediaQuery.sizeOf(context).width / 90),
                          child: Text(
                            allTodos![index]["title"],
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.sizeOf(context).height / 55),
                          ),
                        ),
                      ));
                }),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            createNewTODO();
          },
          backgroundColor: Colors.purple,
          child: const Icon(Icons.add)),
    );
  }
}
