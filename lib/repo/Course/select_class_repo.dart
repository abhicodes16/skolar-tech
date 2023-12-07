import 'package:pns_skolar/model/course/class_select_model.dart';

import '../../model/course/branch_select_model.dart';
import '../../model/course/semester_select_model.dart';
import '../../model/course/subject_select_model.dart';
import '../../utils/api_constant.dart';
import '../../utils/api_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectClassRepo {
  final _provider = ApiProvider();

  Future<ClassSelectModel> fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethod(
      method: 'GET',
      url: '${ApiConstant.SELECT_CLASS}?schoolCode=$schoolCode',
      requestBody: {},
    );

    return ClassSelectModel.fromJson(response);
  }

  Future<SemesterSelectModel> fetchSemData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethod(
      method: 'GET',
      url: '${ApiConstant.SELECT_SEMESTER}?schoolCode=$schoolCode',
      requestBody: {},
    );

    return SemesterSelectModel.fromJson(response);
  }

  Future<BranchSelectModel> fetchBranchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethod(
      method: 'GET',
      url: '${ApiConstant.BRANCH_NAME}?schoolCode=$schoolCode',
      requestBody: {},
    );

    return BranchSelectModel.fromJson(response);
  }

  Future<SubjectSelectModel> fetchSubjectData({
    required String? cLSCODE,
    required String? sEMECODE,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethod(
      method: 'POST',
      url: '${ApiConstant.SELECT_SUBJECT}?schoolCode=$schoolCode',
      requestBody: {
        'CLS_CODE': cLSCODE,
        'SEME_CODE': sEMECODE,
      },
    );

    return SubjectSelectModel.fromJson(response);
  }
}
