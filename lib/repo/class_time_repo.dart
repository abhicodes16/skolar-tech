import 'package:pns_skolar/model/class_time_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/api_constant.dart';
import '../../utils/api_provider.dart';

class ClassStartTimeRepo {
  final _provider = ApiProvider();

  Future<ClassStartTimeModel> fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethod(
      method: 'POST',
      url: '${ApiConstant.CLASS_START_TIME}?schoolCode=$schoolCode',
      requestBody: {'sessionId': '1'},
    );

    return ClassStartTimeModel.fromJson(response);
  }
}
