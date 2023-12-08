import 'dart:async';

import 'package:pns_skolar/model/admin_home_model.dart';
import 'package:pns_skolar/repo/admin_repo.dart';

import '../../utils/response.dart';

class AdminHomeBloc {
  late AdminRepo adminRepo;
  late StreamController _dataController;

  StreamSink get dataSink => _dataController.sink;
  Stream get dataStream => _dataController.stream;

  AdminHomeBloc() {
    _dataController = StreamController();
    adminRepo = AdminRepo();
    fetchdata();
  }

  fetchdata() async {
    dataSink.add(Response.loading('Loading Data..!'));

    try {
      AdminHomeModel data = await adminRepo.fetchAdminHome();
      dataSink.add(Response.completed(data));
    } catch (e) {
      dataSink.add(Response.error('$e'));
    }
  }
}
