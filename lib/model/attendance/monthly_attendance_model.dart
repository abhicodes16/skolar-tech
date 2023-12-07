class MonthlyAttendanceModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  MonthlyAttendanceModel(
      {this.success, this.message, this.responseCode, this.data});

  MonthlyAttendanceModel.fromJson(Map<String, dynamic> json) {
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
  String? monthName;
  String? dayName;
  String? inTime;
  String? outTime;
  String? dayStatus;

  Data(
      {this.monthName,
      this.dayName,
      this.inTime,
      this.outTime,
      this.dayStatus});

  Data.fromJson(Map<String, dynamic> json) {
    monthName = json['monthName_'];
    dayName = json['dayName_'];
    inTime = json['inTime'];
    outTime = json['outTime'];
    dayStatus = json['dayStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['monthName_'] = this.monthName;
    data['dayName_'] = this.dayName;
    data['inTime'] = this.inTime;
    data['outTime'] = this.outTime;
    data['dayStatus'] = this.dayStatus;
    return data;
  }
}
