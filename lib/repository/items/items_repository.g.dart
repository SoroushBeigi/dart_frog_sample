// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskItem _$TaskItemFromJson(Map<String, dynamic> json) => TaskItem(
      id: json['id'] as String,
      listId: json['listId'] as String,
      desc: json['desc'] as String,
      status: json['status'] as bool,
      name: json['name'] as String,
    );

Map<String, dynamic> _$TaskItemToJson(TaskItem instance) => <String, dynamic>{
      'id': instance.id,
      'listId': instance.listId,
      'name': instance.name,
      'desc': instance.desc,
      'status': instance.status,
    };
