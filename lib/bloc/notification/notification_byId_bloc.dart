import 'dart:async';
import '../../model/notification/notification_by_id_model.dart';
import '../../repo/notification/notification_repo.dart';
import '../../utils/response.dart';

class NotificationByIdBloc {
  late NotificationRepo notificationRepo;
  late StreamController _dataController;

  StreamSink get dataSink => _dataController.sink;
  Stream get dataStream => _dataController.stream;

  NotificationByIdBloc({required String? id}) {
    _dataController = StreamController();
    notificationRepo = NotificationRepo();
    fetchdata(id: id);
  }

  fetchdata({required String? id}) async {
    dataSink.add(Response.loading('Loading Data..!'));

    try {
      NotificationByIdModel data = await notificationRepo.sendData(id: id);
      dataSink.add(Response.completed(data));
    } catch (e) {
      dataSink.add(Response.error('$e'));
    }
  }
}
