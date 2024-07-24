import 'package:get/get.dart';

import '../model/leave/leave_approval_model.dart';
import '../repo/leave/leave_repo.dart';
import '../utils/response.dart';
import '../widget/loading_dialogue.dart';

class LeaveApprovalCnt extends GetxController {
  final _api = LeaveRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final leaveApprovalData = LeaveApprovalStatusModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setError(String value) => error.value = value;

  void setListData(LeaveApprovalStatusModel value) {
    leaveApprovalData.value = value;
  }

  void leaveListApi() {
    _api.getApprovalData().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setListData(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    leaveListApi();
  }
}
