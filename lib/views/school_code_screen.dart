// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pns_skolar/views/login.dart';
import 'package:pns_skolar/views/school_details_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/school_info_model.dart';
import '../repo/school_info_repo.dart';
import '../style/assets_constants.dart';
import '../style/theme_constants.dart';
import '../widget/error_dialouge.dart';
import '../widget/loading_dialogue.dart';

class SchoolCodeScreen extends StatefulWidget {
  SchoolCodeScreen({Key? key}) : super(key: key);

  @override
  State<SchoolCodeScreen> createState() => _SchoolCodeScreenState();
}

class _SchoolCodeScreenState extends State<SchoolCodeScreen> {
  TextEditingController schoolCodeController = TextEditingController();
  late Offset offset;
  bool? isLogin = false;
  late Duration duration;
  late double opacity;

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Developed By ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
              child: Image.asset(Assets.ntierLogo),
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: kAccentColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 180,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  "Welcome Back",
                  style: TextStyle(color: kBlue, fontSize: 30),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  Assets.logo,
                  width: 150,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 60,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              // ignore: prefer_const_literals_to_create_immutables
                              boxShadow: [
                                const BoxShadow(
                                    color: kShadow1,
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              TextField(
                                style: const TextStyle(color: Colors.black87),
                                controller: schoolCodeController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(20),
                                  hintText: "Enter School Reg. Code",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF9A825),
                              fixedSize: const Size(150, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          onPressed: () {
                            if (schoolCodeController.text.isEmpty) {
                              ErrorDialouge.showErrorDialogue(
                                  context, 'Enter School Code');
                            } else {
                              _sendDataToApi();
                            }
                          },
                          child: const Text(
                            'Search',
                            style: TextStyle(
                                color: kBlue, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _sendDataToApi() async {
    LoadingDialog.showLoadingDialog(context);
    SchoolInfoRepo schoolInfoRepo = SchoolInfoRepo();

    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      SchoolInfoModel? data = await schoolInfoRepo.fetchData(
        schoolCode: schoolCodeController.text,
      );
      if (data.success!) {
        Navigator.pop(context);

        if (data.data != null) {
          if (data.data!.isNotEmpty) {
            String connName = data.data!.first.connectionStringName ?? '';
            pref.setString('schoolCode', connName);
            pref.setString('schoolCodeName', schoolCodeController.text);
            pref.setString('schoolId', data.data!.first.schoolId ?? '');

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SchoolDetails(
                  schoolCode: connName,
                  schoolCodeName: schoolCodeController.text,
                ),
              ),
            );
          }
        }
      } else {
        Navigator.pop(context);
        ErrorDialouge.showErrorDialogue(context, data.message!);
      }
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
        context,
        e.toString(),
      );
    }
  }

  Future _checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      isLogin = pref.getBool('isLoggedIn') ?? false;
      var schoolLabel = pref.getString('schoolCodeName');
      schoolCodeController.text = schoolLabel ?? '';
    });
  }
}
