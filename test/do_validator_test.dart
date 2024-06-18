import 'package:do_validator/do_validator.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final bool validation = documentValidator('12345678901');

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      expect(validation, false);
    });
  });
}
