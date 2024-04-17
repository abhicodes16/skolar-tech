import 'package:flutter/material.dart';
import 'theme_constants.dart';

class Palette {
  static TextStyle appbarTitle = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18.0,
  );

  static TextStyle appbarTitleBlack = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18.0,
    color: Colors.black,
  );

  static TextStyle lightAppbarTitle = const TextStyle(
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontSize: 18.0,
  );

  static TextStyle appbarTitleDark = TextStyle(
      fontWeight: FontWeight.w700, fontSize: 18.0, color: Colors.grey[900]);

  static BoxDecoration appbarGradient = const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [kThemeColor, kDarkThemeColor],
    ),

  );

  static BoxDecoration pageGradient = const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [kThemeColor, kDarkThemeColor],
    ),
  );

  static BoxDecoration appbarBottomRoundGradient = const BoxDecoration(
    borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(20.0), bottomLeft: Radius.circular(20.0)),
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [kThemeColor, kDarkThemeColor],
    ),
  );

  static TextStyle header = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 24.0,
  );

  static TextStyle header30 = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 30.0,
  );

  static TextStyle headerS = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20.0,
  );
  static TextStyle headerWHT = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20.0,
    color: kWhite,
  );
  static TextStyle headerYLW = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20.0,
    color: kYellow,
  );

  static TextStyle whiteHeaderS = const TextStyle(
      fontWeight: FontWeight.w600, fontSize: 20.0, color: Colors.white);

  static TextStyle headerWhiteS = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20.0,
    color: Colors.white,
  );

  static TextStyle headerWhite = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 24.0,
    color: Colors.white,
  );

  static TextStyle title = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
  );

  static TextStyle titleStatus = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 15.0,
  );

  static TextStyle dateStatus = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: Colors.black
  );



  static TextStyle titleT = const TextStyle(
    fontWeight: FontWeight.w500,
    color: kThemeColor,
    fontSize: 16.0,
  );

  static TextStyle titlestatus2 = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14.0,
      color: Colors.black
  );

  static TextStyle titlestatus3 = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14.0,
      color: kThemeColor
  );

  static TextStyle titlez = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
    color: Colors.white,
  );
  static TextStyle titleL = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.0,
  );

  static TextStyle titleS = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
  );
  static TextStyle titleDanger = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: Colors.red,
  );
  static TextStyle titleSafe = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: Colors.green,
  );
  static TextStyle titleSafeD = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.0,
    color: Colors.green,
  );
  static TextStyle titleDangerS = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 10.0,
    color: Colors.red,
  );

  static TextStyle titleWhiteS = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: Colors.white,
  );
  static TextStyle titleSB = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14.0,
  );

  static TextStyle themeTitleSB = const TextStyle(
    fontWeight: FontWeight.w600,
    color: kThemeColor,
    fontSize: 14.0,
  );

  static TextStyle themeTitle = const TextStyle(
    fontWeight: FontWeight.w600,
    color: kPrimaryColor,
    fontSize: 16.0,
  );

  static TextStyle themeBtn = const TextStyle(
    fontWeight: FontWeight.w500,
    color: kThemeColor,
    fontSize: 14.0,
  );

  static TextStyle themeHeader = const TextStyle(
    fontWeight: FontWeight.w600,
    color: kThemeColor,
    fontSize: 20.0,
  );

  static TextStyle themeHeader2 = const TextStyle(
    fontWeight: FontWeight.w600,
    color: kThemeColor,
    fontSize: 24.0,
  );

  static TextStyle titleSL = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
  );

  static TextStyle subTitle = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
  );

  static TextStyle subTitleGrey = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
    color: Colors.grey,
  );

  static TextStyle subTitleL = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
  );
  static TextStyle subTitleLK = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
    color: primaryColor,
  );
  static TextStyle subTitlex = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
    color: Colors.white,
  );

  static TextStyle subTitleTheme = const TextStyle(
    fontWeight: FontWeight.w500,
    color: kThemeColor,
    fontSize: 12.0,
  );

  static TextStyle subTitleThemeDark = const TextStyle(
    fontWeight: FontWeight.w500,
    color: kDarkAccentColor,
    fontSize: 12.0,
  );
  static TextStyle titleThemeS = const TextStyle(
    fontWeight: FontWeight.w500,
    color: kThemeColor,
    fontSize: 14.0,
  );

  static TextStyle subTitleWhite = const TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.white,
    fontSize: 12.0,
  );

  static TextStyle textHint = TextStyle(
    fontFamily: kThemeFont,
    fontWeight: FontWeight.w400,
    fontSize: 15.0,
    color: kBlack.withOpacity(0.4),
  );

  static BoxDecoration buttonGradient = BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    gradient: const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [kDarkThemeColor, kDarkAccentColor],
    ),
  );

  static TextStyle whiteBtnTxt = const TextStyle(
    fontFamily: kThemeFont,
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
    color: Colors.white,
  );

  static TextStyle tabText = const TextStyle(
    fontFamily: kThemeFont,
    fontWeight: FontWeight.w700,
    fontSize: 16.0,
  );

  static TextStyle textField = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  static RoundedRectangleBorder cardShape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0));

  static RoundedRectangleBorder btnShape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0));

  static RoundedRectangleBorder btnShape16 =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0));

  static TextStyle btnTextWhite = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16.0,
    color: Colors.white,
  );

  static TextStyle btnTextWhiteS = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: Colors.white,
  );

  static TextStyle bntText = const TextStyle(
    color: black,
    fontWeight: FontWeight.w500,
  );

  static TextStyle bntTexts = const TextStyle(
    color: black,
    fontWeight: FontWeight.w500,
  );

  static BoxDecoration bntBorder = BoxDecoration(
    border: Border.all(width: 1.0, color: kThemeColor),
    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
  );

  static BoxDecoration bntBorderFill = const BoxDecoration(
    color: kThemeColor,
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  );

  static TextStyle subTitleB = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 12.0,
  );

  static BoxDecoration imageShadow = const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xCC000000),
        Color(0x00000000),
        Color(0x00000000),
        Color(0x00000000),
        Color(0xCC000000),
      ],
    ),
  );
}
