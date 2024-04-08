import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/repository/user/user_repository.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';

Handler middleware(Handler handler) {
  return handler
      .use(provider<UserRepository>((context) => UserRepository()))
      .use(
    basicAuthentication<User>(
      authenticator: (context, username, password) {
        final repository = context.read<UserRepository>();
        return repository.userFromCredentials(username, password);
      },
      applies: (RequestContext context)async =>
        context.request.method!= HttpMethod.post,
    
    ),
  );
}
