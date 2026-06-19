import 'package:nuage/data/mappers/task_mapper.dart';
import 'package:nuage/domain/entities/task.dart';
import 'package:nuage/domain/repositories/task_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TaskRepositoryImpl implements TaskRepository {
  final SupabaseClient _client;
  TaskRepositoryImpl(this._client);

  static const _table = 'tasks';

  @override
  Future<List<Task>> getTasks() async {
    final rows = await _client.from(_table).select();
    return rows.map(TaskMapper.fromJson).toList(); 
  }

  @override
  Future<void> addTask(Task task) async {
    await _client.from(_table).insert(TaskMapper.toJson(task)); 
  }

  @override
  Future<void> updateTask(Task task) async {
    await _client
        .from(_table)
        .update(TaskMapper.toJson(task))
        .eq('id', task.id);
  }

  @override
  Future<void> deleteTask(String id) async {
    await _client.from(_table).delete().eq('id', id);
  }
}
