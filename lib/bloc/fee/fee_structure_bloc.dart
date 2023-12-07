import 'dart:async';

import '../../model/fee/fees_structure_model.dart';
import '../../repo/fee/fee_repo.dart';
import '../../utils/response.dart';

class FeeStructureBloc {
  late FeeRepo feeRepo;
  late StreamController _dataController;

  StreamSink get dataSink => _dataController.sink;
  Stream get dataStream => _dataController.stream;

  FeeStructureBloc() {
    _dataController = StreamController();
    feeRepo = FeeRepo();
    fetchdata();
  }

  fetchdata() async {
    dataSink.add(Response.loading('Loading Data..!'));

    try {
      FeesStructureModel data = await feeRepo.fetchFeesStructure();
      dataSink.add(Response.completed(data));
    } catch (e) {
      dataSink.add(Response.error('$e'));
    }
  }
}
