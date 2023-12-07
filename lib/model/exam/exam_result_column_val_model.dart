class ExamResultColumnValModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  ExamResultColumnValModel(
      {this.success, this.message, this.responseCode, this.data});

  ExamResultColumnValModel.fromJson(Map<String, dynamic> json) {
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
  int? sBJCODE;
  String? col1;
  String? col2;
  String? col3;
  String? col4;
  String? col5;
  String? col6;

  Data(
      {this.sBJCODE,
      this.col1,
      this.col2,
      this.col3,
      this.col4,
      this.col5,
      this.col6});

  Data.fromJson(Map<String, dynamic> json) {
    sBJCODE = json['SBJ_CODE'];
    col1 = json['col1'];
    col2 = json['col2'];
    col3 = json['col3'];
    col4 = json['col4'];
    col5 = json['col5'];
    col6 = json['col6'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SBJ_CODE'] = this.sBJCODE;
    data['col1'] = this.col1;
    data['col2'] = this.col2;
    data['col3'] = this.col3;
    data['col4'] = this.col4;
    data['col5'] = this.col5;
    data['col6'] = this.col6;
    return data;
  }
}
