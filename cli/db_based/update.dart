import 'package:mongo_dart/mongo_dart.dart';

Future<void> main() async {
  final db = await Db.create('mongodb://localhost:27017/local_db');

  await db.open();
  print('Connected to MonggoDb');

  final users = db.collection('users');
  //update test
  var updateResult = await users.updateOne(
    where.eq('username', 'edbar'),
    modify.set('password', 'otendako'),
  );

  print('\nUpdated: ${updateResult.isSuccess}');
}
