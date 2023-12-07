import 'package:flutter/material.dart';
import 'package:pns_skolar/views/fee/paid_amount.dart';
import 'package:pns_skolar/views/fee/upcoming_amt.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import 'dua_amt.dart';
import 'fee_structure.dart';

class FeeCollectionPage extends StatefulWidget {
  final String? schoolCode;
  FeeCollectionPage({Key? key, this.schoolCode}) : super(key: key);

  @override
  State<FeeCollectionPage> createState() => _FeeCollectionPageState();
}

class _FeeCollectionPageState extends State<FeeCollectionPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('FEEs', style: Palette.appbarTitle),
          flexibleSpace: Container(decoration: Palette.appbarGradient),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeeSturcture()),
                );
              },
              icon: const Icon(Icons.list_alt_sharp),
            )
          ],
        ),
        body: Column(
          children: const [
            TabBar(
              labelColor: kThemeColor,
              indicatorColor: kThemeColor,
              labelPadding: EdgeInsets.all(0),
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle:
                  TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              tabs: [
                Tab(text: "Upcoming"),
                Tab(text: "Due"),
                Tab(text: "Paid"),
              ],
            ),
            Expanded(
              child: TabBarView(
                // <-- Your TabBarView
                children: [
                  UpcomingAmt(),
                  DuaAmt(),
                  PaidAmount(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
