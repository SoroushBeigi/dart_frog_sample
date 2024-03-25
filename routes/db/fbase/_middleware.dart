import 'package:dart_frog/dart_frog.dart';
import 'package:firedart/firedart.dart';

Handler middleware(Handler handler) {
  // TODO: implement middleware
  return (context)async {
    if(!Firestore.initialized) {
      Firestore.initialize('tasklist-dartfrog-cc1e0');
    }
    final response = await handler(context);
    return response;
  };
}
