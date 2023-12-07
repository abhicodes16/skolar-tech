import 'package:shared_preferences/shared_preferences.dart';
import '../../model/holiday/current_holiday_model.dart';
import '../../model/holiday/holiday_model.dart';
import '../../utils/api_constant.dart';
import '../../utils/api_provider.dart';

class HolidayRepo {
  final _provider = ApiProvider();

  Future<HolidayModel> fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url: '${ApiConstant.HOLIDAY_LIST}?schoolCode=$schoolCode',
      requestBody: {},
      token: pref.getString('token'),
    );

    print('Response::$response');

    return HolidayModel.fromJson(response);
  }

  Future<CurrentHolidayModel> fetchCurrentData({
    required String? monthName,
    required String? yearName,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethod(
      method: 'POST',
      url: '${ApiConstant.CURRENT_HOLIDAY_LIST}?schoolCode=$schoolCode',
      requestBody: {
        'monthName': monthName,
        'yearName': yearName,
      },
    );

    print('Response::$response');

    return CurrentHolidayModel.fromJson(response);
  }
}
