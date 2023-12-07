import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pns_skolar/views/login.dart';
import 'package:pns_skolar/views/school_code_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../style/assets_constants.dart';
import 'homepage.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool? isDeepLink = false;
  // PendingDynamicLinkData? dynamicLinkData;
  bool? isLogin = false;
  @override
  void initState() {
    super.initState();
    // initDynamicLinks();

    startTimer();
  }

  void startTimer() {
    Timer(const Duration(milliseconds: 2000), () {
      navigateUser();
    });
  }

  // initDynamicLinks() async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   var data = await FirebaseDynamicLinks.instance.getInitialLink();
  //   var deepLink = data?.link;
  //   if (deepLink != null) {
  //     final queryParams = deepLink.queryParameters;
  //     if (queryParams.isNotEmpty) {
  //       setState(() {
  //         referalCode = queryParams['referalCode'];
  //         rgc = queryParams['rgc'];
  //         print('RGC : $rgc');
  //       });
  //     }
  //   }

  //   FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
  //     var deepLink = dynamicLinkData.link;
  //     debugPrint('DynamicLinks onLink $deepLink');
  //   }).onError((error) {
  //     debugPrint('DynamicLinks onError $error');
  //   });
  //   navigateUser();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // color: kThemeColor.withOpacity(0.1),
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width / 2,
            child: Image.asset(Assets.logo),
          ),
        ),
      ),
    );
  }

  // void navigateUser() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => OnboardPage(),
  //     ),
  //   );
  // }

  void navigateUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isLogin = pref.getBool('isLoggedIn') ?? false;
    if (isLogin!) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SchoolCodeScreen(),
        ),
      );
    }
  }
}
