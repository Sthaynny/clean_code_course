import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_code_course/core/error/failure.dart';
import 'package:clean_code_course/core/usercases/usercasa.dart';
import 'package:clean_code_course/core/utils/input_converter.dart';
import 'package:clean_code_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_code_course/features/number_trivia/domain/usercases/get_concrete_number_trivia.dart';
import 'package:clean_code_course/features/number_trivia/domain/usercases/get_ramdom_number_trivia.dart';
import 'package:clean_code_course/features/number_trivia/presentation/page/widgets/trivia_display_widget.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

//invalidInputFailureMessage
const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';
const String invalidInputFailureMessage =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  NumberTriviaBloc({
    @required GetConcreteNumberTrivia concrete,
    @required GetRandomNumberTrivia random,
    @required this.inputConverter,
  })  : assert(concrete != null),
        assert(random != null),
        assert(inputConverter != null),
        getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random,
        super(Empty());
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcreteNumber) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);

      yield* inputEither.fold(
        (failure) async* {
          yield Error(message: invalidInputFailureMessage);
        },
        (integer) async* {
          yield Loading();
          final failureOrTrivia =
              await getConcreteNumberTrivia(Params(number: integer));
          yield* _eitherLoadedOrErrorState(failureOrTrivia);
        },
      );
    } else if (event is GetTriviaForRandomNumber) {
      yield Loading();
      final failureOrTrivia = await getRandomNumberTrivia(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrTrivia);
    }
  }

  Stream<NumberTriviaState> _eitherLoadedOrErrorState(
    Either<Failure, NumberTrivia> failureOrTrivia,
  ) async* {
    String portuguese;
    await failureOrTrivia.fold((l) => null, (r) async {
      portuguese = await translatorPortuguese(r.text);
      print(portuguese);
    });

    yield failureOrTrivia.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (trivia) {
        final NumberTrivia number =
            NumberTrivia(number: trivia.number, text: portuguese);
        return Loaded(trivia: number);
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return 'Unexpected error';
    }
  }
}
