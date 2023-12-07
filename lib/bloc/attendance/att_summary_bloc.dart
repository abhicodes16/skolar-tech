import 'dart:async';
import '../../model/attendance/attndc_summary_model.dart';
import '../../repo/attendance/at_summary_repo.dart';
import '../../utils/response.dart';

class AttendanceSummaryBloc {
  late AttendanceSummaryRepo attendanceSummaryRepo;
  late StreamController _dataController;

  StreamSink get dataSink => _dataController.sink;
  Stream get dataStream => _dataController.stream;

  AttendanceSummaryBloc() {
    _dataController = StreamController();
    attendanceSummaryRepo = AttendanceSummaryRepo();
    fetchdata();
  }

  fetchdata() async {
    dataSink.add(Response.loading('Loading Data..!'));

    try {
      AttendanceSummaryModel data = await attendanceSummaryRepo.fetchData();
      dataSink.add(Response.completed(data));
    } catch (e) {
      dataSink.add(Response.error('$e'));
    }
  }
}
