import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/api_constant.dart';
import '../../utils/api_provider.dart';
import '../model/school_info_model.dart';

class SchoolInfoRepo {
  final _provider = ApiProvider();

  Future<SchoolInfoModel> fetchData({required String? schoolCode}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    
    final response = await _provider.httpMethod(
      method: 'GET',
      url: '${ApiConstant.SCHOOL_INFO}$schoolCode',
      requestBody: {},
    );

    print('Response::$response');

    return SchoolInfoModel.fromJson(response);
  }
}
