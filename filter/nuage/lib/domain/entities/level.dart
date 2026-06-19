enum Level {
  one(level: 1, maxExp: 5),
  two(level: 2, maxExp: 7),
  three(level: 3, maxExp: 31);

  const Level({required this.level, required this.maxExp});
  final int level;
  final int maxExp;

  Level next() {
    switch(this) {
      case one: return two;
      case two: return three;
      case three: return three;   // TODO : no more gauge once level 3 completed
    }
  }
}