class academicCalendarModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  academicCalendarModel(
      {this.success, this.message, this.responseCode, this.data});

  academicCalendarModel.fromJson(Map<String, dynamic> json) {
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
  String? calDate;
  String? entity;
  String? remarks;

  Data({this.calDate, this.entity, this.remarks});

  Data.fromJson(Map<String, dynamic> json) {
    calDate = json['calDate'];
    entity = json['entity'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['calDate'] = this.calDate;
    data['entity'] = this.entity;
    data['remarks'] = this.remarks;
    return data;
  }
}
