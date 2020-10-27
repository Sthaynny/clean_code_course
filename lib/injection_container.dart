import 'package:clean_code_course/core/platform/network_info.dart';
import 'package:clean_code_course/core/utils/input_converter.dart';
import 'package:clean_code_course/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:clean_code_course/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:clean_code_course/features/number_trivia/data/repositories/number_trivia_repository.dart';
import 'package:clean_code_course/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/number_trivia/domain/usercases/get_concrete_number_trivia.dart';
import 'features/number_trivia/domain/usercases/get_ramdom_number_trivia.dart';
import 'features/number_trivia/presentation/bloc/bloc/number_trivia_bloc.dart';
import 'package:http/http.dart' as http;

final dependency = GetIt.instance;

Future<void> init() async {
  //! Features

  //Bloc
  dependency.registerFactory(
    () => NumberTriviaBloc(
      concrete: dependency(),
      random: dependency(),
      inputConverter: dependency(),
    ),
  );

  // Use cases
  dependency.registerLazySingleton(() => GetConcreteNumberTrivia(dependency()));
  dependency.registerLazySingleton(() => GetRandomNumberTrivia(dependency()));

  // Repository
  dependency.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDatasource: dependency(),
      localDatasource: dependency(),
      networkInfo: dependency(),
    ),
  );

// Data sources
  dependency.registerLazySingleton<NumberTriviaRemoteDatasource>(
    () => NumberTriviaRemoteDataSourceImpl(client: dependency()),
  );

  dependency.registerLazySingleton<NumberTriviaLocalDatasource>(
    () => NumberTriviaLocalDataSourceImpl(sharedPreferences: dependency()),
  );
  //! Core

  dependency.registerLazySingleton(() => InputConverter());

  dependency
      .registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(dependency()));
  //! External

  final sharedPreferences = await SharedPreferences.getInstance();

  dependency.registerLazySingleton(() => sharedPreferences);
  dependency.registerLazySingleton(() => http.Client());
  dependency.registerLazySingleton(() => DataConnectionChecker());
}
