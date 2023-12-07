import 'package:shared_preferences/shared_preferences.dart';

import '../../model/attendance/attndc_summary_model.dart';
import '../../utils/api_constant.dart';
import '../../utils/api_provider.dart';

class AttendanceSummaryRepo {
  final _provider = ApiProvider();

  Future<AttendanceSummaryModel> fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url: '${ApiConstant.ATTENDANCE_SUMMARY}?schoolCode=$schoolCode',
      requestBody: {},
      token: pref.getString('token'),
    );

    print('Response::$response');

    return AttendanceSummaryModel.fromJson(response);
  }
}
