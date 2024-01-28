class getExamDeclaration {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  getExamDeclaration(
      {this.success, this.message, this.responseCode, this.data});

  getExamDeclaration.fromJson(Map<String, dynamic> json) {
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
  int? declarationId;
  String? examDate;
  int? examtypeId;
  String? examName;
  String? examTitle;
  String? isScheduled;
  String? isMarkPublished;
  String? isBackpapersEntered;

  Data(
      {this.declarationId,
        this.examDate,
        this.examtypeId,
        this.examName,
        this.examTitle,
        this.isScheduled,
        this.isMarkPublished,
        this.isBackpapersEntered});

  Data.fromJson(Map<String, dynamic> json) {
    declarationId = json['declarationId'];
    examDate = json['examDate'];
    examtypeId = json['examtypeId'];
    examName = json['examName'];
    examTitle = json['examTitle'];
    isScheduled = json['isScheduled'];
    isMarkPublished = json['isMarkPublished'];
    isBackpapersEntered = json['isBackpapersEntered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['declarationId'] = this.declarationId;
    data['examDate'] = this.examDate;
    data['examtypeId'] = this.examtypeId;
    data['examName'] = this.examName;
    data['examTitle'] = this.examTitle;
    data['isScheduled'] = this.isScheduled;
    data['isMarkPublished'] = this.isMarkPublished;
    data['isBackpapersEntered'] = this.isBackpapersEntered;
    return data;
  }
}
