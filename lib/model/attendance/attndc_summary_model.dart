class AttendanceSummaryModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  AttendanceSummaryModel(
      {this.success, this.message, this.responseCode, this.data});

  AttendanceSummaryModel.fromJson(Map<String, dynamic> json) {
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
  String? yearName;
  String? presentTotal;
  String? absentTotal;
  String? holiday;
  String? weeklyOff;
  String? dayTotal;

  Data(
      {this.monthName,
      this.yearName,
      this.presentTotal,
      this.absentTotal,
      this.holiday,
      this.weeklyOff,
      this.dayTotal});

  Data.fromJson(Map<String, dynamic> json) {
    monthName = json['monthName_'];
    yearName = json['yearName'];
    presentTotal = json['presentTotal'];
    absentTotal = json['absentTotal'];
    holiday = json['holiday'];
    weeklyOff = json['weeklyOff'];
    dayTotal = json['dayTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['monthName_'] = this.monthName;
    data['yearName'] = this.yearName;
    data['presentTotal'] = this.presentTotal;
    data['absentTotal'] = this.absentTotal;
    data['holiday'] = this.holiday;
    data['weeklyOff'] = this.weeklyOff;
    data['dayTotal'] = this.dayTotal;
    return data;
  }
}
