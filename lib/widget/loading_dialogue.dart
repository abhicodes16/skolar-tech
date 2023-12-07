import 'package:flutter/material.dart';

import '../style/palette.dart';

class LoadingDialog {
  static Future<void> showLoadingDialog(
    BuildContext context,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          /// key: key,
          //backgroundColor: Colors.white,
          insetPadding: EdgeInsets.zero,
          shape: Palette.cardShape,
          children: <Widget>[
            SizedBox(
              height: 95.0,
              //width: 20.0,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                  child: Column(
                    children: [
                      const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3.5,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text("Please wait...", style: Palette.titleSL)
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
