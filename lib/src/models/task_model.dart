/*
 * TaskModel
 * Modelo de tarea 
 */

import 'dart:convert';

class TaskModel {

    int? id;
    String? title;
    int? isCompleted;
    String? dueDate;
    String? comments;
    String? description;
    String? tags;
    String? token;
    String? createdAt;
    String? updatedAt;

    TaskModel({
      this.id,
      this.title,
      this.isCompleted,
      this.dueDate,
      this.comments,
      this.description,
      this.tags,
      this.token,
      this.createdAt,
      this.updatedAt,
    });

    factory TaskModel.fromRawJson(String str) => TaskModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TaskModel.fromJson(Map<String, dynamic> json) {

      

      return TaskModel(
        id: json["id"],
        title: json["title"] as String,
        isCompleted: json["is_completed"] ?? 0,
        dueDate: json["due_date"] as String?,
        comments: json["comments"] as String?,
        description: json["description"] as String?,
        tags: json["tags"] as String?,
        token: json["token"] as String?
      );
    }

    Map<String, String> toJson() => {
        "title": title ?? '',
        "is_completed": '$isCompleted',
        "due_date": dueDate ?? '',
        "comments": comments ?? '',
        "description": description ?? '',
        "tags": tags ?? ''
    };
}
