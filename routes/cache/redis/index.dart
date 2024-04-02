import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:redis/redis.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => _getLoginStatus(context),
    // HttpMethod.post => _setLoginStatus(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}

Future<Response> _getLoginStatus(RequestContext context) async {
  final result = await context
      .read<Command>()
      .send_object(['GET', 'loggedIn']).then((value) => value);
      if(result==null){
        const status = 0;
        await context.read<Command>().send_object(['SET','loggedIn',status]);
        return Response(statusCode: HttpStatus.noContent);
      }else{
        return Response.json(body: result.toString());
      }
}

// Future<Response> _setLoginStatus(RequestContext context) async {}
