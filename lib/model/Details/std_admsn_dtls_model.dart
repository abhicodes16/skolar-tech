class StdAdmsnDtlsModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  StdAdmsnDtlsModel({this.success, this.message, this.responseCode, this.data});

  StdAdmsnDtlsModel.fromJson(Map<String, dynamic> json) {
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
  int? sTDCODE;
  String? sTDBRANCH;
  String? sTDSemester;
  String? sTDROLNO;
  String? sTDCouncilRegNo;
  String? sTDADMDT;
  String? sTDAdmissionCategory;

  Data(
      {this.sTDCODE,
      this.sTDBRANCH,
      this.sTDSemester,
      this.sTDROLNO,
      this.sTDCouncilRegNo,
      this.sTDADMDT,
      this.sTDAdmissionCategory});

  Data.fromJson(Map<String, dynamic> json) {
    sTDCODE = json['STD_CODE'];
    sTDBRANCH = json['STD_BRANCH'];
    sTDSemester = json['STD_Semester'];
    sTDROLNO = json['STD_ROL_NO'];
    sTDCouncilRegNo = json['STD_CouncilRegNo'];
    sTDADMDT = json['STD_ADM_DT'];
    sTDAdmissionCategory = json['STD_AdmissionCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STD_CODE'] = this.sTDCODE;
    data['STD_BRANCH'] = this.sTDBRANCH;
    data['STD_Semester'] = this.sTDSemester;
    data['STD_ROL_NO'] = this.sTDROLNO;
    data['STD_CouncilRegNo'] = this.sTDCouncilRegNo;
    data['STD_ADM_DT'] = this.sTDADMDT;
    data['STD_AdmissionCategory'] = this.sTDAdmissionCategory;
    return data;
  }
}
