// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pns_skolar/model/teacher-login_model.dart';

import '../model/login_model.dart';
import '../views/homepage.dart';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repo/login_repo.dart';
import '../widget/error_dialouge.dart';
import '../widget/loading_dialogue.dart';

class LoginBloc {
  late LoginRepo loginRepos;
  late StreamController _loginDataController;

  StreamSink get dataSink => _loginDataController.sink;
  Stream get dataStream => _loginDataController.stream;

  LoginBloc({
    BuildContext? context,
    required String? userName,
    required String? password,
    required bool? isTeacher,
    required String? schoolCode,
  }) {
    _loginDataController = StreamController();
    loginRepos = LoginRepo();
    fetchdata(
      userName: userName,
      password: password,
      context: context,
      isTeacher: isTeacher,
      schoolCode: schoolCode,
    );
  }

  fetchdata({
    BuildContext? context,
    String? userName,
    String? password,
    bool? isTeacher,
    required String? schoolCode,
  }) async {
    // dataSink.add(Response.loading('Loading Data..!'));
    LoadingDialog.showLoadingDialog(context!);

    // try {
    final ipv4 = await Ipify.ipv4();
    String? deviceId = await _getId();

    debugPrint("IP : $ipv4");
    debugPrint("Device ID : $deviceId");
    debugPrint("School Code : $schoolCode");

    SharedPreferences pref = await SharedPreferences.getInstance();
    LoginModel data = await loginRepos.sendLoginReq(
      userName: userName,
      password: password,
      deviceId: deviceId,
      deviceToken: deviceId,
      iPAddress: ipv4.toString(),
      schoolCode: schoolCode,
    );

    if (data.token != null) {
      Navigator.pop(context);

      bool isTearcher = false;
      bool isAdmin = false;

      if (data.userType == 'Employee') {
        isTearcher = true;
      } else if (data.userType == 'Admin') {
        isAdmin = true;
      }

      pref.setBool('isLoggedIn', true);
      pref.setBool('isTeacher', isTearcher);
      pref.setBool('isAdmin', isAdmin);
      pref.setString('token', data.token!);
      pref.setString('userId', data.userId!);
      pref.setString('schoolCode', schoolCode!);
      // pref.setString('STD_NAME', data.sTDNAME!);
      // pref.setString('sTDGNDR', data.sTDGNDR!);
      // pref.setString('sTDDOB', data.sTDDOB!);
      // pref.setString('sTDIDNO', data.sTDIDNO!);
      // pref.setString('sTDMOB', data.sTDMOB!);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
          (route) => false);
    } else {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(context, data.message!);
    }
    // if (isTeacher!) {
    //   LoginTeacherModel data = await loginRepos.sendTeacherReq(
    //     userName: userName,
    //     password: password,
    //     deviceId: deviceId,
    //     deviceToken: deviceId,
    //     iPAddress: ipv4.toString(),
    //     schoolCode: schoolCode,
    //   );

    //   if (data.token != null) {
    //     Navigator.pop(context);
    //     pref.setBool('isLoggedIn', true);
    //     pref.setBool('isTeacher', true);
    //     pref.setString('token', data.token!);
    //     pref.setString('userId', data.userId!);
    //     pref.setString('EMP_NAME', data.eMPNAME!);
    //     pref.setString('EMP_GNDR', data.eMPGNDR!);
    //     pref.setString('EMP_DOB', data.eMPDOB!);
    //     pref.setString('Emp_IdNo', data.empIdNo!);
    //     pref.setString('EMP_MOB', data.eMPMOB!);
    //     pref.setString('schoolCode', schoolCode ?? '');

    //     Navigator.pushAndRemoveUntil(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => HomePage(),
    //         ),
    //         (route) => false);
    //   } else {
    //     Navigator.pop(context);
    //     ErrorDialouge.showErrorDialogue(context, data.message!);
    //   }
    // } else {
    //   LoginModel data = await loginRepos.sendLoginReq(
    //     userName: userName,
    //     password: password,
    //     deviceId: deviceId,
    //     deviceToken: deviceId,
    //     iPAddress: ipv4.toString(),
    //     schoolCode: schoolCode,
    //   );

    //   if (data.token != null) {
    //     Navigator.pop(context);

    //     pref.setBool('isLoggedIn', true);
    //     pref.setBool('isTeacher', false);
    //     pref.setString('token', data.token!);
    //     pref.setString('userId', data.userId!);
    //     pref.setString('STD_NAME', data.sTDNAME!);
    //     pref.setString('sTDGNDR', data.sTDGNDR!);
    //     pref.setString('sTDDOB', data.sTDDOB!);
    //     pref.setString('sTDIDNO', data.sTDIDNO!);
    //     pref.setString('sTDMOB', data.sTDMOB!);

    //     Navigator.pushAndRemoveUntil(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => HomePage(),
    //         ),
    //         (route) => false);
    //   } else {
    //     Navigator.pop(context);
    //     ErrorDialouge.showErrorDialogue(context, data.message!);
    //   }
    // }
    print('$isTeacher');
    // } catch (e) {
    //   Navigator.pop(context);
    //   ErrorDialouge.showErrorDialogue(context, e.toString());
    // }
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.utsname.machine; // unique ID on iOS
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.model; // unique ID on Android
    }
  }
}
