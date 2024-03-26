import 'package:dart_frog/dart_frog.dart';
import 'package:firedart/firedart.dart';
import 'package:tasklist_backend/secrets/secrets.dart';

Handler middleware(Handler handler) {
  // TODO: implement middleware
  return (context)async {
    if(!Firestore.initialized) {
      Firestore.initialize(Secrets.firebaseSecret);
    }
    final response = await handler(context);
    return response;
  };
}
