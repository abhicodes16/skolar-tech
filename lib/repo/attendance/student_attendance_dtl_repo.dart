import 'package:shared_preferences/shared_preferences.dart';

import '../../model/attendance/attendance_hdr_model.dart';
import '../../model/attendance/student_attnc_detail_model.dart';
import '../../model/common_model.dart';
import '../../utils/api_constant.dart';
import '../../utils/api_provider.dart';

class StudentAttendanceRepo {
  final _provider = ApiProvider();

  Future<StudentAttendanceModel> fetchData({
    required String? cLS_CODE,
    required String? sEME_CODE,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String schoolCode = pref.getString('schoolCode') ?? '';

    var reqbody = {
      'CLS_CODE': cLS_CODE,
      'SEME_CODE': sEME_CODE,
    };

    print('req body ::: $reqbody');

    final response = await _provider.httpMethod(
      method: 'POST',
      url: '${ApiConstant.STUDENT_ATT_DTLS}?schoolCode=$schoolCode',
      requestBody: reqbody,
    );

    print('Response::$response');

    return StudentAttendanceModel.fromJson(response);
  }

  Future<AttsHdrModel> fetchHdrData({
    required String? bRANCHID,
    required String? sEMESTERID,
    required String? sUBID,
    required String? aTDSDATE,
    required String? aTDSTIME,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'POST',
      url: '${ApiConstant.ATT_HDR_INSRT}?schoolCode=$schoolCode',
      requestBody: {
        'BRANCH_ID': bRANCHID,
        'SEMESTER_ID': sEMESTERID,
        'SUB_ID': sUBID,
        'ATDS_DATE': aTDSDATE,
        'ATDS_TIME': aTDSTIME,
      },
      token: pref.getString('token'),
    );
    print('Response::$response');

    return AttsHdrModel.fromJson(response);
  }

  Future<CommonModel> addAttendaceClassWise({
    required String branchCode,
    required String semesterCode,
    required String subjectCode,
    required String attendanceDate,
    required String attendanceTime,
    required String studentCodePresent,
    required String studentCodeAbsent,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String schoolCode = pref.getString('schoolCode') ?? '';

    print('date :::: $attendanceDate');

    final response = await _provider.httpMethodWithToken(
      method: 'POST',
      url: '${ApiConstant.ATTENDACE_CLASS_WISE}?schoolCode=$schoolCode',
      requestBody: {
        "branchCode": branchCode,
        "semesterCode": semesterCode,
        "subjectCode": subjectCode,
        "attendanceDate": attendanceDate,
        "attendanceTime": attendanceTime,
        "studentCodePresent": studentCodePresent,
        "studentCodeAbsent": studentCodeAbsent,
      },
      token: pref.getString('token'),
    );

    print('Response::$response');

    return CommonModel.fromJson(response);
  }
}
