class StaffDetailsModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  StaffDetailsModel({this.success, this.message, this.responseCode, this.data});

  StaffDetailsModel.fromJson(Map<String, dynamic> json) {
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
  int? empId;
  String? empName;
  String? contactNo;
  String? emailId;
  String? empPhoto;
  String? departmentName;
  String? subjectName;

  Data({
    this.empId,
    this.empName,
    this.contactNo,
    this.emailId,
    this.empPhoto,
    this.departmentName,
    this.subjectName,
  });

  Data.fromJson(Map<String, dynamic> json) {
    empId = json['empId'];
    empName = json['empName'];
    contactNo = json['contactNo'];
    emailId = json['emailId'];
    empPhoto = json['empPhoto'];
    departmentName = json['departmentName'];
    subjectName = json['subjectName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['empId'] = this.empId;
    data['empName'] = this.empName;
    data['contactNo'] = this.contactNo;
    data['emailId'] = this.emailId;
    data['empPhoto'] = this.empPhoto;
    data['departmentName'] = this.departmentName;
    data['subjectName'] = this.subjectName;
    return data;
  }
}
