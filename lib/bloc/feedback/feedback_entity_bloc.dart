import 'dart:async';
import 'package:pns_skolar/repo/feedback/feedback_repo.dart';

import '../../model/feedback/feedback_entity_model.dart';
import '../../utils/response.dart';

class FeedbackEntityBloc {
  late FeedbackRepo feedbackRepo;
  late StreamController _dataController;

  StreamSink get dataSink => _dataController.sink;
  Stream get dataStream => _dataController.stream;

  FeedbackEntityBloc() {
    _dataController = StreamController();
    feedbackRepo = FeedbackRepo();
    fetchdata();
  }

  fetchdata() async {
    dataSink.add(Response.loading('Loading Data..!'));

    try {
      FeedbackEntityModel data = await feedbackRepo.feedbackEntity();
      dataSink.add(Response.completed(data));
    } catch (e) {
      dataSink.add(Response.error('$e'));
    }
  }
}
