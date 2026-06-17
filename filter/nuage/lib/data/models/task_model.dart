import 'package:nuage/domain/entities/task.dart';

class TaskModel extends Task {
  const TaskModel({
    required super.id,
    required super.title,
    required super.category,
    required super.iconPath,
    required super.isDone,
  });
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      iconPath: json['icon_path'],
      isDone: json['is_done'] ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'category': category, 'icon_path': iconPath, 'is_done': isDone};
  }
}
