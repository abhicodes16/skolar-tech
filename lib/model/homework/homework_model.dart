class HomeworkModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  HomeworkModel({this.success, this.message, this.responseCode, this.data});

  HomeworkModel.fromJson(Map<String, dynamic> json) {
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
  int? AsignCode;
  String? workDate;
  String? workSubject;
  String? attachment;
  String? completeBy;
  String? isCompleted;

  Data({this.AsignCode, this.workDate, this.workSubject, this.attachment, this.completeBy, this.isCompleted});

  Data.fromJson(Map<String, dynamic> json) {
    AsignCode = json['AsignCode'];
    workDate = json['workDate'];
    workSubject = json['workSubject'];
    attachment = json['attachment'];
    completeBy = json['completeBy'];
    isCompleted = json['isCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AsignCode'] = this.AsignCode;
    data['workDate'] = this.workDate;
    data['workSubject'] = this.workSubject;
    data['attachment'] = this.attachment;
    data['completeBy'] = this.completeBy;
    data['isCompleted'] = this.isCompleted;
    return data;
  }
}
