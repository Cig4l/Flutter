import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuage/data/repositories/task_repository_impl.dart';
import 'package:nuage/domain/repositories/task_repository.dart';
import 'package:nuage/core/providers.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepositoryImpl(ref.read(supabaseClientProvider));
});