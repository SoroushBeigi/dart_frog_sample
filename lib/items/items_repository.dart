import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:tasklist_backend/hash_extension.dart';

part 'items_repository.g.dart';

@visibleForTesting
Map<String, TaskItem> itemDB = {};

@JsonSerializable()
class TaskItem extends Equatable {
  const TaskItem(
      {required this.id,
      required this.listId,
      required this.desc,
      required this.status,
      required this.name});

  factory TaskItem.fromJson(Map<String, dynamic> json) =>
      _$TaskItemFromJson(json);

  TaskItem copyWith({
    String? id,
    String? name,
    String? listId,
    String? desc,
    bool? status,
  }) {
    return TaskItem(
        id: id ?? this.id,
        name: name ?? this.name,
        desc: desc ?? this.desc,
        listId: listId ?? this.listId,
        status: status ?? this.status);
  }

  final String id;
  final String listId;
  final String name;
  final String desc;
  final bool status;

  Map<String, dynamic> toJson() => _$TaskItemToJson(this);

  @override
  List<Object?> get props => [id, name];
}

class TaskItemRepository {
  Future<TaskItem?> itemById(String id) async {
    return itemDB[id];
  }

  Map<String, dynamic> getAllLists() {
    final encodedList = <String, dynamic>{};
    if (itemDB.isNotEmpty) {
      itemDB.forEach((key, value) {
        final currList = itemDB[key];
        encodedList[key] = currList?.toJson();
      });
    }
    return encodedList;
  }

  String createItem(
      {required String name,
      required String listId,
      required String desc,
      required bool status}) {
    final id = name.hashValue;
    final taskItem = TaskItem(
      id: id,
      name: name,
      desc: desc,
      listId: listId,
      status: status,
    );
    itemDB[id] = taskItem;
    return id;
  }

  void deleteItem({required String id}) {
    itemDB.remove(id);
  }

  Future<void> updateItem({
    required String id,
    required String name,
    required String listId,
    required String desc,
    required bool status,
  }) async {
    final currItem = itemDB[id];

    if (currItem == null) {
      return Future.error(Exception('Item not found!'));
    }
   itemDB[id]= TaskItem(
      id: id,
      name: name,
      desc: desc,
      listId: listId,
      status: status,
    );
  }
}
