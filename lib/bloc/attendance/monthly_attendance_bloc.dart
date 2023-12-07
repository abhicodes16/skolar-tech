import 'dart:async';

import '../../model/attendance/monthly_attendance_model.dart';
import '../../repo/attendance/monthly_attendance_repo.dart';
import '../../utils/response.dart';

class MonthlyAttendanceBloc {
  late MonthlyAttendanceRepo monthlyAttendanceRepo;
  late StreamController _dataController;

  StreamSink get dataSink => _dataController.sink;
  Stream get dataStream => _dataController.stream;

  MonthlyAttendanceBloc({
    required String? monthName,
    required String? year,
  }) {
    _dataController = StreamController();
    monthlyAttendanceRepo = MonthlyAttendanceRepo();
    fetchdata(
      monthName: monthName,
      year: year,
    );
  }

  fetchdata({
    required String? monthName,
    required String? year,
  }) async {
    dataSink.add(Response.loading('Loading Data..!'));

    try {
      MonthlyAttendanceModel data = await monthlyAttendanceRepo.fetchData(
        monthName: monthName,
        year: year,
      );
      dataSink.add(Response.completed(data));
    } catch (e) {
      dataSink.add(Response.error('$e'));
    }
  }
}
