import 'package:clean_code_course/core/error/failure.dart';
import 'package:clean_code_course/core/usercases/usercasa.dart';
import 'package:clean_code_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_code_course/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

class GetRandomNumberTrivia implements UserCase<NumberTrivia, NoParams> {
  GetRandomNumberTrivia(this.repository);
  final NumberTriviaRepository repository;

  // api.com/52
  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}
