import 'dart:async';

import 'package:pns_skolar/repo/admin_repo.dart';

import '../../model/log_entity/log_entity_details_model.dart';
import '../../utils/response.dart';

class LogEntityDetailsBloc {
  late AdminRepo adminRepo;
  late StreamController _dataController;

  StreamSink get dataSink => _dataController.sink;
  Stream get dataStream => _dataController.stream;

  LogEntityDetailsBloc(String entityId) {
    _dataController = StreamController();
    adminRepo = AdminRepo();
    fetchdata(entityId);
  }

  fetchdata(String entityId) async {
    dataSink.add(Response.loading('Loading Data..!'));

    try {
      LogEntityDetailsModel data = await adminRepo.fetchLogDetailsData(entityId);
      dataSink.add(Response.completed(data));
    } catch (e) {
      dataSink.add(Response.error('$e'));
    }
  }
}
