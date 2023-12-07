import 'package:shared_preferences/shared_preferences.dart';

import '../../model/attendance/attendance_model.dart';
import '../../utils/api_constant.dart';
import '../../utils/api_provider.dart';

class AttendanceRepo {
  final _provider = ApiProvider();

  Future<AttendanceModel> fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url: '${ApiConstant.ATTENDANCE_LIST}?schoolCode=$schoolCode',
      requestBody: {},
      token: pref.getString('token'),
    );

    print('Response::$response');

    return AttendanceModel.fromJson(response);
  }
}
