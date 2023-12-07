import 'package:shared_preferences/shared_preferences.dart';
import '../../model/News/news_model.dart';
import '../../utils/api_constant.dart';
import '../../utils/api_provider.dart';

class NewsRepo {
  final _provider = ApiProvider();

  Future<NewsModel> fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';

    final response = await _provider.httpMethodWithToken(
      method: 'GET',
      url: '${ApiConstant.STD_NEWS}?schoolCode=$schoolCode',
      requestBody: {},
      token: pref.getString('token'),
    );

    print('Response::$response');

    return NewsModel.fromJson(response);
  }
}
