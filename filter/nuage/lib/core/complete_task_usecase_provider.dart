import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuage/core/dragon_repository_provider.dart';
import 'package:nuage/core/task_repository_provider.dart';
import 'package:nuage/domain/usecases/complete_task_usecase.dart';

final completeTaskUseCaseProvider = Provider<CompleteTaskUseCase>((ref) {
  return CompleteTaskUseCase(
    ref.read(taskRepositoryProvider),
    ref.read(dragonRepositoryProvider),
  );
});