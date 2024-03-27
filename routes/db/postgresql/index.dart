import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => _getLists(context),
    HttpMethod.post => _createList(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}

Future<Response> _getLists(RequestContext context) async {
  final lists = <Map<String, dynamic>>[];
  final queryResult =
      await context.read<Connection>().execute('SELECT id , name FROM lists');
  for (final row in queryResult) {
    lists.add({'id': row[0], 'name': row[1]});
  }
  return Response.json(body: lists.toString());
}

Future<Response> _createList(RequestContext context) async {
  //TODO: implement createList
}
