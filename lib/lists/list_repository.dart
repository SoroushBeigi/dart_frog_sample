import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'list_repository.g.dart';

@visibleForTesting
Map<String, TaskList> listDb = {};

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
