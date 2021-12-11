import '../../string_similarity.dart';

extension TypeExtensions<I> on I? {
  /// Returns a fraction between 0 and 1, which indicates the degree of similarity between the two strings. 0 indicates completely different strings, 1 indicates identical strings. The comparison is case-sensitive.
  ///
  /// _(same as StringSimilarity.compareTwoStrings method)_
  ///
  /// ##### Arguments
  /// - other (String?): The second string
  ///
  /// (Order does not make a difference)
  ///
  /// ##### Returns
  /// (number): A fraction from 0 to 1, both inclusive. Higher number indicates more similarity.
  double similarityTo<T>(T? other,
          {String? Function(I? it)? firstTransform,
          String? Function(T? it)? secondTransform}) =>
      StringSimilarity.compareTwoStrings<I, T>(this, other,
          firstTransform: firstTransform, secondTransform: secondTransform);

  /// Compares mainString against each string in targetStrings.
  ///
  /// _(same as StringSimilarity.findBestMatch method)_
  ///
  /// ##### Arguments
  /// - targetStrings (List<String?>): Each string in this array will be matched against the main string.
  ///
  /// ##### Returns
  /// (BestMatch): An object with a ratings property, which gives a similarity rating for each target string, a bestMatch property, which specifies which target string was most similar to the main string, and a bestMatchIndex property, which specifies the index of the bestMatch in the targetStrings array.
  BestMatch<T> findBestMatch<T>(List<T?> targetStrings,
          {String? Function(I? it)? mainTransform,
          String? Function(T? it)? targetTransform}) =>
      StringSimilarity.findBestMatch<I, T>(this, targetStrings,
          mainTransform: mainTransform, targetTransform: targetTransform);
}
