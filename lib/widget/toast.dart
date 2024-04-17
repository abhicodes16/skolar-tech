import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../style/theme_constants.dart';

class Utils{

  void rejectToast(String msg){

    Fluttertoast.showToast(
      msg:msg,
      fontSize:16,
      toastLength:Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb:1,
      textColor: Colors.black87,
      backgroundColor: Colors.red.shade500.withOpacity(0.2),
    );

  }

  void completedToast(String msg){
    Fluttertoast.showToast(
      msg:msg,
      fontSize:16,
      toastLength:Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb:1,
      textColor: Colors.black87,
      backgroundColor: Colors.green.shade500.withOpacity(0.2),
    );
  }

  void pendingToast(String msg){
    Fluttertoast.showToast(
      msg:msg,
      fontSize:16,
      toastLength:Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb:1,
      textColor: Colors.black87,
      backgroundColor: Colors.orange.shade500.withOpacity(0.2),
    );
  }

  void toast(String msg){
    Fluttertoast.showToast(
      msg:msg,
      fontSize:16,
      toastLength:Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb:1,
      textColor: Colors.black87,
      backgroundColor: Colors.grey.shade500.withOpacity(0.2),
    );
  }

  void themetoast(String msg){
    Fluttertoast.showToast(
      msg:msg,
      fontSize:16,
      toastLength:Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb:1,
      textColor: Colors.white,
      backgroundColor: kDarkThemeColor,
    );
  }

}