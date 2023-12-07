import 'package:pns_skolar/model/Details/std_fmly_dtls_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/Details/std_admsn_dtls_model.dart';
import '../../model/Details/std_lst_admsn_model.dart';
import '../../model/Details/std_matric_details_model.dart';
import '../../model/Details/student_details_model.dart';
import '../../utils/api_constant.dart';
import '../../utils/api_provider.dart';

class DetailsRepo {
  final _provider = ApiProvider();

  Future<StudentDetailsModel> fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url: '${ApiConstant.STD_DTLS}?schoolCode=$schoolCode',
      requestBody: {},
      token: pref.getString('token'),
    );

    return StudentDetailsModel.fromJson(response);
  }

  Future<StdFamlyDtlsModel> fetchFamilyData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url: "${ApiConstant.STD_FML_DTLS}?schoolCode=$schoolCode",
      requestBody: {},
      token: pref.getString('token'),
    );

    return StdFamlyDtlsModel.fromJson(response);
  }

  Future<StdAdmsnDtlsModel> fetchAdmsnData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url: '${ApiConstant.STD_ADMSN_DTLS}?schoolCode=$schoolCode',
      requestBody: {},
      token: pref.getString('token'),
    );

    return StdAdmsnDtlsModel.fromJson(response);
  }

  Future<StdLstInstDtlsModel> fetchLstData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url: '${ApiConstant.STD_LST_DTLS}?schoolCode=$schoolCode',
      requestBody: {},
      token: pref.getString('token'),
    );

    return StdLstInstDtlsModel.fromJson(response);
  }

  Future<StdMatricDtlsModel> fetchMtrcData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url: "${ApiConstant.STD_MTRC_DTLS}?schoolCode=$schoolCode",
      requestBody: {},
      token: pref.getString('token'),
    );

    // print('Response::$response');

    return StdMatricDtlsModel.fromJson(response);
  }
}
