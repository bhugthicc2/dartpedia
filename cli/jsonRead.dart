import 'dart:io';
import 'dart:convert';

void main() {
  // Create a reference to the JSON file
  File credentialsFile = File('credentials.json');

  // Read the JSON file content and decode it into a Dart Map
  Map<String, dynamic> data = jsonDecode(credentialsFile.readAsStringSync());

  // Access the "users" object from the JSON data
  Map<String, dynamic> users = data["users"];

  // Loop through each user object inside the users Map
  for (var user in users.values) {
    if (user["username"] == "jesie" && user["password"] == "jesie12") {
      print(
        "User Found.\nUsername: ${user["username"]}\nPassword: ${user["password"]}",
      );
      return;
    }
  }
}
