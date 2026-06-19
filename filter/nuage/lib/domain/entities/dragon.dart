import 'package:nuage/domain/entities/adventure_gauge.dart';
import 'package:nuage/domain/entities/dragon_status.dart';
import 'package:nuage/domain/entities/level.dart';
import 'package:nuage/domain/entities/task.dart';

class Dragon {
  final String id;
  final String name;
  final String age; // in days
  final Level level;
  final int currentExp;
  final DragonStatus dragonStatus;
  final AdventureGauge adventureGauge;
  final DateTime? adventureEndsAt;

  static const adventureDuration = Duration(hours: 1);

  const Dragon({
    required this.id,
    required this.name,
    required this.age,
    required this.level,
    required this.currentExp,
    required this.dragonStatus,
    required this.adventureGauge,
    required this.adventureEndsAt,
  });

  bool get isAdventureReady => adventureGauge.isFull;
  bool get isReadyToEvolve => currentExp >= level.maxExp;

  Dragon gainExp() {
    final updatedDragon = copyWith(currentExp: this.currentExp + 1);

    if (updatedDragon.isReadyToEvolve) {
      return updatedDragon.copyWith(dragonStatus: DragonStatus.evolving);
    }
    return updatedDragon;
  }

  Dragon evolve() {
    return copyWith(
      currentExp: 0,
      dragonStatus: DragonStatus.resting,
      level: level.next(),
    );
  }

  Dragon startAdventure() {
    if (!isAdventureReady) {
      return this;
    }
    return copyWith(
      dragonStatus: DragonStatus.exploring,
      adventureGauge: adventureGauge.refreshScore(),
    );
  }

  Dragon refreshAdventure(DateTime now) {
    if (this.dragonStatus == DragonStatus.exploring &&
        now.isAfter(adventureEndsAt!)) {
      return copyWith(
        dragonStatus: DragonStatus.back_from_adventure,
        adventureEndsAt: null,
      );
    }
    return this;
  }

  Dragon copyWith({
    String? id,
    String? name,
    String? age,
    Level? level,
    int? currentExp,
    DragonStatus? dragonStatus,
    AdventureGauge? adventureGauge,
    DateTime? adventureEndsAt,
    List<Task>? tasks
  }) {
    return Dragon(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      level: level ?? this.level,
      currentExp: currentExp ?? this.currentExp,
      dragonStatus: dragonStatus ?? this.dragonStatus,
      adventureGauge: adventureGauge ?? this.adventureGauge,
      adventureEndsAt: adventureEndsAt ?? this.adventureEndsAt,
    );
  }
}
