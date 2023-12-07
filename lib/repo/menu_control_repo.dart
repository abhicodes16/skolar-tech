import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/api_constant.dart';
import '../../utils/api_provider.dart';
import '../model/menu_control_model.dart';

class MenuControlRepo {
  final _provider = ApiProvider();

  Future<MenuControlModel> fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCodeName = pref.getString('schoolCodeName') ?? '';

    bool isTeacher = pref.getBool('isTeacher') ?? false;

    String baseUrl = '';
    if (isTeacher) {
      baseUrl = ApiConstant.MENU_TEACHER;
    } else {
      baseUrl = ApiConstant.MENU_STUDENT;
    }

    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url: '$baseUrl?schoolCode=$schoolCodeName',
      requestBody: {},
      token: pref.getString('token'),
    );

    return MenuControlModel.fromJson(response);
  }
}
