import 'dart:async';
import '../../model/exam/exam_model.dart';
import '../../repo/exam/exam_repo.dart';
import '../../utils/response.dart';

class ExamBloc {
  late ExamRepo examRepo;
  late StreamController _dataController;

  StreamSink get dataSink => _dataController.sink;
  Stream get dataStream => _dataController.stream;

  ExamBloc() {
    _dataController = StreamController();
    examRepo = ExamRepo();
    fetchdata();
  }

  fetchdata() async {
    dataSink.add(Response.loading('Loading Data..!'));

    try {
      ExamModel data = await examRepo.fetchData();
      dataSink.add(Response.completed(data));
    } catch (e) {
      dataSink.add(Response.error('$e'));
    }
  }
}
