import 'dart:io';
import 'dart:convert';

void main() {
  // Create a reference to the JSON file
  File credentialsFile = File('credentials.json');

  // Read the JSON file content and decode it into a Dart Map
  Map<String, dynamic> data = jsonDecode(credentialsFile.readAsStringSync());

  // Access the "users" object from the JSON data
  Map<String, dynamic> users = data['users'];

  // Loop through each user object in the users Map
  for (var user in users.values) {
    // Check if the current username matches "cowhol"
    if (user["username"].toString() == "cowhol") {
      // Update the username value
      user["username"] = "jonyae";
    }
  }

  // Convert the updated Map into JSON format
  // and save the updated data back into the file
  credentialsFile.writeAsStringSync(JsonEncoder.withIndent('  ').convert(data));

  print('User updated!!!');
}
