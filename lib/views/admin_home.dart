import 'package:flutter/material.dart';
import 'package:pns_skolar/bloc/admin/admin_home_bloc.dart';
import 'package:pns_skolar/model/admin_home_model.dart';
import 'package:pns_skolar/style/palette.dart';
import 'package:pns_skolar/utils/response.dart';
import 'package:pns_skolar/views/admin/log_entity.dart';
import 'package:pns_skolar/views/school_code_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../style/theme_constants.dart';
import '../widget/error_message.dart';
import '../widget/loading.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  AdminHomeBloc adminHomeBloc = AdminHomeBloc();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            _customHdr(size: size),
            StreamBuilder(
              stream: adminHomeBloc.dataStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      return Loading(loadingMessage: snapshot.data.message);
                    case Status.COMPLETED:
                      return _gridMenuWidgets(snapshot.data.data);
                    case Status.ERROR:
                      return ErrorMessage(
                        errorMessage: snapshot.data.message,
                      );
                  }
                }
                return Container();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAlertDialog();
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.logout),
      ),
    );
  }

  Widget _gridMenuWidgets(AdminHomeModel adminHomeModel) {
    return Container(
      margin: const EdgeInsets.fromLTRB(25, 5, 25, 20),
      child: GridView.count(
          crossAxisCount: 2,
          primary: false,
          shrinkWrap: true,
          childAspectRatio: 1,
          children: List.generate(
            adminHomeModel.data!.length,
            (i) {
              return _gridIconName(
                menuIcon: adminHomeModel.data![i].icon,
                menuName: adminHomeModel.data![i].textDtls,
                menuValue: adminHomeModel.data![i].value,
              );
            },
          )),
    );
  }

  Widget _gridIconName(
      {String? menuName, String? menuIcon, String? menuValue}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(
              color: kThemeColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 80,
                child: Image.network(menuIcon!),
              ),
              // const SizedBox(height: 6),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$menuName",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "$menuValue",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customHdr({required Size size}) {
    return SizedBox(
      height: size.height * 0.17,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              top: 25,
            ),
            height: size.height * 0.4 - 27,
            decoration: const BoxDecoration(
              color: Color(0xff392850),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Admin',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                      color: Color.fromARGB(255, 190, 188, 188),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LogEntity()),
                    );
                  },
                  child: Card(
                    elevation: 0,
                    shape: Palette.cardShape,
                    color: Colors.white12,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        ' LOGS ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  showAlertDialog() {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text(
        "Cancel",
        style: TextStyle(
            fontFamily: kThemeFont, fontSize: 14.0, color: Colors.black),
      ),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        "Yes",
        style: TextStyle(
            fontFamily: kThemeFont, fontSize: 14.0, color: kThemeColor),
      ),
      onPressed: () {
        Navigator.pop(context, false);
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
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void logoutUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolLabel = pref.getString('schoolCodeName') ?? '';

    pref.clear();
    pref.setString('schoolCodeName', schoolLabel);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SchoolCodeScreen()),
      (route) => false,
    );
  }
}
