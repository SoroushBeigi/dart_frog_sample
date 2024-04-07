import 'package:dart_frog/dart_frog.dart';
import 'package:redis/redis.dart';
import 'package:tasklist_backend/secrets/secrets.dart';

final connection = RedisConnection();

Handler middleware(Handler handler) {
  return (context) async {
    Response response;
    try {
      final command = await connection.connect('localhost', 12000);
      try {
        await command
            .send_object(['AUTH', Secrets.redisPassword]);
        response = await handler
            .use(
              provider<Command>(
                (_) => command,
              ),
            )
            .call(context);
      } catch (e) {
        response = Response.json(body: {'error': 'Authentication went wrong '});
      }
    } catch (e) {
      response = Response.json(body: {'error': 'Something went wrong '});
    }
    return response;
  };
}
