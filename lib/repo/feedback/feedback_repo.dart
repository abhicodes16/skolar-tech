import 'package:pns_skolar/model/common_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/feedback/feedback_entity_model.dart';
import '../../model/feedback/feedback_history_model.dart';
import '../../utils/api_constant.dart';
import '../../utils/api_provider.dart';

class FeedbackRepo {
  final _provider = ApiProvider();

  Future<FeedbackEntityModel> feedbackEntity() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url: '${ApiConstant.FEEDBACK_ENTITY}?schoolCode=$schoolCode',
      requestBody: {},
      token: pref.getString('token'),
    );

    return FeedbackEntityModel.fromJson(response);
  }

  Future<FeedbackHistoryModel> feedbackHistory() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url: '${ApiConstant.FEEDBACK_HISTORY}?schoolCode=$schoolCode',
      requestBody: {},
      token: pref.getString('token'),
    );

    return FeedbackHistoryModel.fromJson(response);
  }

  Future<CommonModel> sendFeedback({
    required String entityId,
    required String statusLevel,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'POST',
      url: '${ApiConstant.ADD_FEEDBACK}?schoolCode=$schoolCode',
      requestBody: {
        'entityId': entityId,
        'SATS_LVL': statusLevel,
      },
      token: pref.getString('token'),
    );

    return CommonModel.fromJson(response);
  }
}
