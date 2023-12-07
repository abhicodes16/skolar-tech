class StdFamlyDtlsModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  StdFamlyDtlsModel({this.success, this.message, this.responseCode, this.data});

  StdFamlyDtlsModel.fromJson(Map<String, dynamic> json) {
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
  String? sTDFTHNAME;
  String? sTDFTHMOB;
  String? sTDFTHADHR;
  String? sTDFTHOCPN;
  String? sTDMTHNAME;
  String? sTDMTHMOB;
  String? sTDMTHADHR;
  String? sTDMTHOCPN;

  Data(
      {this.sTDCODE,
      this.sTDFTHNAME,
      this.sTDFTHMOB,
      this.sTDFTHADHR,
      this.sTDFTHOCPN,
      this.sTDMTHNAME,
      this.sTDMTHMOB,
      this.sTDMTHADHR,
      this.sTDMTHOCPN});

  Data.fromJson(Map<String, dynamic> json) {
    sTDCODE = json['STD_CODE'];
    sTDFTHNAME = json['STD_FTH_NAME'];
    sTDFTHMOB = json['STD_FTH_MOB'];
    sTDFTHADHR = json['STD_FTH_ADHR'];
    sTDFTHOCPN = json['STD_FTH_OCPN'];
    sTDMTHNAME = json['STD_MTH_NAME'];
    sTDMTHMOB = json['STD_MTH_MOB'];
    sTDMTHADHR = json['STD_MTH_ADHR'];
    sTDMTHOCPN = json['STD_MTH_OCPN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STD_CODE'] = this.sTDCODE;
    data['STD_FTH_NAME'] = this.sTDFTHNAME;
    data['STD_FTH_MOB'] = this.sTDFTHMOB;
    data['STD_FTH_ADHR'] = this.sTDFTHADHR;
    data['STD_FTH_OCPN'] = this.sTDFTHOCPN;
    data['STD_MTH_NAME'] = this.sTDMTHNAME;
    data['STD_MTH_MOB'] = this.sTDMTHMOB;
    data['STD_MTH_ADHR'] = this.sTDMTHADHR;
    data['STD_MTH_OCPN'] = this.sTDMTHOCPN;
    return data;
  }
}
