class QuestionHistoryModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  QuestionHistoryModel(
      {this.success, this.message, this.responseCode, this.data});

  QuestionHistoryModel.fromJson(Map<String, dynamic> json) {
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
  int? branchId;
  String? branchName;
  int? semesterId;
  String? semesterName;
  int? subjectId;
  String? subjectName;
  String? title;
  String? questionsDoc;

  Data(
      {this.id,
        this.branchId,
        this.branchName,
        this.semesterId,
        this.semesterName,
        this.subjectId,
        this.subjectName,
        this.title,
        this.questionsDoc});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branchId'];
    branchName = json['branchName'];
    semesterId = json['semesterId'];
    semesterName = json['semesterName'];
    subjectId = json['subjectId'];
    subjectName = json['subjectName'];
    title = json['title'];
    questionsDoc = json['QuestionsDoc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branchId'] = this.branchId;
    data['branchName'] = this.branchName;
    data['semesterId'] = this.semesterId;
    data['semesterName'] = this.semesterName;
    data['subjectId'] = this.subjectId;
    data['subjectName'] = this.subjectName;
    data['title'] = this.title;
    data['QuestionsDoc'] = this.questionsDoc;
    return data;
  }
}
