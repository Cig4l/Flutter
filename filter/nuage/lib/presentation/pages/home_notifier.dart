import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';

import 'package:nuage/domain/entities/dragon.dart';
import 'package:nuage/domain/entities/task.dart';
import 'package:nuage/domain/entities/task_category.dart';
import 'package:nuage/core/providers.dart';
import 'package:uuid/uuid.dart';

// Equatable => package that compares objects by content instead of by identity

class HomeData extends Equatable {
  final Dragon dragon;
  final List<Task> tasks;

  const HomeData({required this.dragon, required this.tasks});

  bool get hasNoTasks => tasks.isEmpty;

  List<Task> get visibleTasks => tasks.where((t) => t.isVisible).toList();

  Map<TaskCategory, List<Task>> get groupedTasks {
    final grouped = <TaskCategory, List<Task>>{};
    for (final task in visibleTasks) {
      grouped.putIfAbsent(task.category, () => <Task>[]).add(task);
    }
    return grouped;
  }

  HomeData copyWith({Dragon? dragon, List<Task>? tasks}) =>
      HomeData(dragon: dragon ?? this.dragon, tasks: tasks ?? this.tasks);

  @override
  List<Object?> get props => [dragon, tasks];
}

class HomeNotifier extends AsyncNotifier<HomeData> {
  @override
  Future<HomeData> build() async {
    // initial loading called by Riverpod the first time the UI ckecks the provider
    final dragon = await ref.read(dragonRepositoryProvider).getDragon();
    final tasks = await ref.read(taskRepositoryProvider).getTasks();
    return HomeData(dragon: dragon, tasks: tasks);
  }

  Future<void> deleteTask(Task task) async {
    final current = state.value;
    if (current == null) return;

    final updated = current.tasks.where((t) => t.id != task.id).toList();
    state = AsyncData(current.copyWith(tasks: updated));

    await ref.read(taskRepositoryProvider).deleteTask(task.id);
  }

  Future<void> updateTask(Task updated) async {
    final current = state.value;
    if (current == null) return;

    final tasks = current.tasks
        .map((t) => t.id == updated.id ? updated : t)
        .toList();
    state = AsyncData(current.copyWith(tasks: tasks));

    await ref.read(taskRepositoryProvider).updateTask(updated);
  }

  Future<void> addTask({
    required String title,
    required TaskCategory category,
  }) async {
    final current = state.value;
    if (current == null) return;

    final task = Task(
      id: const Uuid().v4(),
      title: title,
      category: category,
      completedAt: null,
    );

    await ref.read(taskRepositoryProvider).addTask(task);
    state = AsyncData(current.copyWith(tasks: [...current.tasks, task]));
  }

  Future<void> completeTask(Task task) async {
    final currentHomeData = state.value;
    if (currentHomeData == null) return;

    final markedTasks = currentHomeData.tasks
        .map((t) => t.id == task.id ? t.markDone() : t)
        .toList();
    state = AsyncData(currentHomeData.copyWith(tasks: markedTasks));

    final result = await ref.read(completeTaskUseCaseProvider)(
      task,
      currentHomeData.dragon,
    );

    if (!ref.mounted) return;
    state = AsyncData(
      currentHomeData.copyWith(tasks: markedTasks, dragon: result.dragon),
    );
  }

  Future<void> renameDragon(String name) async {
    final current = state.value;
    if (current == null) return;

    final updatedDragon = current.dragon.copyWith(name: name);

    await ref.read(dragonRepositoryProvider).updateDragon(updatedDragon);
    if (!ref.mounted) return;

    state = AsyncData(HomeData(dragon: updatedDragon, tasks: current.tasks));
  }
}

final homeProvider = AsyncNotifierProvider<HomeNotifier, HomeData>(
  HomeNotifier.new,
);
