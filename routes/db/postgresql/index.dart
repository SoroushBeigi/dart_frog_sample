import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context)async {
  return switch(context.request.method){
    HttpMethod.get=>_getLists(context),
    HttpMethod.post=>_createList(context),
    _=>Future.value(Response(statusCode: HttpStatus.methodNotAllowed));
  };
}

Future<Response> _getLists(RequestContext context)async{
//TODO: implement getLists
}
Future<Response> _createList(RequestContext context)async{
  //TODO: implement createList
}
