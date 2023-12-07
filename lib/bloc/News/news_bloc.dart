import 'dart:async';

import '../../model/News/news_model.dart';
import '../../repo/News/news_repo.dart';
import '../../utils/response.dart';

class NewsBloc {
  late NewsRepo newsRepo;
  late StreamController _dataController;

  StreamSink get dataSink => _dataController.sink;
  Stream get dataStream => _dataController.stream;

  NewsBloc() {
    _dataController = StreamController();
    newsRepo = NewsRepo();
    fetchdata();
  }

  fetchdata() async {
    dataSink.add(Response.loading('Loading Data..!'));

    try {
      NewsModel data = await newsRepo.fetchData();
      dataSink.add(Response.completed(data));
    } catch (e) {
      dataSink.add(Response.error('$e'));
    }
  }
}
