import 'dart:async';

import '../../model/notice/notice_model.dart';
import '../../repo/notice/notice_repo.dart';
import '../../utils/response.dart';

class NoticeBloc {
  late NoticeRepo noticeRepo;
  late StreamController _dataController;

  StreamSink get dataSink => _dataController.sink;
  Stream get dataStream => _dataController.stream;

  NoticeBloc() {
    _dataController = StreamController();
    noticeRepo = NoticeRepo();
    fetchdata();
  }

  fetchdata({bool? isLoading = true}) async {
    if (isLoading!) {
      dataSink.add(Response.loading('Loading Data..!'));
    }

    try {
      NoticeModel data = await noticeRepo.fetchData();
      dataSink.add(Response.completed(data));
    } catch (e) {
      dataSink.add(Response.error('$e'));
    }
  }
}
