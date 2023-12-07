import 'package:flutter/material.dart';

import '../style/palette.dart';
import '../style/theme_constants.dart';

class SuccessDialouge {
  static Future<void> showErrorDialogue(
      BuildContext context, String mesasge) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
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
                      onPressed: () => Navigator.pop(context),
                      shape: Palette.btnShape,
                      color: kThemeColor,
                      child: Text('Done', style: Palette.btnTextWhite),
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
