import 'package:flutter/material.dart';

import '../style/palette.dart';
import '../style/theme_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class DemoPage extends StatefulWidget {
  DemoPage({Key? key}) : super(key: key);

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool? isLogin = false;
  String? userName;
  String? email;
  String? mobile;
  String? role;

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      isLogin = pref.getBool('isLoggedIn') ?? false;
      userName = pref.getString('userName');
      email = pref.getString('email');
      mobile = pref.getString('mobile');
      role = pref.getString('role');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kThemeColor.withOpacity(0.1),
      // appBar: AppBar(
      //   title: Text('Demo Page', style: Palette.appbarTitle),
      //   flexibleSpace: Container(decoration: Palette.appbarGradient),
      // ),
      //body: isLogin! ? _logoutBtn() : _loginBtn(),
      body: const Center(child: Text('Coming soon')),
    );
  }

  Widget _loginBtn() {
    return Center(
      child: MaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Login(),
            ),
          );
        },
        color: kThemeColor,
        shape: Palette.btnShape,
        child: Text('Login', style: Palette.btnTextWhite),
      ),
    );
  }

  Widget _logoutBtn() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 5),
          Text('Name : $userName', style: Palette.titleS),
          const SizedBox(height: 5),
          Text('Email : $email', style: Palette.titleS),
          const SizedBox(height: 5),
          Text('Mobile No. : $mobile', style: Palette.titleS),
          const SizedBox(height: 5),
          Text('Role : $role', style: Palette.titleS),
          const SizedBox(height: 15),
          MaterialButton(
            onPressed: () {
              showAlertDialog(context: context);
            },
            color: kThemeColor,
            shape: Palette.btnShape,
            child: Text('Logout', style: Palette.btnTextWhite),
          ),
        ],
      ),
    );
  }

  showAlertDialog({BuildContext? context}) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text(
        "Cancel",
        style: TextStyle(
            fontFamily: kThemeFont, fontSize: 14.0, color: Colors.black),
      ),
      onPressed: () {
        Navigator.pop(context!, false);
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        "Yes",
        style: TextStyle(
            fontFamily: kThemeFont, fontSize: 14.0, color: kThemeColor),
      ),
      onPressed: () {
        Navigator.pop(context!, false);
        logoutUser();
        // Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Logout"),
      content: const Text("Are you sure you want to logout?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void logoutUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (route) => false,
    );
  }
}
