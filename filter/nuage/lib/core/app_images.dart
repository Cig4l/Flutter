abstract final class AppImages {
  AppImages._();

  static const base = 'assets/images/dragon';

  static const dragon = _Dragon();
  static const backgrounds = _Backgrounds();

  static const avatar = '$base/dragon-avatar.jpg';
  static const crackedEgg = '$base/cracked-egg.png';
}

final class _Dragon {
  const _Dragon();

  static const _base = 'assets/images/dragon/levels';
  final String egg = '$_base/egg.png';
  final String baby = '$_base/baby.png';
  final String teen = '$_base/teen.png';
  final String adult = '$_base/adult.png';
}

final class _Backgrounds {
  const _Backgrounds();

  static const _base = 'assets/images/backgrounds';

  final String egg = '$_base/egg-bg.jpg';
  final String baby = '$_base/baby-bg.jpg';
  final String teen = '$_base/teen-bg.jpg';
  final String adult = '$_base/adult-bg.jpg';
}
