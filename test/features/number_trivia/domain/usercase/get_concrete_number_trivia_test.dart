import 'package:clean_code_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_code_course/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_code_course/features/number_trivia/domain/usercases/get_concrete_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class NumberTriviaRepositoryMock extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetConcreteNumberTrivia usercase;

  NumberTriviaRepositoryMock repositoryMock;

  setUp(() {
    repositoryMock = NumberTriviaRepositoryMock();

    usercase = GetConcreteNumberTrivia(repositoryMock);
  });

  final tnumber = 1;
  final tNumberTrivia = NumberTrivia(number: 1, text: 'test');

  test(
    'deve obter curiosidades sobre o número do repositório',
    () async {
      //organizar
      when(repositoryMock.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));

      //aja

      final result = await usercase(Params(number: tnumber));

      //afirmar

      expect(result, Right(tNumberTrivia));
      verify(repositoryMock.getConcreteNumberTrivia(tnumber));
      verifyNoMoreInteractions(repositoryMock);
    },
  );
}
