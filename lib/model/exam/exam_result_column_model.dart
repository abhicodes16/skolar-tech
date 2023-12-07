class ExamResultColumnModel {
  bool? success;
  String? message;
  int? responseCode;
  List<ResultColumnData>? data;

  ExamResultColumnModel(
      {this.success, this.message, this.responseCode, this.data});

  ExamResultColumnModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    responseCode = json['responseCode'];
    if (json['data'] != null) {
      data = <ResultColumnData>[];
      json['data'].forEach((v) {
        data!.add(new ResultColumnData.fromJson(v));
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

class ResultColumnData {
  String? col1;
  String? col2;
  String? col2IsVisible;
  String? col3;
  String? col3IsVisible;
  String? col4;
  String? col4IsVisible;
  String? col5;
  String? col5IsVisible;
  String? col6;

  ResultColumnData({
    this.col1,
    this.col2,
    this.col2IsVisible,
    this.col3,
    this.col3IsVisible,
    this.col4,
    this.col4IsVisible,
    this.col5,
    this.col5IsVisible,
    this.col6,
  });

  ResultColumnData.fromJson(Map<String, dynamic> json) {
    col1 = json['col1'];
    col2 = json['col2'];
    col2IsVisible = json['col2IsVisible'];
    col3 = json['col3'];
    col3IsVisible = json['col3IsVisible'];
    col4 = json['col4'];
    col4IsVisible = json['col4IsVisible'];
    col5 = json['col5'];
    col5IsVisible = json['col5IsVisible'];
    col6 = json['col6'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['col1'] = this.col1;
    data['col2'] = this.col2;
    data['col2IsVisible'] = this.col2IsVisible;
    data['col3'] = this.col3;
    data['col3IsVisible'] = this.col3IsVisible;
    data['col4'] = this.col4;
    data['col4IsVisible'] = this.col4IsVisible;
    data['col5'] = this.col5;
    data['col5IsVisible'] = this.col5IsVisible;
    data['col6'] = this.col6;
    return data;
  }
}
