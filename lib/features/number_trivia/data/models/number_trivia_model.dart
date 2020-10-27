import 'package:clean_code_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'number_trivia_model.g.dart';

@JsonSerializable()
class NumberTriviaModel extends NumberTrivia {
  NumberTriviaModel({
    @required String text,
    @required int number,
  }) : super(text: text, number: number);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> jsonMap) {
    return _$NumberTriviaModelFromJson(jsonMap);
  }

  Map<String, dynamic> toJson() => _$NumberTriviaModelToJson(this);
}
