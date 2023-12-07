class ExamModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  ExamModel({this.success, this.message, this.responseCode, this.data});

  ExamModel.fromJson(Map<String, dynamic> json) {
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
  int? testId;
  String? testName;
  String? conductedDate;
  String? totalMarks;
  String? totalSecured;
  String? prcSecured;

  Data(
      {this.testId,
      this.testName,
      this.conductedDate,
      this.totalMarks,
      this.totalSecured,
      this.prcSecured});

  Data.fromJson(Map<String, dynamic> json) {
    testId = json['testId'];
    testName = json['testName'];
    conductedDate = json['conductedDate'];
    totalMarks = json['totalMarks'];
    totalSecured = json['totalSecured'];
    prcSecured = json['prcSecured'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['testId'] = this.testId;
    data['testName'] = this.testName;
    data['conductedDate'] = this.conductedDate;
    data['totalMarks'] = this.totalMarks;
    data['totalSecured'] = this.totalSecured;
    data['prcSecured'] = this.prcSecured;
    return data;
  }
}
