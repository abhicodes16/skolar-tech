import 'dart:async';
import 'package:pns_skolar/model/notification/all_notification_model.dart';
import 'package:pns_skolar/repo/notification/notification_repo.dart';

import '../../utils/response.dart';

class AllNotificationBloc {
  late NotificationRepo notificationRepo;
  late StreamController _dataController;

  StreamSink get dataSink => _dataController.sink;
  Stream get dataStream => _dataController.stream;

  AllNotificationBloc({required String? ntfId}) {
    _dataController = StreamController();
    notificationRepo = NotificationRepo();
    fetchdata(ntfId: ntfId);
  }

  fetchdata({required String? ntfId}) async {
    dataSink.add(Response.loading('Loading Data..!'));

    try {
      AllNotificationModel data =
          await notificationRepo.sendDataToApi(ntfId: ntfId);
      dataSink.add(Response.completed(data));
    } catch (e) {
      dataSink.add(Response.error('$e'));
    }
  }
}
