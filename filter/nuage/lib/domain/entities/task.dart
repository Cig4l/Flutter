import 'package:nuage/domain/entities/task_category.dart';

class Task {
  final String id;
  final String title;
  final TaskCategory category;
  final String iconPath;
  final bool isDone;
  const Task({
    required this.id,
    required this.title,
    required this.category,
    required this.iconPath,
    required this.isDone,
  });
}
