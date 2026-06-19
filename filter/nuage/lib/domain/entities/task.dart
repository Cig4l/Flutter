import 'package:nuage/domain/entities/task_category.dart';
import 'package:clock/clock.dart';

class Task {
  final String id;
  final String title;
  final TaskCategory category;
  final DateTime? completedAt;
  const Task({
    required this.id,
    required this.title,
    required this.category,
    required this.completedAt,
  });

  bool get isDone {
    final c = completedAt?.toLocal();
    final now = clock.now();
    return c != null &&
        c.day == now.day &&
        c.month == now.month &&
        c.year == now.year;
  }

  bool get isVisible {
    return !isDone;
  }

  Task markDone() => copyWith(completedAt: clock.now());

  Task copyWith({
    String? id,
    String? title,
    TaskCategory? category,
    DateTime? completedAt,
    String? icon,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}
