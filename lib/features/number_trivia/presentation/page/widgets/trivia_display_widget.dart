import 'package:clean_code_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class TriviaDisplay extends StatelessWidget {
  const TriviaDisplay({
    @required this.numberTrivia,
    Key key,
  })  : assert(numberTrivia != null),
        super(key: key);
  final NumberTrivia numberTrivia;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: <Widget>[
          // Fixed size, doesn't scroll
          Text(
            numberTrivia.number.toString(),
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Expanded makes it fill in all the remaining space
          Expanded(
            child: Center(
              // Only the trivia "message" part will be scrollable
              child: SingleChildScrollView(
                child: Text(
                  numberTrivia.text,
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Future<String> translatorPortuguese(String text) async {
  final translator = GoogleTranslator();
  final newText = await translator
      .translate(text, from: 'en', to: 'pt')
      .then((value) => value.text);

  return newText;
}
