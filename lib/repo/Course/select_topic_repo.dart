import '../../model/course/select_topic_model.dart';
import '../../utils/api_constant.dart';
import '../../utils/api_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectTopicRepo {
  final _provider = ApiProvider();

  Future<SelectTopicModel> fetchData({
    required String? sUBID,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String schoolCode = pref.getString('schoolCode') ?? '';

    print('sub id :: $sUBID');

    final response = await _provider.httpMethod(
      method: 'POST',
      url: '${ApiConstant.SELECT_TOPIC}?schoolCode=$schoolCode',
      requestBody: {
        'SUB_ID': sUBID,
      },
    );

    return SelectTopicModel.fromJson(response);
  }
}
