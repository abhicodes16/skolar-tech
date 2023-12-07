import 'package:flutter/material.dart';

import '../style/palette.dart';

class Loading extends StatelessWidget {
  final String? loadingMessage;

  const Loading({Key? key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Center(child: CircularProgressIndicator()),
          const SizedBox(height: 20.0),
          Text(
            loadingMessage!,
            textAlign: TextAlign.center,
            style: Palette.title,
          ),
        ],
      ),
    );
  }
}
