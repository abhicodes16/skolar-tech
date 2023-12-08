import 'package:flutter/material.dart';
import 'package:pns_skolar/views/body.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin_home.dart';

void main() => runApp(MaterialApp(home: HomePage()));

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  bool isAdmin = false;

  @override
  void initState() {
    checkAdmin();
    super.initState();
  }

  Future<void> checkAdmin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.setString(key, value)
    isAdmin = pref.getBool('isAdmin') ?? false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isAdmin ? const AdminHome() : const Body(),
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xff392850),
    );
  }
}
