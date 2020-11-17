import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  const MessageDisplay({
    @required this.message,
  }) : assert(message != null);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Third of the size of the screen
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            message,
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
