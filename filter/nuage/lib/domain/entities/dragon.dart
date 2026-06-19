import 'package:nuage/domain/entities/level.dart';

class Dragon {
  final String id;
  final String name;
  final Level level;
  final int currentExp;

  static const adventureDuration = Duration(hours: 1);

  const Dragon({
    required this.id,
    required this.name,
    required this.level,
    required this.currentExp,
  });

  factory Dragon.initial({required String dragonId}) => Dragon(
    id: dragonId, 
    name: '', 
    level: Level.one, 
    currentExp: 0
  );

  Dragon gainExp() {
    if(currentExp +1 < level.maxExp) {
      return copyWith(currentExp: this.currentExp + 1);
    }
    return copyWith(currentExp: 0, level: level.next());
  }

  Dragon copyWith({
    String? id,
    String? name,
    Level? level,
    int? currentExp,
  }) {
    return Dragon(
      id: id ?? this.id,
      name: name ?? this.name,
      level: level ?? this.level,
      currentExp: currentExp ?? this.currentExp,
    );
  }
}
