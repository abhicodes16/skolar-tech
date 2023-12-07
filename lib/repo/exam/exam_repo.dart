import 'package:shared_preferences/shared_preferences.dart';
import '../../model/exam/exam_details_model.dart';
import '../../model/exam/exam_model.dart';
import '../../model/exam/exam_result_column_model.dart';
import '../../model/exam/exam_result_column_val_model.dart';
import '../../model/exam/exam_result_name_model.dart';
import '../../utils/api_constant.dart';
import '../../utils/api_provider.dart';

class ExamRepo {
  final _provider = ApiProvider();

  Future<ExamResultNameModel> fetchExamResultName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String deviceId = pref.getString('deviceId') ?? '';
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url: '${ApiConstant.EXAM_RESULT_NAME}?schoolCode=$schoolCode',
      requestBody: {},
      token: pref.getString('token'),
    );

    print('Response::$response');

    return ExamResultNameModel.fromJson(response);
  }

  Future<ExamResultColumnModel> fetchExamResultColumn(String examCode) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url: '${ApiConstant.EXAM_RESULT_COLUMN}?schoolCode=$schoolCode',
      requestBody: {},
      token: pref.getString('token'),
    );

    print('Response::$response');

    return ExamResultColumnModel.fromJson(response);
  }

  Future<ExamResultColumnValModel> fetchExamResultColumnValue(
      String examCode) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String deviceId = pref.getString('deviceId') ?? '';
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'POST',
      url: '${ApiConstant.EXAM_RESULT_COLUMN_VAL}?schoolCode=$schoolCode',
      requestBody: {'examCode': examCode},
      token: pref.getString('token'),
    );

    print('Response::$response');

    return ExamResultColumnValModel.fromJson(response);
  }

  Future<ExamModel> fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String deviceId = pref.getString('deviceId') ?? '';
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url: '${ApiConstant.EXAM_LIST}?schoolCode=$schoolCode',
      requestBody: {},
      token: pref.getString('token'),
    );

    print('Response::$response');

    return ExamModel.fromJson(response);
  }

  Future<ExamDetailsModel> fetchResultDetailsById(String testId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String deviceId = pref.getString('deviceId') ?? '';
    String schoolCode = pref.getString('schoolCode') ?? '';

    var reqBody = {'testId': testId};

    final response = await _provider.httpMethodWithToken(
      method: 'POST',
      url: '${ApiConstant.EXAM_DETAILS}?schoolCode=$schoolCode',
      requestBody: reqBody,
      token: pref.getString('token'),
    );

    print('Response::$response');

    return ExamDetailsModel.fromJson(response);
  }
}
