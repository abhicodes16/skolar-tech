import 'dart:async';

import 'package:flutter/material.dart';

import '../model/common_model.dart';
import '../repo/change_pass_repo.dart';
import '../widget/error_dialouge.dart';
import '../widget/loading_dialogue.dart';
import '../widget/success_dialouge.dart';

class ChangePassBloc {
  late ChangePassRepo changePassRepo;
  late StreamController _dataController;

  StreamSink get dataSink => _dataController.sink;
  Stream get dataStream => _dataController.stream;

  ChangePassBloc({
    required BuildContext context,
    required String? oldPass,
    required String? newPass,
  }) {
    _dataController = StreamController();
    changePassRepo = ChangePassRepo();
    fetchdata(context: context, newPass: newPass, oldPass: oldPass);
  }

  fetchdata({
    required BuildContext context,
    String? oldPass,
    String? newPass,
  }) async {
    // dataSink.add(Response.loading('Loading Data..!'));
    LoadingDialog.showLoadingDialog(context);

    try {
      CommonModel? data =
          await changePassRepo.sendReq(newPass: newPass, oldPassword: oldPass);
      if (data.success!) {
        Navigator.pop(context);
        Navigator.pop(context);
        SuccessDialouge.showErrorDialogue(context, data.message!);
      } else {
        Navigator.pop(context);
        ErrorDialouge.showErrorDialogue(context, data.message!);
      }
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(context, e.toString());
    }
  }
}
