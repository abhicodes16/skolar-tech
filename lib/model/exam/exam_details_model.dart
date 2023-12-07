class ExamDetailsModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  ExamDetailsModel({this.success, this.message, this.responseCode, this.data});

  ExamDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? stdRollNo;
  String? stdName;
  String? totalMarks;
  String? totalSecured;
  String? totalPrc;
  String? examName;
  String? subjName;
  String? subjTotal;
  String? subjSecured;

  Data(
      {this.stdRollNo,
      this.stdName,
      this.totalMarks,
      this.totalSecured,
      this.totalPrc,
      this.examName,
      this.subjName,
      this.subjTotal,
      this.subjSecured});

  Data.fromJson(Map<String, dynamic> json) {
    stdRollNo = json['stdRollNo'];
    stdName = json['stdName'];
    totalMarks = json['totalMarks'];
    totalSecured = json['totalSecured'];
    totalPrc = json['totalPrc'];
    examName = json['examName'];
    subjName = json['subjName'];
    subjTotal = json['subjTotal'];
    subjSecured = json['subjSecured'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stdRollNo'] = this.stdRollNo;
    data['stdName'] = this.stdName;
    data['totalMarks'] = this.totalMarks;
    data['totalSecured'] = this.totalSecured;
    data['totalPrc'] = this.totalPrc;
    data['examName'] = this.examName;
    data['subjName'] = this.subjName;
    data['subjTotal'] = this.subjTotal;
    data['subjSecured'] = this.subjSecured;
    return data;
  }
}
