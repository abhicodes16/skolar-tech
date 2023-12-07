import 'package:pns_skolar/model/notification/all_notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/notification/notification_by_id_model.dart';
import '../../model/notification/notification_type_model.dart';
import '../../utils/api_constant.dart';
import '../../utils/api_provider.dart';

class NotificationRepo {
  final _provider = ApiProvider();

  Future<NotificationTypeModel> fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url: '${ApiConstant.NOTIFICATION_TYPE}?schoolCode=$schoolCode',
      requestBody: {},
      token: pref.getString('token'),
    );

    return NotificationTypeModel.fromJson(response);
  }

  Future<NotificationByIdModel> sendData({required String? id}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'POST',
      url: '${ApiConstant.NOTIFICATION_BYID}?schoolCode=$schoolCode',
      requestBody: {
        'typeName': id,
      },
      token: pref.getString('token'),
    );

    return NotificationByIdModel.fromJson(response);
  }

  Future<AllNotificationModel> sendDataToApi({required String? ntfId}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'POST',
      url: '${ApiConstant.ALL_NOTIFICATION}?schoolCode=$schoolCode',
      requestBody: {
        'ntfId': ntfId,
      },
      token: pref.getString('token'),
    );

    return AllNotificationModel.fromJson(response);
  }
}
