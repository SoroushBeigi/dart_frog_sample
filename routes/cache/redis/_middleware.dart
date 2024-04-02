import 'package:dart_frog/dart_frog.dart';

String? greeting; //Temp storage, aka cache!
Handler middleware(Handler handler) {
  return handler.use(provider<String>((context) => greeting ?? 'Hello'));
}
