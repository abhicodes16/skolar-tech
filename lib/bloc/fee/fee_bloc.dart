import 'dart:async';

import '../../model/fee/fee_model.dart';
import '../../repo/fee/fee_repo.dart';
import '../../utils/response.dart';

class FeeBloc {
  late FeeRepo feeRepo;
  late StreamController _dataController;

  StreamSink get dataSink => _dataController.sink;
  Stream get dataStream => _dataController.stream;

  FeeBloc() {
    _dataController = StreamController();
    feeRepo = FeeRepo();
    fetchdata();
  }

  fetchdata() async {
    dataSink.add(Response.loading('Loading Data..!'));

    try {
      FeeModel data = await feeRepo.fetchData();
      dataSink.add(Response.completed(data));
    } catch (e) {
      dataSink.add(Response.error('$e'));
    }
  }
}
