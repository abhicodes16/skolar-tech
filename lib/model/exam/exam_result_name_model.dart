class ExamResultNameModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  ExamResultNameModel(
      {this.success, this.message, this.responseCode, this.data});

  ExamResultNameModel.fromJson(Map<String, dynamic> json) {
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
  int? examCode;
  String? examTitle;
  String? examDate;
  String? totalMark;
  String? marksSecured;
  String? percentageSecured;
  String? isResultPublished;

  Data(
      {this.examCode,
      this.examTitle,
      this.examDate,
      this.totalMark,
      this.marksSecured,
      this.percentageSecured,
      this.isResultPublished});

  Data.fromJson(Map<String, dynamic> json) {
    examCode = json['examCode'];
    examTitle = json['examTitle'];
    examDate = json['examDate'];
    totalMark = json['totalMark'];
    marksSecured = json['marksSecured'];
    percentageSecured = json['percentageSecured'];
    isResultPublished = json['isResultPublished'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['examCode'] = this.examCode;
    data['examTitle'] = this.examTitle;
    data['examDate'] = this.examDate;
    data['totalMark'] = this.totalMark;
    data['marksSecured'] = this.marksSecured;
    data['percentageSecured'] = this.percentageSecured;
    data['isResultPublished'] = this.isResultPublished;
    return data;
  }
}
