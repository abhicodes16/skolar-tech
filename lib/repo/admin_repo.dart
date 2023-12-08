import 'package:pns_skolar/model/admin_home_model.dart';
import 'package:pns_skolar/model/log_entity/log_entity_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/api_constant.dart';
import '../../utils/api_provider.dart';
import '../model/log_entity/log_entity_details_model.dart';

class AdminRepo {
  final _provider = ApiProvider();

  Future<AdminHomeModel> fetchAdminHome() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url: '${ApiConstant.ADMIN_HOME}?schoolCode=$schoolCode',
      requestBody: {},
      token: pref.getString('token'),
    );

    return AdminHomeModel.fromJson(response);
  }
  
  Future<LogEntityModel> fetchLogData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url: '${ApiConstant.ADMIN_LOG}?schoolCode=$schoolCode',
      requestBody: {},
      token: pref.getString('token'),
    );

    return LogEntityModel.fromJson(response);
  }

  Future<LogEntityDetailsModel> fetchLogDetailsData(String entityId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'POST',
      url: '${ApiConstant.ADMIN_LOG_DETAILS}?schoolCode=$schoolCode',
      requestBody: {'entityId': entityId},
      token: pref.getString('token'),
    );

    return LogEntityDetailsModel.fromJson(response);
  }
}
