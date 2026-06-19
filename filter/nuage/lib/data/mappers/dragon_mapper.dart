import 'package:nuage/data/mappers/adventure_gauge_mapper.dart';
import 'package:nuage/domain/entities/dragon.dart';
import 'package:nuage/domain/entities/dragon_status.dart';
import 'package:nuage/domain/entities/level.dart';

class DragonMapper {
  static Dragon fromJson(Map<String, dynamic> json) => Dragon(
    id: json['id'] as String,
    name: json['name'] as String? ?? '',
    age: json['age'] as String? ?? '0',
    level: Level.values.byName(json['level'] as String),
    currentExp: json['current_exp'] as int? ?? 0,
    dragonStatus: DragonStatus.values.byName(json['dragon_status'] as String),
    adventureGauge: AdventureGaugeMapper.fromJson(
      json['adventure_gauge'],
    ), // VO
    adventureEndsAt: json['adventure_ends_at'] == null
        ? null
        : DateTime.parse(json['adventure_ends_at'] as String),
  );

  static Map<String, dynamic> toJson(Dragon dragon) => {
    'id': dragon.id,
    'name': dragon.name,
    'age': dragon.age,
    'level': dragon.level.name,
    'current_exp': dragon.currentExp,
    'dragon_status': dragon.dragonStatus.name,
    'adventure_gauge': AdventureGaugeMapper.toJson(dragon.adventureGauge),
    'adventure_ends_at': dragon.adventureEndsAt?.toIso8601String(),
  };
}
