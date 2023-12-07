import 'dart:async';

import '../../model/holiday/holiday_model.dart';
import '../../repo/holiday/holiday_repo.dart';
import '../../utils/response.dart';

class HolidayBloc {
  late HolidayRepo holidayRepo;
  late StreamController _dataController;

  StreamSink get dataSink => _dataController.sink;
  Stream get dataStream => _dataController.stream;

  HolidayBloc() {
    _dataController = StreamController();
    holidayRepo = HolidayRepo();
    fetchdata();
  }

  fetchdata() async {
    dataSink.add(Response.loading('Loading Data..!'));

    try {
      HolidayModel data = await holidayRepo.fetchData();
      dataSink.add(Response.completed(data));
    } catch (e) {
      dataSink.add(Response.error('$e'));
    }
  }
}
