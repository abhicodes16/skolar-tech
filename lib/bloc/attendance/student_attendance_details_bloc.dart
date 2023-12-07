import 'dart:async';
import '../../model/attendance/student_attnc_detail_model.dart';
import '../../repo/attendance/student_attendance_dtl_repo.dart';
import '../../utils/response.dart';

class StdAttendanceDetailsBloc {
  late StudentAttendanceRepo studentAttendanceRepo;
  late StreamController _dataController;

  StreamSink get dataSink => _dataController.sink;
  Stream get dataStream => _dataController.stream;

  StdAttendanceDetailsBloc({
    required String? cLS_CODE,
    required String? sEME_CODE,
  }) {
    _dataController = StreamController();
    studentAttendanceRepo = StudentAttendanceRepo();
    fetchdata(
      cLS_CODE: cLS_CODE,
      sEME_CODE: sEME_CODE,
    );
  }

  fetchdata({
    required String? cLS_CODE,
    required String? sEME_CODE,
  }) async {
    dataSink.add(Response.loading('Loading Data..!'));

    try {
      StudentAttendanceModel data = await studentAttendanceRepo.fetchData(
        cLS_CODE: cLS_CODE,
        sEME_CODE: sEME_CODE,
      );
      dataSink.add(Response.completed(data));
    } catch (e) {
      dataSink.add(Response.error('$e'));
    }
  }
}
