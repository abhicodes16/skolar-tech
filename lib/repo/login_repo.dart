import '../model/login_model.dart';
import '../model/teacher-login_model.dart';
import '../utils/api_constant.dart';
import '../utils/api_provider.dart';

class LoginRepo {
  final _provider = ApiProvider();

  Future<LoginModel> sendLoginReq({
    String? userName,
    String? password,
    String? deviceId,
    String? deviceToken,
    String? iPAddress,
    required String? schoolCode,
  }) async {
    final response = await _provider.httpMethod(
      method: 'POST',
      url: '${ApiConstant.LOGIN}$schoolCode',
      requestBody: {
        'UserName': userName,
        'Password': password,
        'DeviceId': deviceId,
        'DeviceToken': deviceToken,
        'IPAddress': iPAddress,
      },
    );
    print('Response::$response');

    return LoginModel.fromJson(response);
  }

  Future<LoginTeacherModel> sendTeacherReq({
    String? userName,
    String? password,
    String? deviceId,
    String? deviceToken,
    String? iPAddress,
    required String? schoolCode,
  }) async {
    final response = await _provider.httpMethod(
      method: 'POST',
      url: '${ApiConstant.TEACHER_LOGIN}$schoolCode',
      requestBody: {
        'UserName': userName,
        'Password': password,
        'DeviceId': deviceId,
        'DeviceToken': deviceToken,
        'IPAddress': iPAddress,
      },
    );
    return LoginTeacherModel.fromJson(response);
  }
}

class NetworkError extends Error {}
