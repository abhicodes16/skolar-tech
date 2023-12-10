import 'package:pns_skolar/model/common_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/api_constant.dart';
import '../utils/api_provider.dart';

class ChangePassRepo {
  final _provider = ApiProvider();

  Future<CommonModel> sendReq({String? oldPassword, String? newPass}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';

    bool isAdmin = pref.getBool('isAdmin') ?? false;
    bool isTeacher = pref.getBool('isTeacher') ?? false;

    String url = ApiConstant.STD_CHANGE_PASS;
    if (isTeacher) {
      url = ApiConstant.TEACHER_CHANGE_PASS;
    }
    if (isAdmin) {
      url = ApiConstant.ADMIN_CHANGE_PASS;
    }

    final response = await _provider.httpMethodWithToken(
      method: 'POST',
      url: '$url?schoolCode=$schoolCode',
      requestBody: {
        'oldPassword': oldPassword,
        'newPassword': newPass,
        'confirmPassword': newPass,
      },
      token: pref.getString('token'),
    );
    return CommonModel.fromJson(response);
  }
}

class NetworkError extends Error {}
