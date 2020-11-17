import 'package:clean_code_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_code_course/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_code_course/features/number_trivia/domain/usercases/get_ramdom_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class NumberTriviaRepositoryMock extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetRandomNumberTrivia usercase;

  NumberTriviaRepositoryMock repositoryMock;

  setUp(() {
    repositoryMock = NumberTriviaRepositoryMock();

    usercase = GetRandomNumberTrivia(repositoryMock);
  });

  final tNumberTrivia = NumberTrivia(number: 1, text: 'test');

  test(
    'deve obter curiosidades sobre o número do repositório',
    () async {
      //organizar
      when(repositoryMock.getRandomNumberTrivia())
          .thenAnswer((_) async => Right(tNumberTrivia));

      //aja

      final result = await usercase(null);

      //afirmar

      expect(result, isA<Right>());
      expect(result.fold(id, id), equals(tNumberTrivia));
      verify(repositoryMock.getRandomNumberTrivia());
      verifyNoMoreInteractions(repositoryMock);
    },
  );
}
