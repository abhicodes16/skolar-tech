class EmpColEntryModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  EmpColEntryModel({this.success, this.message, this.responseCode, this.data});

  EmpColEntryModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? employeeId;
  String? employeeName;
  String? fromDate;
  String? toDate;
  String? descriptions;
  String? transactionDate;
  String? approvalStatus;
  String? approvalDate;
  String? approvalRemarks;

  Data(
      {this.id,
        this.employeeId,
        this.employeeName,
        this.fromDate,
        this.toDate,
        this.descriptions,
        this.transactionDate,
        this.approvalStatus,
        this.approvalDate,
        this.approvalRemarks});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employeeId'];
    employeeName = json['employeeName'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    descriptions = json['descriptions'];
    transactionDate = json['transactionDate'];
    approvalStatus = json['approvalStatus'];
    approvalDate = json['approvalDate'];
    approvalRemarks = json['approvalRemarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employeeId'] = this.employeeId;
    data['employeeName'] = this.employeeName;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    data['descriptions'] = this.descriptions;
    data['transactionDate'] = this.transactionDate;
    data['approvalStatus'] = this.approvalStatus;
    data['approvalDate'] = this.approvalDate;
    data['approvalRemarks'] = this.approvalRemarks;
    return data;
  }
}
