import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';
import 'package:tasklist_backend/hash_extension.dart';

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
      await context.read<Connection>().execute('SELECT id , name FROM list');
  for (final row in queryResult) {
    lists.add({'id': row[0], 'name': row[1]});
  }
  return Response.json(body: lists.toString());
}

Future<Response> _createList(RequestContext context) async {
  final body = await context.request.json() as Map<String, dynamic>;
  final name = body['name'] as String?;
  final id = name?.hashValue;
  if (name != null) {
    try {
      final result = await context
          .read<Connection>()
          .execute("INSERT INTO list (id,name) VALUES ('$id','$name')");
      if (result.affectedRows == 1) {
        return Response.json(body: {'success': true});
      } else {
        return Response.json(body: {'success': false});
      }
    } catch (e) {
      return Response(statusCode: HttpStatus.connectionClosedWithoutResponse);
    }
  }
  return Response(statusCode: HttpStatus.badRequest);
}
