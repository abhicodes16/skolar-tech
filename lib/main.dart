import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'style/theme_constants.dart';
import 'views/splash_page.dart';
import 'widget/navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'SKOLAR TECH',  
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey,
      theme: ThemeData(
        fontFamily: kThemeFont,
        primaryColor: kThemeColor,
        primarySwatch: Colors.purple,
        appBarTheme: const AppBarTheme(
          backgroundColor: kThemeColor,
        ),
      ),
      home: SplashPage(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  HttpClient httpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
