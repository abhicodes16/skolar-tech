import 'package:flutter/material.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Center(
      child: Container(
        margin: const EdgeInsets.all(25.0),
        child: const Text("No Data Found..!", textAlign: TextAlign.center),
      ),
    );
  }
}
