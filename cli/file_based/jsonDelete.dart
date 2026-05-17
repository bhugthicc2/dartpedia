import 'dart:io';
import 'dart:convert';

void main() {
  // Create a reference to the JSON file
  File credentialsFile = File('credentials.json');

  // Read the JSON file content and decode it into a Dart Map
  Map<String, dynamic> data = jsonDecode(credentialsFile.readAsStringSync());

  // Access the "users" object from the JSON data
  Map<String, dynamic> users = data['users'];

  // Remove the user entry where the username matches "cowhol"
  // This deletes the entire user object (key + value) from the Map
  users.removeWhere((key, user) => user["username"] == "cowhol");
  //..................parameter.....condition
  // Convert the updated Map into JSON format
  // and write the updated data back into the JSON file
  credentialsFile.writeAsStringSync(JsonEncoder.withIndent('  ').convert(data));

  print('User deleted!!!');
}
