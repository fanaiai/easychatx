import 'package:flutter/material.dart';

class GPT {
  // 字典id
  late int? id;
  late String role;
  late String content;
  late DateTime createdTime;
  late DateTime modifiedTime;

  GPT(
      {
      this.id,
      required this.role,
      required this.content,
      required this.createdTime,
      required this.modifiedTime});

  // 入库
  Map<String, dynamic> toMap() {
    var createdTimestamp = createdTime.microsecondsSinceEpoch;
    var modifiedTimestamp = modifiedTime.microsecondsSinceEpoch;

    return {
      'id': id,
      "role": role,
      'content': content,
      'created_time': createdTime,
      'modified_time': modifiedTime
    };
  }

// 出库
  factory GPT.fromMap(Map<String, dynamic> map) {
    var createdTimestamp = (map['created_time'] ?? 0) as int;
    var modifiedTimestamp = (map['modified_time'] ?? 0) as int;

    return GPT(
      id: map['id'] as int,
      role: map['role'] ??''as String,
      content: map['content'] ??'' as String,
      createdTime: DateTime.fromMillisecondsSinceEpoch(createdTimestamp),
      modifiedTime:
          DateTime.fromMillisecondsSinceEpoch(modifiedTimestamp),
    );
  }
}
