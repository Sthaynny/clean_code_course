import 'package:clean_code_course/features/number_trivia/presentation/page/number_trivia_page.dart';
import 'package:flutter/material.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Curiosidades sobre números',
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.blue,
      ),
      home: NumberTriviaPage(),
    );
  }
}
