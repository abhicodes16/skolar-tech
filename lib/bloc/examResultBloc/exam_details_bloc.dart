import 'dart:async';
import 'package:flutter/material.dart';

import '../../model/exam/exam_details_model.dart';
import '../../repo/exam/exam_repo.dart';
import '../../utils/response.dart';

class ExamDetailsBloc {
  late ExamRepo examRepo;
  late StreamController _dataController;

  StreamSink get dataSink => _dataController.sink;
  Stream get dataStream => _dataController.stream;

  ExamDetailsBloc(String testId, {ValueChanged<ExamDetailsModel>? onData}) {
    _dataController = StreamController();
    examRepo = ExamRepo();
    fetchdata(testId, onData: onData);
  }

  fetchdata(String testId, {ValueChanged<ExamDetailsModel>? onData}) async {
    dataSink.add(Response.loading('Loading Data..!'));

    try {
      ExamDetailsModel data = await examRepo.fetchResultDetailsById(testId);
      dataSink.add(Response.completed(data));
      if (onData != null) {
        onData(data);
      }
      
    } catch (e) {
      dataSink.add(Response.error('$e'));
    }
  }
}
