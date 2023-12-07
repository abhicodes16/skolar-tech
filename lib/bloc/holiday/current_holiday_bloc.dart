import 'dart:async';

import '../../model/holiday/current_holiday_model.dart';
import '../../repo/holiday/holiday_repo.dart';
import '../../utils/response.dart';

class CurrentHolidayBloc {
  late HolidayRepo holidayRepo;
  late StreamController _dataController;

  StreamSink get dataSink => _dataController.sink;
  Stream get dataStream => _dataController.stream;

  CurrentHolidayBloc({
    required String? monthName,
    required String? yearName,
  }) {
    _dataController = StreamController();
    holidayRepo = HolidayRepo();
    fetchdata(
      monthName: monthName,
      yearName: yearName,
    );
  }

  fetchdata({
    required String? monthName,
    required String? yearName,
  }) async {
    dataSink.add(Response.loading('Loading Data..!'));

    try {
      CurrentHolidayModel data = await holidayRepo.fetchCurrentData(
        monthName: monthName,
        yearName: yearName,
      );
      dataSink.add(Response.completed(data));
    } catch (e) {
      dataSink.add(Response.error('$e'));
    }
  }
}
