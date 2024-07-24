import 'package:get/get.dart';

import '../model/leave/emp_col_entry.dart';
import '../repo/leave/leave_repo.dart';
import '../utils/response.dart';

class EmpColCnt extends GetxController {
  final _api = LeaveRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final colEntryData = EmpColEntryModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setError(String value) => error.value = value;

  void setListData(EmpColEntryModel value) {
    colEntryData.value = value;
  }

  void getEntryData() {
    _api.getColEntry().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setListData(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    getEntryData();
  }
}
