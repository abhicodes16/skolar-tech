import 'dart:async';

import '../../model/attendance/attendance_model.dart';
import '../../repo/attendance/attendance_repo.dart';
import '../../utils/response.dart';

class AttendanceBloc {
  late AttendanceRepo attendanceRepo;
  late StreamController _dataController;

  StreamSink get dataSink => _dataController.sink;
  Stream get dataStream => _dataController.stream;

  AttendanceBloc() {
    _dataController = StreamController();
    attendanceRepo = AttendanceRepo();
    fetchdata();
  }

  fetchdata() async {
    dataSink.add(Response.loading('Loading Data..!'));

    try {
      AttendanceModel data = await attendanceRepo.fetchData();
      dataSink.add(Response.completed(data));
    } catch (e) {
      dataSink.add(Response.error('$e'));
    }
  }
}
