class viewExamSchedule {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  viewExamSchedule({this.success, this.message, this.responseCode, this.data});

  viewExamSchedule.fromJson(Map<String, dynamic> json) {
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
  int? scheduleId;
  int? declarationId;
  String? dateOfExam;
  int? subjectId;
  String? subjectName;
  int? sittingId;
  String? sittingtypeName;
  String? timeofExam;

  Data(
      {this.scheduleId,
        this.declarationId,
        this.dateOfExam,
        this.subjectId,
        this.subjectName,
        this.sittingId,
        this.sittingtypeName,
        this.timeofExam});

  Data.fromJson(Map<String, dynamic> json) {
    scheduleId = json['scheduleId'];
    declarationId = json['declarationId'];
    dateOfExam = json['dateOfExam'];
    subjectId = json['subjectId'];
    subjectName = json['subjectName'];
    sittingId = json['sittingId'];
    sittingtypeName = json['sittingtypeName'];
    timeofExam = json['timeofExam'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scheduleId'] = this.scheduleId;
    data['declarationId'] = this.declarationId;
    data['dateOfExam'] = this.dateOfExam;
    data['subjectId'] = this.subjectId;
    data['subjectName'] = this.subjectName;
    data['sittingId'] = this.sittingId;
    data['sittingtypeName'] = this.sittingtypeName;
    data['timeofExam'] = this.timeofExam;
    return data;
  }
}
