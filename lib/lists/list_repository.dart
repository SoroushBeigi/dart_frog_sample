import 'package:equatable/equatable.dart';

class TaskList extends Equatable {
  const TaskList({required this.id, required this.name});
  final String id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
