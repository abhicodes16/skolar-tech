class StudentDetailsModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  StudentDetailsModel(
      {this.success, this.message, this.responseCode, this.data});

  StudentDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? sTDNAME;
  String? sTDGNDR;
  String? sTDDOB;
  String? sTDIDNO;
  String? sTDMOB;
  String? sTDCTGCODE;
  String? sTDADRSPRSN;
  String? sTDADRSPRMN;
  String? sTDWAPNO;
  String? sTDType;
  String? pROCTCODE;
  String? sTDPHTURL;

  Data({
    this.sTDCODE,
    this.sTDNAME,
    this.sTDGNDR,
    this.sTDDOB,
    this.sTDIDNO,
    this.sTDMOB,
    this.sTDCTGCODE,
    this.sTDADRSPRSN,
    this.sTDADRSPRMN,
    this.sTDWAPNO,
    this.sTDType,
    this.pROCTCODE,
    this.sTDPHTURL,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sTDCODE = json['STD_CODE'];
    sTDNAME = json['STD_NAME'];
    sTDGNDR = json['STD_GNDR'];
    sTDDOB = json['STD_DOB'];
    sTDIDNO = json['STD_IDNO'];
    sTDMOB = json['STD_MOB'];
    sTDCTGCODE = json['STD_CTG_CODE'];
    sTDADRSPRSN = json['STD_ADRS_PRSN'];
    sTDADRSPRMN = json['STD_ADRS_PRMN'];
    sTDWAPNO = json['STD_WAPNO'];
    sTDType = json['STD_Type'];
    pROCTCODE = json['PROCT_CODE'];
    sTDPHTURL = json['STD_PHT_URL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STD_CODE'] = this.sTDCODE;
    data['STD_NAME'] = this.sTDNAME;
    data['STD_GNDR'] = this.sTDGNDR;
    data['STD_DOB'] = this.sTDDOB;
    data['STD_IDNO'] = this.sTDIDNO;
    data['STD_MOB'] = this.sTDMOB;
    data['STD_CTG_CODE'] = this.sTDCTGCODE;
    data['STD_ADRS_PRSN'] = this.sTDADRSPRSN;
    data['STD_ADRS_PRMN'] = this.sTDADRSPRMN;
    data['STD_WAPNO'] = this.sTDWAPNO;
    data['STD_Type'] = this.sTDType;
    data['PROCT_CODE'] = this.pROCTCODE;
    data['STD_PHT_URL'] = this.sTDPHTURL;
    return data;
  }
}
