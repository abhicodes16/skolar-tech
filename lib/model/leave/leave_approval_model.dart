class LeaveApprovalStatusModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  LeaveApprovalStatusModel(
      {this.success, this.message, this.responseCode, this.data});

  LeaveApprovalStatusModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    responseCode = json['responseCode'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['responseCode'] = this.responseCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? leaveId;
  int? employeeId;
  String? employeeName;
  int? leaveTypeId;
  String? leaveName;
  String? fromDate;
  String? toDate;
  String? leavePurpose;
  String? approvalStatus;
  String? approvalDate;
  String? remarks;

  Data(
      {this.leaveId,
        this.employeeId,
        this.employeeName,
        this.leaveTypeId,
        this.leaveName,
        this.fromDate,
        this.toDate,
        this.leavePurpose,
        this.approvalStatus,
        this.approvalDate,
        this.remarks});

  Data.fromJson(Map<String, dynamic> json) {
    leaveId = json['leaveId'];
    employeeId = json['employeeId'];
    employeeName = json['employeeName'];
    leaveTypeId = json['leaveTypeId'];
    leaveName = json['leaveName'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    leavePurpose = json['leavePurpose'];
    approvalStatus = json['approvalStatus'];
    approvalDate = json['approvalDate'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leaveId'] = this.leaveId;
    data['employeeId'] = this.employeeId;
    data['employeeName'] = this.employeeName;
    data['leaveTypeId'] = this.leaveTypeId;
    data['leaveName'] = this.leaveName;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    data['leavePurpose'] = this.leavePurpose;
    data['approvalStatus'] = this.approvalStatus;
    data['approvalDate'] = this.approvalDate;
    data['remarks'] = this.remarks;
    return data;
  }
}
