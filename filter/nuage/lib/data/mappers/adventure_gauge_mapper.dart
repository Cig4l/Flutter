import 'package:nuage/domain/entities/adventure_gauge.dart';

class AdventureGaugeMapper {
  static AdventureGauge fromJson(Map<String, dynamic> json) => AdventureGauge(
    id: json['id'] as String,
    currentScore: json['current_score'] as int? ?? 0,
    maxScore: json['max_score'] as int? ?? 5,
  );

  static Map<String, dynamic> toJson(AdventureGauge adventureGauge) => {
    'id': adventureGauge.id,
    'current_score': adventureGauge.currentScore,
    'max_score': adventureGauge.maxScore,
  };
}