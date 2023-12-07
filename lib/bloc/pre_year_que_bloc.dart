import 'dart:async';

import 'package:pns_skolar/model/previous_year_questions/previous_year_quation_model.dart';
import 'package:pns_skolar/repo/pre_year_que_repo.dart';
import '../../utils/response.dart';

class PreYearQueBloc {
  late PreYearQueRepo preYearQueRepo;
  late StreamController _dataController;

  StreamSink get dataSink => _dataController.sink;
  Stream get dataStream => _dataController.stream;

  PreYearQueBloc({String? subCode}) {
    _dataController = StreamController();
    preYearQueRepo = PreYearQueRepo();
    fetchdata(subCode: subCode);
  }

  fetchdata({String? subCode, bool? isLoading = true}) async {
    if (isLoading!) {
      dataSink.add(Response.loading('Loading Data..!'));
    }

    try {
      PreviousYearQuestionModel data = await preYearQueRepo.fetchData(subCode!);
      dataSink.add(Response.completed(data));
    } catch (e) {
      dataSink.add(Response.error('$e'));
    }
  }
}
