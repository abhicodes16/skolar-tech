class getTeacherQueries {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  getTeacherQueries({this.success, this.message, this.responseCode, this.data});

  getTeacherQueries.fromJson(Map<String, dynamic> json) {
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
  int? studentCode;
  String? studentName;
  int? branchId;
  String? branchName;
  String? typeName;
  int? fromId;
  Null? fromName;
  String? details;
  String? createdDate;

  Data(
      {this.id,
        this.studentCode,
        this.studentName,
        this.branchId,
        this.branchName,
        this.typeName,
        this.fromId,
        this.fromName,
        this.details,
        this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentCode = json['studentCode'];
    studentName = json['studentName'];
    branchId = json['branchId'];
    branchName = json['branchName'];
    typeName = json['typeName'];
    fromId = json['fromId'];
    fromName = json['fromName'];
    details = json['details'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['studentCode'] = this.studentCode;
    data['studentName'] = this.studentName;
    data['branchId'] = this.branchId;
    data['branchName'] = this.branchName;
    data['typeName'] = this.typeName;
    data['fromId'] = this.fromId;
    data['fromName'] = this.fromName;
    data['details'] = this.details;
    data['createdDate'] = this.createdDate;
    return data;
  }
}
