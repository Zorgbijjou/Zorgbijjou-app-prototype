import 'package:flutter_test/flutter_test.dart';
import 'package:theme/assets/tokens/grid_tokens.dart';

void main() {
  group('GridTokens', () {
    test('DefaultGridToken finds all grids', () {
      var tokens = DefaultGridTokens();

      expect(tokens.xs, equals(allGrids.elementAt(0)));
      expect(tokens.sm, equals(allGrids.elementAt(1)));
      expect(tokens.md, equals(allGrids.elementAt(2)));
      expect(tokens.lg, equals(allGrids.elementAt(3)));
      expect(tokens.xl, equals(allGrids.elementAt(4)));
    });
  });
}
