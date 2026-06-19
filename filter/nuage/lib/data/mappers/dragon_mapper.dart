import 'package:nuage/domain/entities/dragon.dart';
import 'package:nuage/domain/entities/level.dart';

class DragonMapper {
  static Dragon fromJson(Map<String, dynamic> json) => Dragon(
    id: json['id'] as String,
    name: json['name'] as String? ?? '',
    level: Level.values.byName(json['level'] as String),
    currentExp: json['current_exp'] as int? ?? 0,
  );

  static Map<String, dynamic> toJson(Dragon dragon) => {
    'id': dragon.id,
    'name': dragon.name,
    'level': dragon.level.name,
    'current_exp': dragon.currentExp,
  };
}