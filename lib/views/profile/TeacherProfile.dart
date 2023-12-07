import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/teacher_profile_model.dart';
import '../../repo/profile/teacher_profile_repo.dart';
import '../../style/assets_constants.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';

class TeacherProfile extends StatefulWidget {
  const TeacherProfile({super.key});

  @override
  State<TeacherProfile> createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  bool isLoading = true;
  bool? isTeacher = false;

  String? eMPNAME = '';
  String? eMPPHTURL = '';
  String? eMPDEPTCODE = '';
  String? eMPMAILID = '';
  String? eMPMOB = '';
  String? eMPDOB = '';
  String? eMPDOJ = '';
  String? eMPGNDR = '';
  String? eMPCODE = '';
  String? eMPADHNO = '';
  String? eMPPANNO = '';
  String? eMPFTHNM = '';
  String? eMPADRSPRMN = '';
  String? eMPADRSPRSN = '';
  String? eMPDESGCODE = '';
  String? eMPTYPCODE = '';

  @override
  void initState() {
    setTeacherDataFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: Palette.appbarTitle,
        ),
        flexibleSpace: Container(
          decoration: Palette.appbarGradient,
        ),
      ),
      body: isTeacher!
          ? TeacherProfile()
          : !isLoading
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      _tchDetailsWidget(),
                      _tchProfileDetailsWidget(),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
    );
  }

  Widget _tchDetailsWidget() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  eMPNAME ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                    color: Color(0xff303030),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: const Icon(
                      CupertinoIcons.calendar,
                      color: kThemeColor,
                    ),
                  ),
                  Container(
                    child: Text(eMPDOB ?? ''),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: const Icon(
                      CupertinoIcons.phone,
                      color: kThemeColor,
                    ),
                  ),
                  Container(
                    child: Text(eMPMOB ?? ''),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: const Icon(
                      CupertinoIcons.mail,
                      color: kThemeColor,
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(eMPMAILID ?? ''),
                  )
                ],
              )
            ],
          ),
          Column(
            children: [
              _tchProfileImg(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tchProfileImg() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x54000000),
            spreadRadius: 3,
            blurRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0), //or 15.0
        child: Container(
          height: 120.0,
          width: 120.0,
          color: kThemeColor,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: eMPPHTURL == null
                ? Image.asset(Assets.avatar)
                : Image.network(eMPPHTURL ?? ''),
          ),
        ),
      ),
    );
  }

  Widget _tchProfileDetailsWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      padding: const EdgeInsets.fromLTRB(13, 12, 9, 5),
      width: 334,
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3f000000),
            offset: Offset(0, 4),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // ageKpn (173:267)
            margin: const EdgeInsets.fromLTRB(2, 0, 4, 0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // agegroupBrz (173:260)
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                  child: const Text(
                    'Employee Code',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: Color(0xff0a408a),
                    ),
                  ),
                ),
                Container(
                  // under161r2 (173:261)
                  margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
                  child: Text(
                    eMPCODE ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.2857142857,
                      color: Color(0xff4c4c4c),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            // ageKpn (173:267)
            margin: const EdgeInsets.fromLTRB(2, 0, 4, 0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // agegroupBrz (173:260)
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                  child: const Text(
                    'Designation',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: Color(0xff0a408a),
                    ),
                  ),
                ),
                Container(
                  // under161r2 (173:261)
                  margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
                  child: Text(
                    eMPDESGCODE ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.2857142857,
                      color: Color(0xff4c4c4c),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            // ageKpn (173:267)
            margin: const EdgeInsets.fromLTRB(2, 0, 4, 0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // agegroupBrz (173:260)
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                  child: const Text(
                    'Permanent Address',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: Color(0xff0a408a),
                    ),
                  ),
                ),
                Container(
                  // under161r2 (173:261)
                  margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
                  child: Text(
                    eMPADRSPRMN ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.2857142857,
                      color: Color(0xff4c4c4c),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            // ageKpn (173:267)
            margin: const EdgeInsets.fromLTRB(2, 0, 4, 0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // agegroupBrz (173:260)
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                  child: const Text(
                    'Present Address',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: Color(0xff0a408a),
                    ),
                  ),
                ),
                Container(
                  // under161r2 (173:261)
                  margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
                  child: Text(
                    eMPADRSPRSN ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.2857142857,
                      color: Color(0xff4c4c4c),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            // parentscontactnumberynA (173:275)
            margin: const EdgeInsets.fromLTRB(4, 0, 2, 0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // parentscontactnumber5aJ (173:276)
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                  child: const Text(
                    'Father`s Name',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: Color(0xff0a408a),
                    ),
                  ),
                ),
                Container(
                  // LPk (173:277)
                  margin: const EdgeInsets.fromLTRB(2, 0, 0, 10),
                  child: Text(
                    eMPFTHNM ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.2857142857,
                      color: Color(0xff4c4c4c),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            // parentscontactnumberynA (173:275)
            margin: const EdgeInsets.fromLTRB(4, 0, 2, 0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // parentscontactnumber5aJ (173:276)
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                  child: const Text(
                    'Date Of joining',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: Color(0xff0a408a),
                    ),
                  ),
                ),
                Container(
                  // LPk (173:277)
                  margin: const EdgeInsets.fromLTRB(2, 0, 0, 10),
                  child: Text(
                    eMPDOJ ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.2857142857,
                      color: Color(0xff4c4c4c),
                    ),
                  ),
                ),
                const Divider(),
                Container(
                  // ageKpn (173:267)
                  margin: const EdgeInsets.fromLTRB(2, 0, 4, 0),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // agegroupBrz (173:260)
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                        child: const Text(
                          'Aadhar Number',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                            color: Color(0xff0a408a),
                          ),
                        ),
                      ),
                      Container(
                        // under161r2 (173:261)
                        margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
                        child: Text(
                          eMPPANNO ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.2857142857,
                            color: Color(0xff4c4c4c),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Container(
                  // ageKpn (173:267)
                  margin: const EdgeInsets.fromLTRB(2, 0, 4, 0),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // agegroupBrz (173:260)
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                        child: const Text(
                          'PAN Number',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                            color: Color(0xff0a408a),
                          ),
                        ),
                      ),
                      Container(
                        // under161r2 (173:261)
                        margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
                        child: Text(
                          eMPADHNO ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.2857142857,
                            color: Color(0xff4c4c4c),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void setTeacherDataFromAPI() async {
    TeacherProfileRepo detailsRepo = TeacherProfileRepo();
    TeacherProfileModel teacherDetails = await detailsRepo.fetchData();
    setState(
      () {
        isLoading = false;
        eMPNAME = teacherDetails.data![0].eMPNAME!;
        eMPPHTURL = teacherDetails.data![0].eMPPHTURL!;
        eMPDEPTCODE = teacherDetails.data![0].eMPDEPTCODE!;
        eMPMAILID = teacherDetails.data![0].eMPMAILID!;
        eMPMOB = teacherDetails.data![0].eMPMOB!;
        eMPDOB = teacherDetails.data![0].eMPDOB!;
        eMPADHNO = teacherDetails.data![0].eMPADHNO!;
        eMPPANNO = teacherDetails.data![0].eMPPANNO!;
        eMPCODE = teacherDetails.data![0].eMPCODE!.toString();
        eMPDOJ = teacherDetails.data![0].eMPDOJ!;
        eMPGNDR = teacherDetails.data![0].eMPGNDR!;
        eMPADRSPRMN = teacherDetails.data![0].eMPADRSPRMN!;
        eMPADRSPRSN = teacherDetails.data![0].eMPADRSPRSN!;
        eMPFTHNM = teacherDetails.data![0].eMPFTHNM!;
        eMPDESGCODE = teacherDetails.data![0].eMPDESGCODE!;
        eMPTYPCODE = teacherDetails.data![0].eMPTYPCODE!;
      },
    );
  }
}
