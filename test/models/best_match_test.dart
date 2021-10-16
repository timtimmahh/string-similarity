import 'package:string_similarity/string_similarity.dart';
import 'package:test/test.dart';

void main() {
  group('BestMatch', () {
    test('toString return "index:rating"', () {
      final bestRating = Rating<String>(rating: 1.23456, target: 'str');
      final bestMatch = BestMatch<String>(
          bestMatchIndex: 1,
          bestMatch: bestRating,
          ratings: <Rating<String>>[
            Rating<String>(rating: 0.01, target: 'str'),
            bestRating
          ]);

      expect(bestMatch.toString(), '1:\'str\'[1.23456]');
    });

    test('toString with null target return "index:rating"', () {
      final bestRating = Rating<String>(rating: 1.23456, target: null);
      final bestMatch = BestMatch<String>(
          bestMatchIndex: 1,
          bestMatch: bestRating,
          ratings: <Rating<String>>[
            Rating<String>(rating: 0.01, target: 'str'),
            bestRating
          ]);

      expect(bestMatch.toString(), '1:\'null\'[1.23456]');
    });
  });
}
