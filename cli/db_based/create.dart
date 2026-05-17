import 'package:mongo_dart/mongo_dart.dart';

Future<void> main() async {
  final db = await Db.create('mongodb://localhost:27017/local_db');

  await db.open();
  print('Connected to MonggoDb');

  final users = db.collection('users');
  //create test
  var id = await users.insertOne({'username': 'jesie', 'password': '1234'});

  print('Inserted ID: ${id.id}');
}
