import 'models/best_match.dart';
import 'models/rating.dart';

/// Finds degree of similarity between two strings, based on Dice's Coefficient, which is mostly better than Levenshtein distance.
class StringSimilarity {
  /// Returns a fraction between 0 and 1, which indicates the degree of similarity between the two strings. 0 indicates completely different strings, 1 indicates identical strings. The comparison is case-sensitive.
  ///
  /// _(same as 'string'.similarityTo extension method)_
  ///
  /// ##### Arguments
  /// - first (String?): The first string
  /// - second (String?): The second string
  ///
  /// (Order does not make a difference)
  ///
  /// ##### Returns
  /// (number): A fraction from 0 to 1, both inclusive. Higher number indicates more similarity.
  static double compareTwoStrings<T>(T? first, T? second,
      [String? Function(T? it)? transform]) {
    transform ??= (it) => it is String ? it : it.toString();
    // if both are null
    var firstStr = transform(first);
    var secondStr = transform(second);
    if (firstStr == null && secondStr == null) {
      return 1;
    }
    // as both are not null if one of them is null then return 0
    if (firstStr == null || secondStr == null) {
      return 0;
    }

    firstStr =
        firstStr.replaceAll(RegExp(r'\s+\b|\b\s'), ''); // remove all whitespace
    secondStr = secondStr.replaceAll(
        RegExp(r'\s+\b|\b\s'), ''); // remove all whitespace

    // if both are empty strings
    if (firstStr.isEmpty && secondStr.isEmpty) {
      return 1;
    }
    // if only one is empty string
    if (firstStr.isEmpty || secondStr.isEmpty) {
      return 0;
    }
    // identical
    if (firstStr == secondStr) {
      return 1;
    }
    // both are 1-letter strings
    if (firstStr.length == 1 && secondStr.length == 1) {
      return 0;
    }
    // if either is a 1-letter string
    if (firstStr.length < 2 || secondStr.length < 2) {
      return 0;
    }

    final firstBigrams = <String, int>{};
    for (var i = 0; i < firstStr.length - 1; i++) {
      final bigram = firstStr.substring(i, i + 2);
      final count =
          firstBigrams.containsKey(bigram) ? firstBigrams[bigram]! + 1 : 1;
      firstBigrams[bigram] = count;
    }

    var intersectionSize = 0;
    for (var i = 0; i < secondStr.length - 1; i++) {
      final bigram = secondStr.substring(i, i + 2);
      final count =
          firstBigrams.containsKey(bigram) ? firstBigrams[bigram]! : 0;

      if (count > 0) {
        firstBigrams[bigram] = count - 1;
        intersectionSize++;
      }
    }

    return (2.0 * intersectionSize) / (firstStr.length + secondStr.length - 2);
  }

  /// Compares mainString against each string in targetStrings
  ///
  /// _(same as 'string'.bestMatch extension method)_
  ///
  /// ##### Arguments
  /// - mainString (String?): The string to match each target string against.
  /// - targetStrings (List<String?>): Each string in this array will be matched against the main string.
  ///
  /// ##### Returns
  /// (BestMatch): An object with a ratings property, which gives a similarity rating for each target string, a bestMatch property, which specifies which target string was most similar to the main string, and a bestMatchIndex property, which specifies the index of the bestMatch in the targetStrings array.
  static BestMatch<T> findBestMatch<T>(T? mainString, List<T?> targetStrings,
      [String? Function(T? it)? transform]) {
    final ratings = <Rating<T>>[];
    var bestMatchIndex = 0;

    for (var i = 0; i < targetStrings.length; i++) {
      final currentTargetString = targetStrings[i];
      final currentRating =
          compareTwoStrings(mainString, currentTargetString, transform);
      ratings.add(Rating(target: currentTargetString, rating: currentRating));
      if (currentRating > ratings[bestMatchIndex].rating!) {
        bestMatchIndex = i;
      }
    }

    final bestMatch = ratings[bestMatchIndex];

    return BestMatch(ratings: ratings, bestMatch: bestMatch, bestMatchIndex: bestMatchIndex);
  }
}

