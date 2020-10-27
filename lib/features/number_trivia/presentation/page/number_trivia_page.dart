import 'package:clean_code_course/features/number_trivia/presentation/bloc/bloc/number_trivia_bloc.dart';
import 'package:clean_code_course/features/number_trivia/presentation/page/widgets/loading_widget.dart';
import 'package:clean_code_course/features/number_trivia/presentation/page/widgets/message_display_widget.dart';
import 'package:clean_code_course/features/number_trivia/presentation/page/widgets/trivia_controls_widget.dart';
import 'package:clean_code_course/features/number_trivia/presentation/page/widgets/trivia_display_widget.dart';
import 'package:clean_code_course/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Curiosidades sobre números'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }
}

BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
  return BlocProvider(
    create: (_) => dependency<NumberTriviaBloc>(),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            // Top half
            BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
              builder: (context, state) {
                if (state is Empty) {
                  return MessageDisplay(
                    message: 'Comece a pesquisar!',
                  );
                } else if (state is Loading) {
                  return LoadingWidget();
                } else if (state is Loaded) {
                  return TriviaDisplay(numberTrivia: state.trivia);
                } else if (state is Error) {
                  return MessageDisplay(
                    message: state.message,
                  );
                }
                return Container();
              },
            ),
            SizedBox(height: 20),
            // Bottom half
            TriviaControls()
          ],
        ),
      ),
    ),
  );
}
