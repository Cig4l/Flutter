import 'package:nuage/domain/entities/level.dart';

class Dragon {
  final String id;
  final String name;
  final String age; // in days
  final Level level;
  final int currentExp;

  static const adventureDuration = Duration(hours: 1);

  const Dragon({
    required this.id,
    required this.name,
    required this.age,
    required this.level,
    required this.currentExp,
  });

  bool get isReadyToEvolve => currentExp >= level.maxExp;

  Dragon gainExp() {
    if(currentExp < level.maxExp) {
      return copyWith(currentExp: this.currentExp + 1);
    }
    return this;
  }

  Dragon evolve() {
    if (isReadyToEvolve) {
      return copyWith(
        currentExp: 0,
        level: level.next(),
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
  }) {
    return Dragon(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      level: level ?? this.level,
      currentExp: currentExp ?? this.currentExp,
    );
  }
}
