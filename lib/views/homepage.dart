import 'package:flutter/material.dart';
import 'package:pns_skolar/views/body.dart';

void main() => runApp(MaterialApp(home: HomePage()));

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }

  AppBar buildAppbar() {  
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xff392850),
    );
  }
}
