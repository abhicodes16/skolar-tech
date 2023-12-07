import 'package:flutter/material.dart';
import 'package:pns_skolar/model/Details/std_admsn_dtls_model.dart';
import 'package:pns_skolar/model/Details/std_fmly_dtls_model.dart';
import '../../model/Details/std_lst_admsn_model.dart';
import '../../model/Details/std_matric_details_model.dart';
import '../../model/Details/student_details_model.dart';
import '../../repo/profile/profile_repo.dart';
import '../../style/assets_constants.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import 'package:flutter/cupertino.dart';

import '../../widget/date_formatter.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({
    super.key,
  });

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool isLoading = true;

  String? sTDNAME = '';
  String? sTDGNDR = '';
  String? sTDDOB = '';
  String? sTDIDNO = '';
  String? sTDMOB = '';
  String? sTDCTGCODE = '';
  String? sTDADRSPRSN = '';
  String? sTDADRSPRMN = '';
  String? sTDCLSCODE = '';
  String? sTDSECCODE = '';
  String? sTDROLNO = '';
  String? sTDSemester = '';
  String? sTDAdmissionCategory = '';
  String? sTDADMDT = '';
  String? institutionName = '';
  String? sTDBRANCH = '';
  String? sTDCODE = '';
  String? sTDCouncilRegNo = '';
  String? sTDFTHNAME = '';
  String? sTDFTHMOB = '';
  String? sTDFTHADHR = '';
  String? sTDFTHOCPN = '';
  String? sTDMTHNAME = '';
  String? sTDMTHMOB = '';
  String? sTDMTHADHR = '';
  String? sTDMTHOCPN = '';
  String? sTDEMAIL = '';
  String? sTDRLGNCODE = '';
  String? sTDMLNGCODE = '';
  String? sTDADHNO = '';
  String? sTDLSTSCNM = '';
  String? sTDAPLNO = '';
  String? sTDAPLDT = '';
  String? sTDDADVSTS = '';
  String? sTDBPLSTS = '';
  String? sTDRTESTS = '';
  String? sTDPHTURL = '';
  String? passingYear = '';
  String? universityName = '';
  String? marks = '';
  String? passingCategory = '';
  String? securedMarks = '';
  String? mSecuredMarks = '';
  String? mPassingCategory = '';
  String? mMarks = '';
  String? boardName = '';
  String? mPassingYear = '';
  String? mInstitutionName = '';

  @override
  void initState() {
    super.initState();
    setDataFromAPI();
    setFmlyDataFromAPI();
    setAdmsnDataFromAPI();
    setLstDataFromAPI();
    setMtrcDataFromAPI();
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
      body: !isLoading
          ? SingleChildScrollView(
              child: Column(
                children: [
                  _detailsWidget(),
                  _personalDetailsWiddget(),
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

  Widget _personalDetailsWiddget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            color: kThemeColor.withOpacity(0.1),
            elevation: 0,
            margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                backgroundColor: kThemeColor.withOpacity(0.1),
                leading: Image.asset(
                  Assets.info,
                  height: 28,
                  width: 28,
                ),
                title: const Text('General Info'),
                children: [
                  _stdGender(),
                  const Divider(),
                  _stdIDWidget(),
                  const Divider(),
                  _stdCtgcode(),
                  const Divider(),
                  _presentAddress(),
                  const Divider(),
                  _permanentAddress(),
                ],
              ),
            ),
          ),
          Card(
            color: kThemeColor.withOpacity(0.1),
            elevation: 0,
            margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                backgroundColor: kThemeColor.withOpacity(0.1),
                title: const Text('Admission Details'),
                leading: Image.asset(
                  Assets.admissionDetails,
                  height: 28,
                  width: 28,
                ),
                children: [
                  _stdAdmnDtWidget(),
                  const Divider(),
                  _stdRollWidget(),
                  const Divider(),
                  _stdAdmnCatWidget(),
                  const Divider(),
                  _stdBranchWidget(),
                  const Divider(),
                  _stdSemWidget(),
                  const Divider(),
                  _stdCnclRegWidget(),
                ],
              ),
            ),
          ),
          Card(
            color: kThemeColor.withOpacity(0.1),
            elevation: 0,
            margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                backgroundColor: kThemeColor.withOpacity(0.1),
                leading: Image.asset(
                  Assets.otherdetails,
                  height: 28,
                  width: 28,
                ),
                title: const Text('Last Institution Details'),
                children: [
                  _stdInstnameDtWidget(),
                  const Divider(),
                  _stdUniNmWidget(),
                  const Divider(),
                  _stdMarksWidget(),
                  const Divider(),
                  _secmrksWidget(),
                  const Divider(),
                  _passingYearWidget(),
                  const Divider(),
                  _passingCatWidget(),
                ],
              ),
            ),
          ),
          Card(
            color: kThemeColor.withOpacity(0.1),
            elevation: 0,
            margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                backgroundColor: kThemeColor.withOpacity(0.1),
                leading: Image.asset(
                  Assets.otherdetails,
                  height: 28,
                  width: 28,
                ),
                title: const Text('Matriculation Details'),
                children: [
                  mtrInstWidget(),
                  const Divider(),
                  _mtrBoardWidget(),
                  const Divider(),
                  _mtrMrksWidget(),
                  const Divider(),
                  _mtrPassingWidget(),
                  const Divider(),
                  _mtrPassingCatWidget(),
                ],
              ),
            ),
          ),
          Card(
            color: kThemeColor.withOpacity(0.1),
            elevation: 0,
            margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                backgroundColor: kThemeColor.withOpacity(0.1),
                leading: Image.asset(
                  Assets.family,
                  height: 28,
                  width: 28,
                ),
                title: const Text('Family Details'),
                children: [
                  _fatherNameWidget(),
                  const Divider(),
                  _fatherPhNumber(),
                  const Divider(),
                  _fatherAdhrNumber(),
                  const Divider(),
                  _fatherOccupation(),
                  const Divider(),
                  _motherNameWidget(),
                  const Divider(),
                  _motherPhNumber(),
                  const Divider(),
                  _motherAdhrNumber(),
                  const Divider(),
                  _motherOccupation(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stdIDWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Student ID',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Color(0xff0a408a),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
            child: Text(
              sTDIDNO ?? '',
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
    );
  }

  Widget _stdLstScnmWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Last School Name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Color(0xff0a408a),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
            child: Text(
              sTDLSTSCNM ?? '',
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
    );
  }

  Widget _stdRlgnWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Religion',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Color(0xff0a408a),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
            child: Text(
              sTDRLGNCODE ?? '',
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
    );
  }

  Widget _stdMlgnWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Mother Language',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Color(0xff0a408a),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
            child: Text(
              sTDMLNGCODE ?? '',
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
    );
  }

  Widget _stdRollWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Roll Number',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Color(0xff0a408a),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
            child: Text(
              sTDROLNO ?? '',
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
    );
  }

  Widget _stdAdmnCatWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Admission Category',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Color(0xff0a408a),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
            child: Text(
              sTDAdmissionCategory ?? '',
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
    );
  }

  Widget _stdBranchWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Branch',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Color(0xff0a408a),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
            child: Text(
              sTDBRANCH ?? '',
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
    );
  }

  Widget _stdSemWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Semester',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Color(0xff0a408a),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
            child: Text(
              sTDSemester ?? '',
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
    );
  }

  Widget _stdCnclRegWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Council Registration Number',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Color(0xff0a408a),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
            child: Text(
              sTDCouncilRegNo ?? '',
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
    );
  }

  Widget _stdAdmnDtWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Admission Date',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Color(0xff0a408a),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
            child: Text(
              sTDADMDT ?? '',
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
    );
  }

  Widget _stdInstnameDtWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Institution Name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Color(0xff0a408a),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
            child: Text(
              institutionName ?? '',
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
    );
  }

  Widget mtrInstWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Institution Name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Color(0xff0a408a),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
            child: Text(
              mInstitutionName ?? '',
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
    );
  }

  Widget _mtrBoardWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Board Name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Color(0xff0a408a),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
            child: Text(
              boardName ?? '',
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
    );
  }

  Widget _mtrMrksWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Marks',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Color(0xff0a408a),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
            child: Text(
              mMarks ?? '',
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
    );
  }

  Widget _mtrPassingWidget() {
    var dateTime = mPassingYear;
    var fomattedDate = '';
    if (dateTime != null && dateTime.isNotEmpty) {
      fomattedDate = DateFormatter.convertDateFormat(dateTime);
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Passing Year',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Color(0xff0a408a),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
            child: Text(
              fomattedDate,
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
    );
  }

  Widget _stdUniNmWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'University Name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Color(0xff0a408a),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
            child: Text(
              universityName ?? '',
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
    );
  }

  Widget _stdMarksWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Marks',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Color(0xff0a408a),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
            child: Text(
              marks ?? '',
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
    );
  }

  Widget _secmrksWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Secured Marks',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Color(0xff0a408a),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
            child: Text(
              securedMarks ?? '',
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
    );
  }

  Widget _passingYearWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Passing Year',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Color(0xff0a408a),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
            child: Text(
              passingYear ?? '',
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
    );
  }

  Widget _passingCatWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Passing Category',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Color(0xff0a408a),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
            child: Text(
              passingCategory ?? '',
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
    );
  }

  Widget _mtrPassingCatWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Passing Category',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Color(0xff0a408a),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
            child: Text(
              mPassingCategory ?? '',
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
    );
  }

  Widget _stdClsCode() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Class ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Color(0xff0a408a),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
            child: Text(
              sTDCLSCODE ?? '',
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
    );
  }

  Widget _stdGender() {
    return Container(
      // ageKpn (173:267)
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // agegroupBrz (173:260)
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Gender',
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
              sTDGNDR ?? '',
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
    );
  }

  Widget _stdCtgcode() {
    return Container(
      // ageKpn (173:267)
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // agegroupBrz (173:260)
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Student Category',
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
              sTDCTGCODE ?? '',
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
    );
  }

  Widget _fatherPhNumber() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Father’s Contact Number',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Color(0xff0a408a),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 0, 0, 10),
            child: Text(
              sTDFTHMOB ?? '',
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
    );
  }

  Widget _motherPhNumber() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Mother’s Contact Number',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Color(0xff0a408a),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
            child: Text(
              sTDMTHMOB ?? '',
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
    );
  }

  Widget _fatherAdhrNumber() {
    return Container(
      // parentscontactnumberynA (173:275)
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // parentscontactnumber5aJ (173:276)
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Father’s Aadhar Number',
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
              sTDFTHADHR ?? '',
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
    );
  }

  Widget _motherAdhrNumber() {
    return Container(
      // parentscontactnumberynA (173:275)
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // parentscontactnumber5aJ (173:276)
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Mother’s Aadhar Number',
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
              sTDMTHADHR ?? '',
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
    );
  }

  Widget _fatherOccupation() {
    return Container(
      // parentscontactnumberynA (173:275)
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // parentscontactnumber5aJ (173:276)
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Father’s Occupation',
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
              sTDFTHOCPN ?? '',
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
    );
  }

  Widget _motherOccupation() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Mother’s Occupation',
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
              sTDMTHOCPN ?? '',
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
    );
  }

  Widget _aadharNumber() {
    return Container(
      // ageKpn (173:267)
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
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
              sTDADHNO ?? '',
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
    );
  }

  Widget _permanentAddress() {
    return Container(
      // ageKpn (173:267)
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 10),
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
              sTDADRSPRMN ?? '',
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
    );
  }

  Widget _presentAddress() {
    return Container(
      // ageKpn (173:267)
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
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
              sTDADRSPRSN ?? '',
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
    );
  }

  Widget _fatherNameWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Father’s Name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Color(0xff0a408a),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
            child: Text(
              sTDFTHNAME ?? '',
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
    );
  }

  Widget _motherNameWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: const Text(
              'Mother’s Name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Color(0xff0a408a),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(2, 0, 0, 2),
            child: Text(
              sTDMTHNAME ?? '',
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
    );
  }

  Widget _detailsWidget() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sTDNAME ?? '',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  color: Color(0xff303030),
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
                    child: Text(sTDDOB ?? ''),
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
                    child: Text(sTDMOB ?? ''),
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
                  Container(
                    child: Text(sTDEMAIL ?? ''),
                  )
                ],
              )
            ],
          ),
          Column(
            children: [
              _profileImageWidget(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _profileImageWidget() {
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
            child: sTDPHTURL!.isEmpty
                ? Image.asset(Assets.avatar)
                : Image.network(sTDPHTURL ?? ''),
          ),
        ),
      ),
    );
  }

  Widget _language() {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          decoration: BoxDecoration(
            color: const Color(0xfffce8ef),
            border: Border.all(color: const Color(0xfffce8ef), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: const Center(
            child: Icon(
              Icons.outlined_flag,
              color: Color(0xfff2426d),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(sTDMLNGCODE ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 15)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _lstScnm() {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          decoration: BoxDecoration(
            color: const Color(0xfffce8ef),
            border: Border.all(color: const Color(0xfffce8ef), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: const Center(
            child: Icon(
              Icons.school_outlined,
              color: Color(0xfff2426d),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(sTDLSTSCNM ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 15)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _rlgn() {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          decoration: BoxDecoration(
            color: const Color(0xfffce8ef),
            border: Border.all(color: const Color(0xfffce8ef), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: const Center(
            child: Icon(
              Icons.outlined_flag,
              color: Color(0xfff2426d),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(sTDRLGNCODE ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 15)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _fthMob() {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          decoration: BoxDecoration(
            color: const Color(0xfffce8ef),
            border: Border.all(color: const Color(0xfffce8ef), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: const Center(
            child: Icon(
              Icons.phone_outlined,
              color: Color(0xfff2426d),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(sTDFTHMOB ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 15)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _mthMob() {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          decoration: BoxDecoration(
            color: const Color(0xfffce8ef),
            border: Border.all(color: const Color(0xfffce8ef), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: const Center(
            child: Icon(
              Icons.phone_outlined,
              color: Color(0xfff2426d),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(sTDMTHMOB ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 15)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _fthName() {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          decoration: BoxDecoration(
            color: const Color(0xfffce8ef),
            border: Border.all(color: const Color(0xfffce8ef), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: const Center(
            child: Icon(
              Icons.man_outlined,
              color: Color(0xfff2426d),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(sTDFTHNAME ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 15)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _mthName() {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          decoration: BoxDecoration(
            color: const Color(0xfffce8ef),
            border: Border.all(color: const Color(0xfffce8ef), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: const Center(
            child: Icon(
              Icons.woman_outlined,
              color: Color(0xfff2426d),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(sTDMTHNAME ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 15)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _fthOcpn() {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          decoration: BoxDecoration(
            color: const Color(0xfffce8ef),
            border: Border.all(color: const Color(0xfffce8ef), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: const Center(
            child: Icon(
              Icons.work_outline,
              color: Color(0xfff2426d),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(sTDFTHOCPN ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 15)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _mthOcpn() {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          decoration: BoxDecoration(
            color: const Color(0xfffce8ef),
            border: Border.all(color: const Color(0xfffce8ef), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: const Center(
            child: Icon(
              Icons.work_outline,
              color: Color(0xfff2426d),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(sTDMTHOCPN ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 15)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _gender() {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          decoration: BoxDecoration(
            color: const Color(0xfffce8ef),
            border: Border.all(color: const Color(0xfffce8ef), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: const Center(
            child: Icon(
              Icons.wc_outlined,
              color: Color(0xfff2426d),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(sTDGNDR ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 15)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _admissionDt() {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          decoration: BoxDecoration(
            color: const Color(0xfffce8ef),
            border: Border.all(color: const Color(0xfffce8ef), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: const Center(
            child: Icon(
              Icons.person_outline_rounded,
              color: Color(0xfff2426d),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(sTDADMDT ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 15)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _adhaarNo() {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          decoration: BoxDecoration(
            color: const Color(0xfffce8ef),
            border: Border.all(color: const Color(0xfffce8ef), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: const Center(
            child: Icon(
              Icons.person_outline_rounded,
              color: Color(0xfff2426d),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(sTDADHNO ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 15)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _address() {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          decoration: BoxDecoration(
            color: const Color(0xfffce8ef),
            border: Border.all(color: const Color(0xfffce8ef), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: const Center(
            child: Icon(
              Icons.location_on_outlined,
              color: Color(0xfff2426d),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(sTDADRSPRSN ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 15)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _categoryCode() {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          decoration: BoxDecoration(
            color: const Color(0xfffce8ef),
            border: Border.all(color: const Color(0xfffce8ef), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: const Center(
            child: Icon(
              Icons.person_outline_rounded,
              color: Color(0xfff2426d),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(sTDCTGCODE ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 15)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _classRollSec() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildbutton(text: 'Class', value: sTDCLSCODE ?? ''),
        _buildDivider(),
        _buildbutton(text: 'Section', value: sTDSECCODE ?? ''),
        _buildDivider(),
        _buildbutton(text: 'Roll', value: sTDROLNO ?? ''),
      ],
    );
  }

  Widget _buildDivider() => Container(
        height: 24,
        width: 40,
        child: const VerticalDivider(),
      );

  Widget _buildbutton({required String text, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 14, color: kGrey),
          )
        ],
      ),
    );
  }

  void setDataFromAPI() async {
    DetailsRepo detailsRepo = DetailsRepo();
    StudentDetailsModel studentDetails = await detailsRepo.fetchData();

    setState(
      () {
        isLoading = false;
        sTDNAME = studentDetails.data![0].sTDNAME!;
        sTDGNDR = studentDetails.data![0].sTDGNDR!;
        sTDDOB = studentDetails.data![0].sTDDOB!;
        sTDIDNO = studentDetails.data![0].sTDIDNO!;
        sTDMOB = studentDetails.data![0].sTDMOB!;
        sTDCTGCODE = studentDetails.data![0].sTDCTGCODE!.toString();
        sTDADRSPRSN = studentDetails.data![0].sTDADRSPRSN!;
        sTDADRSPRMN = studentDetails.data![0].sTDADRSPRMN!;
        sTDPHTURL = studentDetails.data![0].sTDPHTURL!;

        print('profile ::: $sTDPHTURL');
      },
    );
  }

  void setFmlyDataFromAPI() async {
    DetailsRepo detailsRepo = DetailsRepo();
    StdFamlyDtlsModel studentDetails = await detailsRepo.fetchFamilyData();

    setState(
      () {
        isLoading = false;
        sTDFTHNAME = studentDetails.data![0].sTDFTHNAME!;
        sTDMTHNAME = studentDetails.data![0].sTDMTHNAME!;
        sTDMTHOCPN = studentDetails.data![0].sTDMTHOCPN!;
        sTDFTHOCPN = studentDetails.data![0].sTDFTHOCPN!;
        sTDFTHADHR = studentDetails.data![0].sTDFTHADHR!;
        sTDMTHADHR = studentDetails.data![0].sTDMTHADHR!;
        sTDFTHMOB = studentDetails.data![0].sTDFTHMOB!;
        sTDMTHMOB = studentDetails.data![0].sTDMTHMOB!;
      },
    );
  }

  void setAdmsnDataFromAPI() async {
    DetailsRepo detailsRepo = DetailsRepo();
    StdAdmsnDtlsModel studentDetails = await detailsRepo.fetchAdmsnData();

    setState(
      () {
        isLoading = false;
        sTDADMDT = studentDetails.data![0].sTDADMDT!;
        sTDBRANCH = studentDetails.data![0].sTDBRANCH!;
        sTDCODE = studentDetails.data![0].sTDCODE!.toString();
        sTDCouncilRegNo = studentDetails.data![0].sTDCouncilRegNo!;
        sTDROLNO = studentDetails.data![0].sTDROLNO!;
        sTDSemester = studentDetails.data![0].sTDSemester!;
        sTDAdmissionCategory = studentDetails.data![0].sTDAdmissionCategory!;
      },
    );
  }

  void setLstDataFromAPI() async {
    DetailsRepo detailsRepo = DetailsRepo();
    StdLstInstDtlsModel studentDetails = await detailsRepo.fetchLstData();

    setState(
      () {
        isLoading = false;
        institutionName = studentDetails.data![0].institutionName!;
        passingYear = studentDetails.data![0].passingYear!;
        sTDCODE = studentDetails.data![0].sTDCODE!.toString();
        universityName = studentDetails.data![0].universityName!;
        marks = studentDetails.data![0].marks!;
        passingCategory = studentDetails.data![0].passingCategory!;
        securedMarks = studentDetails.data![0].securedMarks!;
      },
    );
  }

  void setMtrcDataFromAPI() async {
    DetailsRepo detailsRepo = DetailsRepo();
    StdMatricDtlsModel studentDetails = await detailsRepo.fetchMtrcData();

    setState(
      () {
        isLoading = false;
        mInstitutionName = studentDetails.data![0].institutionName!;
        mPassingYear = studentDetails.data![0].passingYear!;
        sTDCODE = studentDetails.data![0].sTDCODE!.toString();
        boardName = studentDetails.data![0].boardName!;
        mMarks = studentDetails.data![0].marks!;
        mPassingCategory = studentDetails.data![0].passingCategory!;
        mSecuredMarks = studentDetails.data![0].securedMarks!;
      },
    );
  }
}
