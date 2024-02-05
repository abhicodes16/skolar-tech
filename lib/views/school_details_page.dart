import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/school_info_model.dart';
import '../repo/school_info_repo.dart';
import '../style/palette.dart';
import '../style/theme_constants.dart';
import 'header_widget.dart';
import 'login.dart';

class SchoolDetails extends StatefulWidget {
  final String? schoolCode;
  final String? schoolCodeName;
  SchoolDetails({Key? key, required this.schoolCode, required this.schoolCodeName}) : super(key: key);

  @override
  State<SchoolDetails> createState() => _SchoolDetailsState();
}

class _SchoolDetailsState extends State<SchoolDetails> {
  bool? isLogin = false;
  String? schoolName = '';
  String? address = '';
  String? logoUrl = '';
  String? mail = '';
  String? bannerUrl = '';
  String? website = '';
  String? phoneNo = '';

  String? schoolCode = '';

  late TextEditingController emailController;
  late TextEditingController passwordController;

  late Offset offset;

  late Duration duration;
  late double opacity;

  final double _headerHeight = 180;

  bool isloading = true;

  @override
  void initState() {
    super.initState();
    _setDataFromApi();
    _checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _pageView(),
          SizedBox(
            height: _headerHeight,
            child: HeaderWidget(_headerHeight, true),
          ),
          _appbarImage(),

        ],
      ),
    );
  }

  Widget _pageView() {
    if (!isloading) {
      return Container(
        margin: const EdgeInsets.only(top: 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _appbarImage(),
               Container(
                height: 70,
                color: kYellow,
              ),
              // _buildIconImage(),
              SizedBox(
                child: ListTile(
                  contentPadding: EdgeInsets.only(
                    top: 13,bottom: 13,left: 15,right: 15
                  ),
                  tileColor: kYellow,
                  leading: _buildIconImage(),
                  title: _schoolName(),
                ),
              ),

              SizedBox(
                height: 15,
              ),

              ListTile(
                leading: const Icon(
                  Icons.location_on_outlined,
                  color: kBlue,
                ),
                title: Transform.translate(
                  offset: Offset(-20, 0),
                  child: _schoolAddress(),
                ),
              ),

              SizedBox(
                height: 10,
              ),

              ListTile(
                leading: const Icon(
                  Icons.phone_android_outlined,
                  color: kBlue,
                ),
                title:_schoolPhone()
              ),
              ListTile(
                leading: const Icon(
                  Icons.email,
                  color: kBlue,
                ),
                title: _schoolMail()
              ),
              ListTile(
                leading: const Icon(
                  Icons.language,
                  color: kBlue,
                ),
                title:_website()
              ),
              _getActionButtons(),
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: const CircularProgressIndicator(),
      );
    }
  }

  Widget _schoolName() {
    return SizedBox(
      child: Text(
        schoolName ?? '',
        style: Palette.headerWHT,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _schoolMail() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          mail ?? '',
          style: Palette.title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _schoolPhone() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          phoneNo ?? '',
          style: Palette.title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _schoolAddress() {
    return SizedBox(
      child: Text(
        address ?? '',
        style: Palette.subTitle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildIconImage() {
    return SizedBox(
      child: Image(
        image: NetworkImage(bannerUrl ?? ''),
        height: 60,width: 60,
      ),
    );
  }

  Widget _website() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          website ?? '',
          style: Palette.title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _appbarImage() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15,top: 45),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Image(
            image: NetworkImage('https://ntier.in/skolarlogo.png'),
            width: 70,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white
            ),
            child: logoUrl == '' ?
            SizedBox()
                :
            Image(
              image: NetworkImage(logoUrl ?? ''),
              width: 70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getActionButtons() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: ElevatedButton(
                child: const Text("Login"),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(kBlue),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    kYellow,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(
                        color: kYellow,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(
                        schoolCode: widget.schoolCode,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            // ignore: sort_child_properties_last
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(black),
                  backgroundColor: MaterialStateProperty.all<Color>(white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(
                              color: kThemeColor))), // foreground
                ),
                onPressed: () {},
                child: const Text("SignUp"),
              ),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  void _setDataFromApi() async {
    SchoolInfoRepo schoolInfoRepo = SchoolInfoRepo();
    SchoolInfoModel schoolInfoData =
        await schoolInfoRepo.fetchData(schoolCode: widget.schoolCodeName);
    setState(
      () {
        isloading = false;
        schoolName = schoolInfoData.data![0].schoolName!;
        address = schoolInfoData.data![0].address!;
        mail = schoolInfoData.data![0].mail!;
        phoneNo = schoolInfoData.data![0].phoneNo!;
        logoUrl = schoolInfoData.data![0].logoUrl!;
        bannerUrl = schoolInfoData.data![0].bannerUrl!;
        website = schoolInfoData.data![0].website!;
      },
    );
  }

  Future _checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      isLogin = pref.getBool('isLoggedIn') ?? false;
    });
  }
}
