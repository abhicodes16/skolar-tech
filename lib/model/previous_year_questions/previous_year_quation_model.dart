class PreviousYearQuestionModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  PreviousYearQuestionModel(
      {this.success, this.message, this.responseCode, this.data});

  PreviousYearQuestionModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? questionsDoc;

  Data({this.title, this.questionsDoc});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    questionsDoc = json['QuestionsDoc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['QuestionsDoc'] = this.questionsDoc;
    return data;
  }
}
