import 'package:shared_preferences/shared_preferences.dart';

import '../../model/common_model.dart';
import '../../model/notice/notice_model.dart';
import '../../model/notice/notice_summary_model.dart';
import '../../utils/api_constant.dart';
import '../../utils/api_provider.dart';

class NoticeRepo {
  final _provider = ApiProvider();

  Future<NoticeModel> fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';
    print('notice ::: $schoolCode');
    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url: '${ApiConstant.STD_NOTICE}?schoolCode=$schoolCode',
      requestBody: {},
      token: pref.getString('token'),
    );

    print('Response::$response');

    return NoticeModel.fromJson(response);
  }

  Future<NoticeSummaryModel> fetchSummaryData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';
    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url: '${ApiConstant.NOTICE_SUMMARY}?schoolCode=$schoolCode',
      requestBody: {},
      token: pref.getString('token'),
    );

    print('Response::$response');

    return NoticeSummaryModel.fromJson(response);
  }

  Future<CommonModel> fetchNoticeData(String noticeCode) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';
    final response = await _provider.httpMethodWithToken(
      method: 'POST',
      url: '${ApiConstant.READ_STATUS}?schoolCode=$schoolCode',
      requestBody: {
        'noticeCode': noticeCode,
      },
      token: pref.getString('token'),
    );

    return CommonModel.fromJson(response);
  }
}
