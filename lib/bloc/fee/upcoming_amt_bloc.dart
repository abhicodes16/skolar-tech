import 'dart:async';

import '../../model/fee/dua_amt_model.dart';
import '../../repo/fee/fee_repo.dart';
import '../../utils/response.dart';

class UpcomingAmtBloc {
  late FeeRepo feeRepo;
  late StreamController _dataController;

  StreamSink get dataSink => _dataController.sink;
  Stream get dataStream => _dataController.stream;

  UpcomingAmtBloc() {
    _dataController = StreamController();
    feeRepo = FeeRepo();
    fetchdata();
  }

  fetchdata() async {
    dataSink.add(Response.loading('Loading Data..!'));

    try {
      DuaAmtModel data = await feeRepo.fetchUpcomingAmtData();
      dataSink.add(Response.completed(data));
    } catch (e) {
      dataSink.add(Response.error('$e'));
    }
  }
}
