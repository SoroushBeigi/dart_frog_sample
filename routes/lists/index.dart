import 'package:dart_frog/dart_frog.dart';

//curl --request GET --url http://localhost:8080/lists
Response onRequest(RequestContext context) {
  // TODO: implement route handler
  return Response(body: 'This is a new route for lists functionality!');
}
