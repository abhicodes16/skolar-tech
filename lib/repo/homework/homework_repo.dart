import 'package:shared_preferences/shared_preferences.dart';
import '../../model/common_model.dart';
import '../../model/homework/home_work_summary_model.dart';
import '../../model/homework/homework_model.dart';
import '../../utils/api_constant.dart';
import '../../utils/api_provider.dart';

class HomeWorkRepo {
  final _provider = ApiProvider();

  Future<HomeworkModel> fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String deviceId = pref.getString('deviceId') ?? '';
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url:
          '${ApiConstant.HOMEWORK_LIST}?schoolCode=$schoolCode&deviceId=$deviceId',
      requestBody: {},
      token: pref.getString('token'),
    );

    print('Response::$response');

    return HomeworkModel.fromJson(response);
  }

  Future<HomeWorkSummaryModel> fetchSummaryData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';
    String deviceId = pref.getString('deviceId') ?? '';
    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url:
          '${ApiConstant.HOMEWORK_SUMMARY}?schoolCode=$schoolCode&deviceId=$deviceId',
      requestBody: {},
      token: pref.getString('token'),
    );

    print('Response::$response');

    return HomeWorkSummaryModel.fromJson(response);
  }

  Future<CommonModel> sendRemarkData({
    required String assignCode,
    required String remark,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';
    String deviceId = pref.getString('deviceId') ?? '';
    final response = await _provider.httpMethodWithToken(
      method: 'POST',
      url:
          '${ApiConstant.HOMEWORK_STATUS_UPDATE}?schoolCode=$schoolCode&deviceId=$deviceId',
      requestBody: {
        "AsignCode": assignCode,
        "completionRemark": remark,
      },
      token: pref.getString('token'),
    );

    print('Response::$response');

    return CommonModel.fromJson(response);
  }
}
