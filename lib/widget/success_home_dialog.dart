import 'package:flutter/material.dart';

import '../style/palette.dart';
import '../style/theme_constants.dart';
import '../views/homepage.dart';

class SuccessHomeDialog {
  static Future<void> show(BuildContext context, String mesasge) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          //key: key,
          //backgroundColor: Colors.white,

          children: <Widget>[
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                    child: Text(
                      mesasge,
                      style: Palette.titleSL,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Padding(
                    padding: kStandardMargin,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                      shape: Palette.btnShape,
                      color: kThemeColor,
                      child: Text('Okay', style: Palette.btnTextWhite),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
