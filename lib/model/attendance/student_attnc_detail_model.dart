class StudentAttendanceModel {
  bool? success;
  String? message;
  int? responseCode;
  List<TypeData>? data;

  StudentAttendanceModel(
      {this.success, this.message, this.responseCode, this.data});

  StudentAttendanceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    responseCode = json['responseCode'];
    if (json['data'] != null) {
      data = <TypeData>[];
      json['data'].forEach((v) {
        data!.add(new TypeData.fromJson(v));
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

class TypeData {
  int? sTDCODE;
  String? sTDNAME;
  String? sTDROLNO;

  TypeData({this.sTDCODE, this.sTDNAME, this.sTDROLNO});

  TypeData.fromJson(Map<String, dynamic> json) {
    sTDCODE = json['STD_CODE'];
    sTDNAME = json['STD_NAME'];
    sTDROLNO = json['STD_ROL_NO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STD_CODE'] = this.sTDCODE;
    data['STD_NAME'] = this.sTDNAME;
    data['STD_ROL_NO'] = this.sTDROLNO;
    return data;
  }
}
