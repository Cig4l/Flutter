import 'package:nuage/core/app_images.dart';
import 'package:nuage/domain/entities/dragon.dart';
import 'package:nuage/domain/entities/level.dart';

sealed class DragonStage {
  const DragonStage();

  String get backgroundAsset;

  String get dragonAsset;

  String get label;

  bool get isHatching => false;
}

final class EggStage extends DragonStage {
  const EggStage();

  @override
  String get backgroundAsset => AppImages.backgrounds.egg;

  @override
  String get dragonAsset => AppImages.dragon.egg;

  @override
  String get label => 'Egg';

  @override
  bool get isHatching => true;
}

final class BabyStage extends DragonStage {
  const BabyStage();

  @override
  String get backgroundAsset => AppImages.backgrounds.baby;

  @override
  String get dragonAsset => AppImages.dragon.baby;

  @override
  String get label => 'Baby';
}

final class TeenStage extends DragonStage {
  const TeenStage();

  @override
  String get backgroundAsset => AppImages.backgrounds.teen;

  @override
  String get dragonAsset => AppImages.dragon.teen;

  @override
  String get label => 'Teen';
}

final class AdultStage extends DragonStage {
  const AdultStage();

  @override
  String get backgroundAsset => AppImages.backgrounds.adult;

  @override
  String get dragonAsset => AppImages.dragon.adult;

  @override
  String get label => 'Adult';
}

extension LevelStage on Level {
  DragonStage get stage => switch (this) {
    Level.one => const EggStage(),
    Level.two => const BabyStage(),
    Level.three => const TeenStage(),
    Level.four => const AdultStage(),
  };
}

/// Shortcut : `dragon.stage.backgroundAsset`.
extension DragonStageX on Dragon {
  DragonStage get stage => level.stage;
}