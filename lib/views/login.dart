import 'package:flutter/material.dart';

import '../../bloc/login_bloc.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../widget/error_dialouge.dart';
import 'header_widget.dart';

class Login extends StatefulWidget {
  final String? schoolCode;
  Login({
    Key? key,
    this.schoolCode,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obsecurePass = true;

  double _headerHeight = 180;

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
                height: _headerHeight,
                child: HeaderWidget(_headerHeight, true) //Wave header
                ),
            _loginWidget(),
          ],
        ),
      ),
    );
  }

  Widget _loginWidget() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          _appbarImage(),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Welcome back ! Login with your credentials",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          _userNameTextfeild(),
          const SizedBox(
            height: 20,
          ),
          _passwordTextfeild(),
          const SizedBox(
            height: 10,
          ),
          _forgetPasswordText(),
          const SizedBox(
            height: 20,
          ),
          _singinButton(),
        ],
      ),
    );
  }

  Widget _appbarImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Image(
          image: NetworkImage('https://ntier.in/skolarlogo.png'),
          width: 70,
        ),
      ],
    );
  }

  Widget _userNameTextfeild() {
    return Container(
      margin: EdgeInsets.only(right: 25, left: 25),
      child: TextField(
        controller: userNameController,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(width: 2.0, color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(width: 2.0, color: kDarkThemeColor)),
          contentPadding: const EdgeInsets.all(15.0),
          hintText: "UserId",
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _passwordTextfeild() {
    return Container(
      margin: EdgeInsets.only(right: 25, left: 25),
      child: TextField(
        controller: passwordController,
        keyboardType: TextInputType.text,
        obscureText: _obsecurePass,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: kBlack,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(width: 2.0, color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(width: 2.0, color: kDarkThemeColor)),
          contentPadding: const EdgeInsets.all(15.0),
          hintText: "Password",
          hintStyle: const TextStyle(
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

  Widget _forgetPasswordText() {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => SendOtpToEmail(),
        //   ),
        // );
      },
      child: Container(
        margin: EdgeInsets.only(left: 30.0),
        width: MediaQuery.of(context).size.width,
        child: Text(
          '  Forget password?',
          style: Palette.title,
        ),
      ),
    );
  }

  Widget _singinButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: kYellow,
          fixedSize: const Size(200, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      onPressed: () {
        var userName = userNameController.text.trim();
        var password = passwordController.text.trim();
        if (userName.isEmpty) {
          ErrorDialouge.showErrorDialogue(context, "UserId can't be empty");
        } else if (userName.length < 2) {
          ErrorDialouge.showErrorDialogue(context, "Enter valid username");
        } else if (password.isEmpty) {
          ErrorDialouge.showErrorDialogue(context, "Password can't be empty");
        } else {
          if (userName.contains("/T/")) {
            LoginBloc(
              userName: userNameController.text,
              password: passwordController.text,
              context: context,
              isTeacher: true,
              schoolCode: widget.schoolCode,
            );
          } else {
            LoginBloc(
              userName: userNameController.text,
              password: passwordController.text,
              context: context,
              schoolCode: widget.schoolCode,
              isTeacher: false,
            );
          }
        }
      },
      child: const Text(
        'LogIn',
        style: TextStyle(color: kBlue, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _createAccountText() {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => Signup(
        //       isManualRegister: false,
        //       isRGC: true,
        //       pageTitle: 'RGC',
        //     ),
        //   ),
        // );
      },
      child: Text(
        "Don't have an account? Sign up",
        style: Palette.title,
        textAlign: TextAlign.center,
      ),
    );
  }
}
