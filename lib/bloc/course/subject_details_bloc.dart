import 'dart:async';

import '../../model/course/subject_details_model.dart';
import '../../repo/Course/subject_info_repo.dart';
import '../../utils/response.dart';

class SubjectDetailsBloc {
  late SubjectRepo subjectRepo;
  late StreamController _dataController;

  StreamSink get dataSink => _dataController.sink;
  Stream get dataStream => _dataController.stream;

  SubjectDetailsBloc() {
    _dataController = StreamController();
    subjectRepo = SubjectRepo();
    fetchdata();
  }

  fetchdata() async {
    dataSink.add(Response.loading('Loading Data..!'));

    try {
      SubjectDetailsModel data = await subjectRepo.fetchData();
      dataSink.add(Response.completed(data));
    } catch (e) {
      dataSink.add(Response.error('$e'));
    }
  }
}
