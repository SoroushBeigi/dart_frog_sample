import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:tasklist_backend/hash_extension.dart';

part 'list_repository.g.dart';

@visibleForTesting
Map<String, TaskList> listDB = {};

@JsonSerializable()
class TaskList extends Equatable {
  const TaskList({required this.id, required this.name});

  factory TaskList.fromJson(Map<String, dynamic> json) =>
      _$TaskListFromJson(json);

  TaskList copyWith({
    String? id,
    String? name,
  }) {
    return TaskList(id: id ?? this.id, name: name ?? this.name);
  }

  final String id;
  final String name;

  Map<String, dynamic> toJson() => _$TaskListToJson(this);

  @override
  List<Object?> get props => [id, name];
}

class TaskListRepository {
  Future<TaskList?> listById(String id) async {
    return listDB[id];
  }

  Map<String, dynamic> getAllLists() {
    final encodedList = <String, dynamic>{};
    if (listDB.isNotEmpty) {
      listDB.forEach((key, value) {
        final currList = listDB[key];
        encodedList[key] = currList?.toJson();
      });
    }
    return encodedList;
  }

  String createList({required String name}) {
    final id = name.hashValue;
    final taskList = TaskList(id: id, name: name);
    listDB[id] = taskList;
    return id;
  }

  void deleteList({required String id}) {
    listDB.remove(id);
  }

  Future<void> updateList({required String id, required String name}) async {
    final currList = listDB[id];

    if (currList == null) {
      return Future.error(Exception('List not found!'));
    }
    listDB[id] = TaskList(id: id, name: name);
  }
}
