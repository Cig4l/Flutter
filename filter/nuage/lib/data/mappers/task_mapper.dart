import '../../domain/entities/task.dart';
import '../../domain/entities/task_category.dart';

class TaskMapper {
  static Task fromJson(Map<String, dynamic> json) => Task(
    id: json['id'] as String,
    title: json['title'] as String,
    icon: json['icon'] as String,
    category: TaskCategory.values.byName(json['category'] as String),
    completedAt: json['completed_at'] == null
        ? null
        : DateTime.parse(json['completed_at'] as String),
  );

  static Map<String, dynamic> toJson(Task task) => {
    'id': task.id,
    'title': task.title,
    'icon': task.icon,
    'category': task.category.name,
    'completed_at': task.completedAt?.toIso8601String(),
  };
}