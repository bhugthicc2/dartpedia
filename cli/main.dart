import 'dart:convert';
import 'dart:io';

void main() {
  final File credentialsFile = File('credentials.json');

  // Create file if it doesn't exist
  if (!credentialsFile.existsSync()) {
    credentialsFile.writeAsStringSync(jsonEncode({"users": {}}));
  }

  while (true) {
    print("\n[0] Login");
    print("[1] Register");
    print("[Q] Quit");
    stdout.write("Enter choice: ");

    String choice = stdin.readLineSync()?.trim().toLowerCase() ?? '';

    switch (choice) {
      case '0':
        login(credentialsFile);
        break;

      case '1':
        register(credentialsFile);
        break;

      case 'q':
        print("Program terminated.");
        return;

      default:
        print("Invalid choice!");
    }
  }
}

void login(File credentialsFile) {
  stdout.write("Enter username: ");
  String username = stdin.readLineSync()?.trim() ?? '';

  stdout.write("Enter password: ");
  String password = stdin.readLineSync()?.trim() ?? '';

  Map<String, dynamic> data = jsonDecode(credentialsFile.readAsStringSync());

  Map<String, dynamic> users = data['users'];

  bool isFound = false;

  for (var user in users.values) {
    if (user['username'] == username && user['password'] == password) {
      print("Login Successful. Welcome, ${user['username']}!");
      isFound = true;
      break;
    }
  }

  if (!isFound) {
    print("Invalid username or password!");
  }
}

void register(File credentialsFile) {
  stdout.write("Enter username: ");
  String username = stdin.readLineSync()?.trim() ?? '';

  stdout.write("Enter password: ");
  String password = stdin.readLineSync()?.trim() ?? '';

  Map<String, dynamic> data = jsonDecode(credentialsFile.readAsStringSync());

  Map<String, dynamic> users = data['users'];

  // Check if username already exists
  for (var user in users.values) {
    if (user['username'] == username) {
      print("Username already exists!");
      return;
    }
  }

  String userId = "user${DateTime.now().millisecondsSinceEpoch}";

  users[userId] = {"username": username, "password": password};

  credentialsFile.writeAsStringSync(JsonEncoder.withIndent('  ').convert(data));

  print("Registered Successfully!");
}
