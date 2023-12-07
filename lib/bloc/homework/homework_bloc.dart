import 'dart:async';

import '../../model/homework/homework_model.dart';
import '../../repo/homework/homework_repo.dart';
import '../../utils/response.dart';

class HomeWorkBloc {
  late HomeWorkRepo homeWorkRepo;
  late StreamController _dataController;

  StreamSink get dataSink => _dataController.sink;
  Stream get dataStream => _dataController.stream;

  HomeWorkBloc({
    required String? schoolCode,
  }) {
    _dataController = StreamController();
    homeWorkRepo = HomeWorkRepo();
    fetchdata(schoolCode: schoolCode);
  }

  fetchdata({required String? schoolCode, bool? isLoading = true}) async {
    if (isLoading!) {
      dataSink.add(Response.loading('Loading Data..!'));
    }

    try {
      HomeworkModel data = await homeWorkRepo.fetchData();
      dataSink.add(Response.completed(data));
    } catch (e) {
      dataSink.add(Response.error('$e'));
    }
  }
}
