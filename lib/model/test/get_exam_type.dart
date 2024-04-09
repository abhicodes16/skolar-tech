class getExamTypeModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  getExamTypeModel({this.success, this.message, this.responseCode, this.data});

  getExamTypeModel.fromJson(Map<String, dynamic> json) {
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
  int? examTypeId;
  String? examTypeName;

  Data({this.examTypeId, this.examTypeName});

  Data.fromJson(Map<String, dynamic> json) {
    examTypeId = json['examTypeId'];
    examTypeName = json['examTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['examTypeId'] = this.examTypeId;
    data['examTypeName'] = this.examTypeName;
    return data;
  }
}
