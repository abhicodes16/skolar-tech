import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'style/theme_constants.dart';
import 'views/splash_page.dart';
import 'widget/navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDz_drtOl6E2_4yYbSJ7LsqUK90jgLxD00',
      appId: '1:426299187971:android:3efbcc9c938d3a2f6bbf36',
      messagingSenderId: '426299187971',
      projectId: 'skolar-tech',
      storageBucket: 'skolar-tech.appspot.com',
    ),
  );

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

    return GetMaterialApp(
      title: 'SKOLAR TECH',
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey,
      theme: ThemeData(
        fontFamily: kThemeFont,
        primaryColor: kThemeColor,
        primarySwatch: Colors.purple,
        useMaterial3: false,
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
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
