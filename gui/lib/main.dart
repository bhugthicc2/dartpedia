import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gui/widgets/tab_items.dart';

void main() {
  runApp(const MyAppp());
}

class MyAppp extends StatefulWidget {
  const MyAppp({super.key});

  @override
  State<MyAppp> createState() => _MyApppState();
}

class _MyApppState extends State<MyAppp> with SingleTickerProviderStateMixin {
  bool isFound = false;
  String dataFound = '';

  late TabController tabController;
  final TextEditingController userameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String username = "";
  String password = "";

  // Create a reference to the JSON file
  File credentialsFile = File('C:/dartpedia/cli/credentials.json');

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    loadData();
  }

  @override
  void dispose() {
    userameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "CRUD TEST",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          bottom: TabBar(
            controller: tabController,
            tabs: [
              Tab(text: 'Login'),
              Tab(text: 'Register'),
              Tab(text: 'Read'),
            ],
          ),
        ),

        body: TabBarView(
          controller: tabController,
          children: [
            //login
            TabItemWrapper(
              widget: Column(
                children: [
                  const SizedBox(height: 20),
                  TextField(
                    controller: userameController,
                    decoration: InputDecoration(label: Text("Username")),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(label: Text("Password")),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: MaterialButton(
                      onPressed: () {
                        // Read the JSON file content and decode it into a Dart Map
                        Map<String, dynamic> data = jsonDecode(
                          credentialsFile.readAsStringSync(),
                        );

                        // Access the "users" object from the JSON data
                        Map<String, dynamic> users = data["users"];
                        var user = {};
                        // Loop through each user object inside the users Map
                        for (user in users.values) {
                          if (user["username"] == username &&
                              user["password"] == password) {
                            setState(() {
                              username = userameController.text;
                              password = passwordController.text;
                              isFound = true;
                              dataFound =
                                  'User Found.\nUsername: ${user["username"]}\nPassword: ${user["password"]}';
                            });
                            return;
                          }
                        }
                      },
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text('Login'),
                    ),
                  ),
                  const SizedBox(height: 40),
                  isFound
                      ? Text(
                          "User found! $dataFound",
                          style: TextStyle(color: Colors.green),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
            //register
            TabItemWrapper(
              widget: Column(
                children: [
                  const SizedBox(height: 20),
                  TextField(
                    controller: userameController,
                    decoration: InputDecoration(label: Text("Username")),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(label: Text("Password")),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: MaterialButton(
                      onPressed: () {
                        setState(() {
                          username = userameController.text;
                          password = passwordController.text;
                        });

                        // Read and decode the JSON file into a Dart Map
                        Map<String, dynamic> data = jsonDecode(
                          credentialsFile.readAsStringSync(),
                        );

                        // Access the "users" object from the JSON data
                        Map<String, dynamic> users = data['users'];

                        //check if username exists
                        for (var user in users.values) {
                          if (user["username"].toString() == username) {
                            debugPrint("Username already exists.");
                            return;
                          }
                        }
                        // Generate a unique user ID using the current timestamp
                        String userId =
                            "user${DateTime.now().millisecondsSinceEpoch}";

                        // Add a new user object into the users Map
                        users[userId] = {
                          "username": username,
                          "password": password,
                        };

                        // Convert the updated Map into JSON format
                        // and save it back into the file
                        credentialsFile.writeAsStringSync(
                          JsonEncoder.withIndent('  ').convert(data),
                        );
                        debugPrint('Registration successful!!!');
                        loadData();
                      },
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text('Register'),
                    ),
                  ),
                ],
              ),
            ),
            TabItemWrapper(
              widget: Column(
                children: [
                  const SizedBox(height: 20),
                  // Text(const JsonEncoder.withIndent('  ').convert(usersText)),
                  Column(
                    children: usersText.entries.map((entry) {
                      return Card(
                        shape: Border(bottom: BorderSide(width: 1)),
                        child: ListTile(
                          title: Text(entry.value["username"]),
                          subtitle: Text(entry.value["password"]),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> usersText = {};

  void loadData() {
    Map<String, dynamic> jsonData = jsonDecode(
      credentialsFile.readAsStringSync(),
    );

    Map<String, dynamic> users = jsonData["users"];

    setState(() {
      usersText = users;
    });
  }
}
