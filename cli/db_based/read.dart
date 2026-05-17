import 'package:mongo_dart/mongo_dart.dart';

Future<void> main() async {
  final db = await Db.create('mongodb://localhost:27017/local_db');

  await db.open();
  print('Connected to MonggoDb');

  final users = db.collection('users');
  //read test
  var allUsers = await users.find().toList();

  print('\nAll Users:');
  print(allUsers);

  // Find one user
  var user = await users.findOne(where.eq('username', 'edbar'));

  print('\nSingle User:');
  print(user);
}
