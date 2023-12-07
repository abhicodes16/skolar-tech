import 'dart:async';
import 'package:pns_skolar/model/notification/notification_type_model.dart';

import '../../repo/notification/notification_repo.dart';
import '../../utils/response.dart';

class NotificationBloc {
  late NotificationRepo notificationRepo;
  late StreamController _dataController;

  StreamSink get dataSink => _dataController.sink;
  Stream get dataStream => _dataController.stream;

  NotificationBloc() {
    _dataController = StreamController();
    notificationRepo = NotificationRepo();
    fetchdata();
  }

  fetchdata() async {
    dataSink.add(Response.loading('Loading Data..!'));

    try {
      NotificationTypeModel data = await notificationRepo.fetchData();
      dataSink.add(Response.completed(data));
    } catch (e) {
      dataSink.add(Response.error('$e'));
    }
  }
}
