import 'package:clean_code_course/core/error/exceptions.dart';
import 'package:clean_code_course/core/error/failure.dart';
import 'package:clean_code_course/core/platform/network_info.dart';
import 'package:clean_code_course/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:clean_code_course/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:clean_code_course/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_code_course/features/number_trivia/data/repositories/number_trivia_repository.dart';
import 'package:clean_code_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDatasource extends Mock
    implements NumberTriviaRemoteDatasource {}

class MockLocalDatasource extends Mock implements NumberTriviaLocalDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NumberTriviaRepositoryImpl repository;
  MockLocalDatasource mockLocalDatasource;
  MockRemoteDatasource mockRemoteDatasource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDatasource = MockRemoteDatasource();
    mockLocalDatasource = MockLocalDatasource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
      remoteDatasource: mockRemoteDatasource,
      localDatasource: mockLocalDatasource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getConcreteNumberTrivia', () {
    // DATA FOR THE MOCKS AND ASSERTIONS
    // We'll use these three variables throughout all the tests
    const tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel(number: tNumber, text: 'test trivia');
    final NumberTrivia tNumberTrivia = tNumberTriviaModel;

    test('should check if the device is online', () {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getConcreteNumberTrivia(tNumber);
      // assert
      verify(mockNetworkInfo.isConnected);
    });
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockLocalDatasource.getLastNumberTrivia())
              .thenAnswer((_) async => tNumberTriviaModel);
          // act
          final result = await repository.getConcreteNumberTrivia(tNumber);
          // assert
          verifyZeroInteractions(mockRemoteDatasource);
          verify(mockLocalDatasource.getLastNumberTrivia());
          expect(result.fold(id, id), equals(tNumberTrivia));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockLocalDatasource.getLastNumberTrivia())
              .thenThrow(CacheException());
          // act
          final result = await repository.getConcreteNumberTrivia(tNumber);
          // assert
          verifyZeroInteractions(mockRemoteDatasource);
          verify(mockLocalDatasource.getLastNumberTrivia());
          expect(result.fold(id, id), equals(CacheFailure()));
        },
      );
    });
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel(number: 123, text: 'test trivia');
    final NumberTrivia tNumberTrivia = tNumberTriviaModel;

    test('should check if the device is online', () {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getRandomNumberTrivia();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDatasource.getRandomNumberTrivia())
              .thenAnswer((_) async => tNumberTriviaModel);
          // act
          final result = await repository.getRandomNumberTrivia();
          // assert
          verify(mockRemoteDatasource.getRandomNumberTrivia());
          expect(result.fold(id, id), equals(tNumberTrivia));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDatasource.getRandomNumberTrivia())
              .thenAnswer((_) async => tNumberTriviaModel);
          // act
          await repository.getRandomNumberTrivia();
          // assert
          verify(mockRemoteDatasource.getRandomNumberTrivia());
          verify(mockLocalDatasource.cacheNumberTrivia(tNumberTrivia));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDatasource.getRandomNumberTrivia())
              .thenThrow(ServerException());
          // act
          final result = await repository.getRandomNumberTrivia();
          // assert
          verify(mockRemoteDatasource.getRandomNumberTrivia());
          verifyZeroInteractions(mockLocalDatasource);
          expect(result.fold(id, id), equals(ServerFailure()));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockLocalDatasource.getLastNumberTrivia())
              .thenAnswer((_) async => tNumberTriviaModel);
          // act
          final result = await repository.getRandomNumberTrivia();
          // assert
          verifyZeroInteractions(mockRemoteDatasource);
          verify(mockLocalDatasource.getLastNumberTrivia());
          expect(result.fold(id, id), equals(tNumberTrivia));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockLocalDatasource.getLastNumberTrivia())
              .thenThrow(CacheException());
          // act
          final result = await repository.getRandomNumberTrivia();
          // assert
          verifyZeroInteractions(mockRemoteDatasource);
          verify(mockLocalDatasource.getLastNumberTrivia());
          expect(result.fold(id, id), equals(CacheFailure()));
        },
      );
    });
  });
}
