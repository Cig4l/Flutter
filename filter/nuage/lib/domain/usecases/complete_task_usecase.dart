import 'package:nuage/domain/entities/dragon.dart';
import 'package:nuage/domain/entities/task.dart';
import 'package:nuage/domain/repositories/dragon_repository.dart';
import 'package:nuage/domain/repositories/task_repository.dart';

class CompleteTaskUsecase {
  final Dragon dragon;
  final bool leveledUp;

  const CompleteTaskUsecase({required this.dragon, required this.leveledUp});  // event level up
}

class CompleteTaskUseCase {
  final TaskRepository _taskRepository;
  final DragonRepository _dragonRepository;

  const CompleteTaskUseCase(this._taskRepository, this._dragonRepository);

  Future<CompleteTaskUsecase> call(Task task, Dragon dragon) async {
    final doneTask = task.markDone();
    final updatedDragon = dragon.gainExp();
    final leveledUp = updatedDragon.level != dragon.level;

    // persistence
    await _taskRepository.updateTask(doneTask);
    await _dragonRepository.updateDragon(updatedDragon);

    return CompleteTaskUsecase(dragon: updatedDragon, leveledUp: leveledUp);
  }
}