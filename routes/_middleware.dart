import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/items/items_repository.dart';
import 'package:tasklist_backend/lists/list_repository.dart';

Handler middleware(Handler handler) {
  // TODO: implement middleware
  return handler
      .use(requestLogger())
      .use(provider<TaskListRepository>((context) => TaskListRepository()))
      .use(provider<TaskItemRepository>((context) => TaskItemRepository()));
}
