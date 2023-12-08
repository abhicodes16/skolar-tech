class LogEntityDetailsModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  LogEntityDetailsModel(
      {this.success, this.message, this.responseCode, this.data});

  LogEntityDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? logDate;
  String? logTime;
  String? logDatetime;
  String? entity;
  String? activityDatetime;

  Data(
      {this.logDate,
      this.logTime,
      this.logDatetime,
      this.entity,
      this.activityDatetime});

  Data.fromJson(Map<String, dynamic> json) {
    logDate = json['LogDate'];
    logTime = json['LogTime'];
    logDatetime = json['LogDatetime'];
    entity = json['entity'];
    activityDatetime = json['activityDatetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LogDate'] = this.logDate;
    data['LogTime'] = this.logTime;
    data['LogDatetime'] = this.logDatetime;
    data['entity'] = this.entity;
    data['activityDatetime'] = this.activityDatetime;
    return data;
  }
}
