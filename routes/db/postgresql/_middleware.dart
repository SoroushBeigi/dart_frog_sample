import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';
import 'package:tasklist_backend/secrets/secrets.dart';

Handler middleware(Handler handler) {
  return (context) async {
    //The default value for port is 5432, so we don't need to specify it here.
    final connection = await Connection.open(
      Endpoint(
        host: 'localhost',
        database: 'mytasklist',
        username: 'postgres',
        password: Secrets.postgressPass,
      ),
    );
    final response = await handler
        .use(provider<Connection>((_) => connection))
        .call(context);
  };
}
