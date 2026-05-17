import 'package:mongo_dart/mongo_dart.dart';

Future<void> main() async {
  final db = await Db.create('mongodb://localhost:27017/local_db');

  await db.open();
  print('Connected to MonggoDb');

  final users = db.collection('users');

  //update test
  var deleteResult = await users.deleteOne(where.eq('username', 'jesie'));

  print('\nDeleted: ${deleteResult.isSuccess}');

  // Close DB
  await db.close();

  print('\nConnection closed');
}
