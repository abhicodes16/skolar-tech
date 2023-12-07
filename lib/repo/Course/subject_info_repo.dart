import 'package:pns_skolar/model/common_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/course/subject_details_model.dart';
import '../../utils/api_constant.dart';
import '../../utils/api_provider.dart';

class SubjectRepo {
  final _provider = ApiProvider();

  Future<SubjectDetailsModel> fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url: '${ApiConstant.SUBJECT_DETAILS}?schoolCode=$schoolCode',
      requestBody: {},
      token: pref.getString('token'),
    );

    print('Response::$response');

    return SubjectDetailsModel.fromJson(response);
  }

  Future<CommonModel> sendCourseData({
    required String? topicID,
    required String? covPosition,
    required String? covDate,
    required String? covTime,
    required String? remarks,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';
    final response = await _provider.httpMethodWithToken(
      method: 'POST',
      url: '${ApiConstant.CRS_COVERED_}?schoolCode=$schoolCode',
      requestBody: {
        'Topic_Id': topicID,
        'Cov_Position': covPosition,
        'Cov_Date': covDate,
        'Cov_Time': covTime,
        'Remarks': remarks,
      },
      token: pref.getString('token'),
    );

    print('Response::$response');

    return CommonModel.fromJson(response);
  }
}
