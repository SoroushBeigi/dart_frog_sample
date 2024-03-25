import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:firedart/firedart.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) {
  return switch (context.request.method) {
    HttpMethod.patch => _updateList(context, id),
    HttpMethod.delete => _deleteList(context, id),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed))
  };
}

Future<Response> _updateList(RequestContext context, String id) async {
  final body = await context.request.json() as Map<String, dynamic>;
  final name = body['name'] as String;
  await Firestore.instance
      .collection('tasklist')
      .document(id)
      .update({'name': name});
  return Response(statusCode: HttpStatus.noContent);
}

Future<Response> _deleteList(RequestContext context, String id) async {
  await Firestore.instance.collection('tasklist').document(id).delete().then(
      (value) {
    return Response(statusCode: HttpStatus.noContent);
  }, onError: (e) => Response(statusCode: HttpStatus.badRequest));
  return Response(statusCode: HttpStatus.badRequest);
}
