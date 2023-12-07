import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String? errorMessage;

  final Function? onRetryPressed;

  const ErrorMessage({Key? key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(25.0),
        child: Text("$errorMessage", textAlign: TextAlign.center),
      ),
    );
  }
}
