import 'dart:io';
import 'dart:convert';

void main() {
  // Create a reference to the JSON file
  File credentialsFile = File('credentials.json');

  // Read and decode the JSON file into a Dart Map
  Map<String, dynamic> data = jsonDecode(credentialsFile.readAsStringSync());

  // Access the "users" object from the JSON data
  Map<String, dynamic> users = data['users'];

  //check if username exists
  for (var user in users.values) {
    if (user["username"].toString() == "kohul") {
      print('Username already exists!');
      return;
    }
  }
  // Generate a unique user ID using the current timestamp
  String userId = "user${DateTime.now().millisecondsSinceEpoch}";

  // Add a new user object into the users Map
  users[userId] = {"username": 'kohul', "password": 'kohul123'};

  // Convert the updated Map into JSON format
  // and save it back into the file
  credentialsFile.writeAsStringSync(JsonEncoder.withIndent('  ').convert(data));

  print('Registration successful!!!');
}
