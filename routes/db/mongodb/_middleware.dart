import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:tasklist_backend/secrets/secrets.dart';

Handler middleware(Handler handler) {
  return (context) async{
    final db = await Db.create(Secrets.mongodbSecret);
  };
}
