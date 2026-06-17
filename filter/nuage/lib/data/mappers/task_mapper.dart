import '../../domain/entities/task.dart';
import '../../domain/entities/task_category.dart';

// mapper = raw translator between domain (Task) and Supabase (JSON)

class TaskMapper {
  static Task fromJson(Map<String, dynamic> json) => Task(
    id: json['id'] as String,
    title: json['title'] as String,
    iconPath: json['icon_path'] as String,
    isDone: json['is_done'] as bool,
    category: TaskCategory.values.byName(json['category'] as String),
  );

  static Map<String, dynamic> toJson(Task task) => {
    'id': task.id,
    'title': task.title,
    'iconPath': task.iconPath,
    'is_done': task.isDone,
    'category': task.category.name,
  };
}
