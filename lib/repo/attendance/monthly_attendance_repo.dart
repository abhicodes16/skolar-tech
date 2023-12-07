import 'package:shared_preferences/shared_preferences.dart';

import '../../model/attendance/monthly_attendance_model.dart';
import '../../utils/api_constant.dart';
import '../../utils/api_provider.dart';

class MonthlyAttendanceRepo {
  final _provider = ApiProvider();

  Future<MonthlyAttendanceModel> fetchData({
    required String? monthName,
    required String? year,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'POST',
      url: '${ApiConstant.MONTHLY_ATTENDANCE}?schoolCode=$schoolCode',
      requestBody: {
        'monthName': monthName,
        'year': year,
      },
      token: pref.getString('token'),
    );

    print('Response::$response');

    return MonthlyAttendanceModel.fromJson(response);
  }
}
