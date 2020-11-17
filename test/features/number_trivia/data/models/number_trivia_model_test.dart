import 'dart:convert';

import 'package:clean_code_course/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_code_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumeberTriviaModel = NumberTriviaModel(number: 1, text: 'test text');

  setUp(() {});

  test(
    'deve obter a sub classe de NumberTrivia Entity',
    () async {
      //organizar

      //aja

      //afirmar
      expect(tNumeberTriviaModel, isA<NumberTrivia>());
    },
  );

  group('fromJson', () {
    test('deve retornar um modelo valido de um numero inteiro', () {
      //organizar
      final Map<String, dynamic> jsonMap = jsonDecode(fixture('trivia'));
      //aja
      final result = NumberTriviaModel.fromJson(jsonMap);
      //afirmar

      expect(result, equals(tNumeberTriviaModel));
    });
    test('deve retornar um modelo valido de um numero real', () {
      //organizar
      final Map<String, dynamic> jsonMap = jsonDecode(fixture('trivia_double'));
      //aja
      final result = NumberTriviaModel.fromJson(jsonMap);
      //afirmar

      expect(result, equals(tNumeberTriviaModel));
    });
  });

  group('toJson', () {
    test('deve retornar um json Map', () {
      //aja
      final result = tNumeberTriviaModel.toJson();
      //afirmar

      final mapExpect = {
        'text': 'test text',
        'number': 1,
      };

      expect(result, mapExpect);
    });
  });
}
