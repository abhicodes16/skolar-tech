class InsertMarksModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  InsertMarksModel({this.success, this.message, this.responseCode, this.data});

  InsertMarksModel.fromJson(Map<String, dynamic> json) {
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
  String? msg;
  int? sts;

  Data({this.msg, this.sts});

  Data.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    sts = json['sts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['sts'] = this.sts;
    return data;
  }
}
