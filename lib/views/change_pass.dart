import 'package:flutter/material.dart';
import 'package:pns_skolar/views/header_widget.dart';

import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../bloc/change_pass_bloc.dart';
import '../widget/error_dialouge.dart';

class ChnagePassword extends StatefulWidget {
  ChnagePassword({Key? key}) : super(key: key);

  @override
  State<ChnagePassword> createState() => _ChnagePasswordState();
}

class _ChnagePasswordState extends State<ChnagePassword> {
  TextEditingController passController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  final double _headerHeight = 135;

  bool _obsecurePass = true;
  bool _obsecurePass1 = true;
  bool _obsecurePass2 = true;

  TextStyle textStyle = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: kBlack,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: _headerHeight,
            child: HeaderWidget(_headerHeight, false), //Wave header
          ),
          _changePasswordText(),
          Container(
            margin: const EdgeInsets.only(top: 145),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _passwordTextfeild(),
                  _newPasswordTextfeild(),
                  _confirmPasswordTextfeild(),
                  const SizedBox(height: 30),
                  _saveBtn(),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _saveBtn() {
    return Container(
      alignment: Alignment.center,
      child: MaterialButton(
        onPressed: () {
          if (passController.text.isEmpty) {
            ErrorDialouge.showErrorDialogue(context, "Password can't be empty");
          } else if (newPassController.text.isEmpty) {
            ErrorDialouge.showErrorDialogue(
                context, "New password can't be empty");
          } else if (confirmPassController.text.isEmpty) {
            ErrorDialouge.showErrorDialogue(
                context, "Confirm password can't be empty");
          } else if (newPassController.text.length < 6) {
            ErrorDialouge.showErrorDialogue(
                context, "Password must contain min 6 characters");
          } else if (newPassController.text != confirmPassController.text) {
            ErrorDialouge.showErrorDialogue(
                context, "Confirm password not matched");
          } else {
            ChangePassBloc(
              newPass: newPassController.text,
              oldPass: passController.text,
              context: context,
            );
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 1.3,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: kThemeColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            'SAVE',
            style: Palette.btnTextWhite,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _changePasswordText() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.fromLTRB(10, 40, 10, 0),
      child: Text(
        'Change Password',
        style: Palette.headerWhite,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _passwordTextfeild() {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 8, 30, 8),
      child: TextField(
        controller: passController,
        keyboardType: TextInputType.text,
        obscureText: _obsecurePass,
        style: textStyle,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(width: 2.0, color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(width: 2.0, color: kAccentColor)),
          contentPadding: const EdgeInsets.all(15.0),
          labelText: "Old Password",
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obsecurePass = !_obsecurePass;
              });
            },
            child: Icon(
              _obsecurePass ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey[300],
            ),
          ),
        ),
      ),
    );
  }

  Widget _newPasswordTextfeild() {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 8, 30, 8),
      child: TextField(
        controller: newPassController,
        keyboardType: TextInputType.text,
        obscureText: _obsecurePass1,
        style: textStyle,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(width: 2.0, color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(width: 2.0, color: kAccentColor)),
          contentPadding: const EdgeInsets.all(15.0),
          labelText: "New Password",
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obsecurePass1 = !_obsecurePass1;
              });
            },
            child: Icon(
              _obsecurePass1 ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey[300],
            ),
          ),
        ),
      ),
    );
  }

  Widget _confirmPasswordTextfeild() {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 8, 30, 8),
      child: TextField(
        controller: confirmPassController,
        keyboardType: TextInputType.text,
        obscureText: _obsecurePass2,
        style: textStyle,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(width: 2.0, color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(width: 2.0, color: kAccentColor)),
          contentPadding: const EdgeInsets.all(15.0),
          labelText: "Confirm Password",
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obsecurePass2 = !_obsecurePass2;
              });
            },
            child: Icon(
              _obsecurePass2 ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey[300],
            ),
          ),
        ),
      ),
    );
  }
}
