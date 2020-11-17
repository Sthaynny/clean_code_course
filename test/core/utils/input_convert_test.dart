import 'package:clean_code_course/core/utils/input_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInt', () {
    test(
      'should return an integer when the string represents an unsigned integer',
      () async {
        // arrange
        const str = '123';
        // act
        final result = inputConverter.stringToUnsignedInteger(str);
        // assert
        expect(result, 123);
      },
    );
  });

  test(
    'should return a failure when the string is not an integer',
    () async {
      // arrange
      const str = 'abc';
      // act
      final result = inputConverter.stringToUnsignedInteger(str);
      // assert
      expect(result, InvalidInputFailure());
    },
  );
  test(
    'should return a failure when the string is a negative integer',
    () async {
      // arrange
      const str = '-123';
      // act
      final result = inputConverter.stringToUnsignedInteger(str);
      // assert
      expect(result, InvalidInputFailure());
    },
  );
}
