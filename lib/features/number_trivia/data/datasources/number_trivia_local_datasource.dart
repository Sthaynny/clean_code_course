import 'dart:convert';

import 'package:clean_code_course/core/error/exceptions.dart';
import 'package:clean_code_course/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

abstract class NumberTriviaLocalDatasource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaModel);
}

const chachedNumberTrivia = 'chachedNumberTrivia';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDatasource {
  NumberTriviaLocalDataSourceImpl({@required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(chachedNumberTrivia);
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return sharedPreferences.setString(
      chachedNumberTrivia,
      json.encode(triviaToCache.toJson()),
    );
  }
}
