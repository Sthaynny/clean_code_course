import 'package:clean_code_course/core/error/exceptions.dart';
import 'package:clean_code_course/core/platform/network_info.dart';
import 'package:clean_code_course/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:clean_code_course/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:clean_code_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_code_course/core/error/failure.dart';
import 'package:clean_code_course/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  NumberTriviaRepositoryImpl({
    @required this.remoteDatasource,
    @required this.localDatasource,
    @required this.networkInfo,
  });

  final NumberTriviaRemoteDatasource remoteDatasource;
  final NumberTriviaLocalDatasource localDatasource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
    int number,
  ) async {
    return await _getTrivia(() {
      return remoteDatasource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDatasource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
    Future<NumberTrivia> Function() getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDatasource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDatasource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
