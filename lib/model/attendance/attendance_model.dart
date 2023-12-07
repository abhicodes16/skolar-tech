class AttendanceModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  AttendanceModel({this.success, this.message, this.responseCode, this.data});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
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
  String? cLASS;
  String? sECTION;
  String? aDATE;
  String? sTUCODE;
  Null? eMPCODE;
  String? sBJCODE;
  String? pERIODCODE;

  Data(
      {this.cLASS,
      this.sECTION,
      this.aDATE,
      this.sTUCODE,
      this.eMPCODE,
      this.sBJCODE,
      this.pERIODCODE});

  Data.fromJson(Map<String, dynamic> json) {
    cLASS = json['CLASS'];
    sECTION = json['SECTION'];
    aDATE = json['ADATE'];
    sTUCODE = json['STUCODE'];
    eMPCODE = json['EMP_CODE'];
    sBJCODE = json['SBJ_CODE'];
    pERIODCODE = json['PERIOD_CODE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CLASS'] = this.cLASS;
    data['SECTION'] = this.sECTION;
    data['ADATE'] = this.aDATE;
    data['STUCODE'] = this.sTUCODE;
    data['EMP_CODE'] = this.eMPCODE;
    data['SBJ_CODE'] = this.sBJCODE;
    data['PERIOD_CODE'] = this.pERIODCODE;
    return data;
  }
}
