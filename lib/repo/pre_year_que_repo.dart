import 'package:pns_skolar/model/previous_year_questions/previous_year_quation_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/api_constant.dart';
import '../../utils/api_provider.dart';

class PreYearQueRepo {
  final _provider = ApiProvider();

  Future<PreviousYearQuestionModel> fetchData(String subjectCode) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'POST',
      url: '${ApiConstant.PRE_YR_QUE}?schoolCode=$schoolCode',
      requestBody: {
        'subjectCode': subjectCode,
      },
      token: pref.getString('token'),
    );

    print('Response::$response');

    return PreviousYearQuestionModel.fromJson(response);
  }
}
