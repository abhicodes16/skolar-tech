import 'dart:async';

import 'package:flutter/widgets.dart';
import '../../model/exam/exam_result_column_model.dart';
import '../../model/exam/exam_result_column_val_model.dart';
import '../../repo/exam/exam_repo.dart';
import '../../utils/response.dart';

class ExamResultBloc {
  late ExamRepo examRepo;
  late StreamController _dataController;

  StreamSink get dataSink => _dataController.sink;
  Stream get dataStream => _dataController.stream;

  ExamResultBloc({
    ValueChanged<ResultColumnData>? onResultColumnData,
    String? examCode,
    ValueChanged<bool>? noData,
  }) {
    _dataController = StreamController();
    examRepo = ExamRepo();
    fetchdata(
      onResultColumnData: onResultColumnData,
      examCode: examCode,
      noData: noData,
    );
  }

  fetchdata({
    ValueChanged<ResultColumnData>? onResultColumnData,
    String? examCode,
    ValueChanged<bool>? noData,
  }) async {
    dataSink.add(Response.loading('Loading Data..!'));

    try {
      ExamResultColumnModel data =
          await examRepo.fetchExamResultColumn(examCode!);
      //dataSink.add(Response.completed(data));
      if (data.data != null) {
        if (data.data!.isNotEmpty) {
          onResultColumnData!(data.data!.first);

          ExamResultColumnValModel columnValueData =
              await examRepo.fetchExamResultColumnValue(examCode);

          if (columnValueData.data != null) {
            if (columnValueData.data!.isNotEmpty) {
              dataSink.add(Response.completed(columnValueData));
            }
          }
        } else {
          ExamResultColumnValModel columnValueData =
              ExamResultColumnValModel(data: []);
          dataSink.add(Response.completed(columnValueData));
        }
      }
    } catch (e) {
      dataSink.add(Response.error('$e'));
    }
  }
}
