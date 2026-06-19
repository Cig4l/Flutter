import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuage/data/repositories/task_repository_impl.dart';
import 'package:nuage/domain/repositories/task_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepositoryImpl(ref.read(supabaseClientProvider));
});