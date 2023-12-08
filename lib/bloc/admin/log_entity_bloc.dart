import 'dart:async';

import 'package:pns_skolar/model/log_entity/log_entity_model.dart';
import 'package:pns_skolar/repo/admin_repo.dart';

import '../../utils/response.dart';

class LogEntityBloc {
  late AdminRepo adminRepo;
  late StreamController _dataController;

  StreamSink get dataSink => _dataController.sink;
  Stream get dataStream => _dataController.stream;

  LogEntityBloc() {
    _dataController = StreamController();
    adminRepo = AdminRepo();
    fetchdata();
  }

  fetchdata() async {
    dataSink.add(Response.loading('Loading Data..!'));

    try {
      LogEntityModel data = await adminRepo.fetchLogData();
      dataSink.add(Response.completed(data));
    } catch (e) {
      dataSink.add(Response.error('$e'));
    }
  }
}
