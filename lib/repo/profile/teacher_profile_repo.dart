import 'package:shared_preferences/shared_preferences.dart';
import '../../model/teacher_profile_model.dart';
import '../../utils/api_constant.dart';
import '../../utils/api_provider.dart';

class TeacherProfileRepo {
  final _provider = ApiProvider();

  Future<TeacherProfileModel> fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url: '${ApiConstant.TEACHER_PROFILE}?schoolCode=$schoolCode',
      requestBody: {},
      token: pref.getString('token'),
    );

    print('Response::$response');

    return TeacherProfileModel.fromJson(response);
  }
}
