/// Dice's Coefficient result
class Rating<T> {
  Rating({this.target, this.rating});

  /// reference text
  T? target;

  /// between 0 and 1. 0 indicates completely different strings, 1 indicates identical strings.
  double? rating;

  @override
  String toString() => '\'$target\'[$rating]';
}
