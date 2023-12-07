class HolidayModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  HolidayModel({this.success, this.message, this.responseCode, this.data});

  HolidayModel.fromJson(Map<String, dynamic> json) {
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
  String? hLDYCODE;
  String? holidayDate;
  String? dayName;
  String? holidayName;

  Data({this.hLDYCODE, this.holidayDate, this.dayName, this.holidayName});

  Data.fromJson(Map<String, dynamic> json) {
    hLDYCODE = json['HLDY_CODE'];
    holidayDate = json['holidayDate'];
    dayName = json['dayName_'];
    holidayName = json['holidayName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HLDY_CODE'] = this.hLDYCODE;
    data['holidayDate'] = this.holidayDate;
    data['dayName_'] = this.dayName;
    data['holidayName'] = this.holidayName;
    return data;
  }
}
