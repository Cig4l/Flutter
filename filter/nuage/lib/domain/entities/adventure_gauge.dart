class AdventureGauge {
  final String id;
  final int currentScore;
  final int maxScore;
  const AdventureGauge({
    required this.id,
    required this.currentScore,
    required this.maxScore,
  });
  bool get isFull => this.currentScore >= this.maxScore;

  AdventureGauge refreshScore() {
    if (isFull) {
      return this.copyWith(currentScore: 0);
    }
    return this.copyWith(currentScore: this.currentScore + 1);
  }

  AdventureGauge copyWith({String? id, int? currentScore, int? maxScore}) {
    return AdventureGauge(
      id: id ?? this.id,
      currentScore: currentScore ?? this.currentScore,
      maxScore: maxScore ?? this.maxScore,
    );
  }
}
