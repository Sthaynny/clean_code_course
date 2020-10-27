import 'package:clean_code_course/core/error/failure.dart';
import 'package:clean_code_course/core/usercases/usercasa.dart';
import 'package:clean_code_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_code_course/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class GetConcreteNumberTrivia implements UserCase<NumberTrivia, Params> {
  GetConcreteNumberTrivia(this.repository);
  final NumberTriviaRepository repository;

  // api.com/52
  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  Params({@required this.number});

  @override
  List<Object> get props => [number];
}
