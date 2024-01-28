class GetLeaveStatus {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  GetLeaveStatus({this.success, this.message, this.responseCode, this.data});

  GetLeaveStatus.fromJson(Map<String, dynamic> json) {
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
  int? leaveTypeId;
  String? leaveTypeName;
  String? fromDate;
  String? toDate;
  String? leavePurpose;
  String? approvalStatus;
  String? approvalDate;

  Data(
      {this.leaveId,
        this.employeeId,
        this.leaveTypeId,
        this.leaveTypeName,
        this.fromDate,
        this.toDate,
        this.leavePurpose,
        this.approvalStatus,
        this.approvalDate});

  Data.fromJson(Map<String, dynamic> json) {
    leaveId = json['leaveId'];
    employeeId = json['employeeId'];
    leaveTypeId = json['leaveTypeId'];
    leaveTypeName = json['leaveTypeName'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    leavePurpose = json['leavePurpose'];
    approvalStatus = json['approvalStatus'];
    approvalDate = json['approvalDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leaveId'] = this.leaveId;
    data['employeeId'] = this.employeeId;
    data['leaveTypeId'] = this.leaveTypeId;
    data['leaveTypeName'] = this.leaveTypeName;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    data['leavePurpose'] = this.leavePurpose;
    data['approvalStatus'] = this.approvalStatus;
    data['approvalDate'] = this.approvalDate;
    return data;
  }
}
