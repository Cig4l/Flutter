enum Level {
  one(level: 1, maxExp: 1),
  two(level: 2, maxExp: 10),
  three(level: 3, maxExp: 100),
  four(level: 4, maxExp: 1000);

  const Level({required this.level, required this.maxExp});
  final int level;
  final int maxExp;

  Level next() {
    switch(this) {
      case one: return two;
      case two: return three;
      case three: return four;
      case four: return four;
    }
  }
}