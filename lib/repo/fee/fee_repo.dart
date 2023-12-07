import 'package:shared_preferences/shared_preferences.dart';

import '../../model/fee/dua_amt_model.dart';
import '../../model/fee/fee_model.dart';
import '../../model/fee/fees_structure_model.dart';
import '../../utils/api_constant.dart';
import '../../utils/api_provider.dart';

class FeeRepo {
  final _provider = ApiProvider();

  Future<FeeModel> fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url: '${ApiConstant.FEE_COLLECTION}?schoolCode=$schoolCode',
      requestBody: {},
      token: pref.getString('token'),
    );

    print('Response::$response');

    return FeeModel.fromJson(response);
  }

  Future<DuaAmtModel> fetchDuaAmtData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url: '${ApiConstant.DUA_AMT}?schoolCode=$schoolCode',
      requestBody: {},
      token: pref.getString('token'),
    );

    print('Response::$response');

    return DuaAmtModel.fromJson(response);
  }

  Future<DuaAmtModel> fetchUpcomingAmtData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url: '${ApiConstant.UPCOMING_AMT}?schoolCode=$schoolCode',
      requestBody: {},
      token: pref.getString('token'),
    );

    print('Response::$response');

    return DuaAmtModel.fromJson(response);
  }

  Future<FeesStructureModel> fetchFeesStructure() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url: '${ApiConstant.FEE_STRUCTURE}?schoolCode=$schoolCode',
      requestBody: {},
      token: pref.getString('token'),
    );

    print('Response::$response');

    return FeesStructureModel.fromJson(response);
  }
}
