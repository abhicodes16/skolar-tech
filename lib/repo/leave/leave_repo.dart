
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/leave/emp_col_entry.dart';
import '../../model/leave/leave_approval_model.dart';
import '../../utils/api_constant.dart';
import '../../utils/network/network_api_services.dart';

class LeaveRepository {
  final _apiService = NetworkApiServices();
  Future<LeaveApprovalStatusModel> getApprovalData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';
    dynamic response = await _apiService.getApi("${ApiConstant.GET_LEAVE_APPROVAL_STATUS}?schoolCode=$schoolCode");
    print(LeaveApprovalStatusModel.fromJson(response));
    return LeaveApprovalStatusModel.fromJson(response);
  }

  Future<EmpColEntryModel> getColEntry() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolCode = pref.getString('schoolCode') ?? '';
    dynamic response = await _apiService.getApi("${ApiConstant.GET_EMP_COL_ENTRY}?schoolCode=$schoolCode");
    print(EmpColEntryModel.fromJson(response));
    return EmpColEntryModel.fromJson(response);
  }
}
