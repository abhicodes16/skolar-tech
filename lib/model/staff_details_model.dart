class StaffDetailsModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  StaffDetailsModel({this.success, this.message, this.responseCode, this.data});

  StaffDetailsModel.fromJson(Map<String, dynamic> json) {
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
  int? eMPCODE;
  String? eMPNAME;
  String? eMPDOB;
  String? empIdNo;
  String? eMPMOB;
  String? eMPMAILID;
  String? eMPGNDR;
  String? eMPDOJ;
  String? eMPDESGNAME;
  String? eMPQUALIFICATION;
  String? eMPADHNO;
  String? eMPPANNO;
  String? eMPTYPCODE;
  String? eMPPHTURL;
  String? eMPDEPTNAME;
  String? eMPADRSPRSN;
  String? eMPADRSPRMN;

  Data(
      {this.eMPCODE,
        this.eMPNAME,
        this.eMPDOB,
        this.empIdNo,
        this.eMPMOB,
        this.eMPMAILID,
        this.eMPGNDR,
        this.eMPDOJ,
        this.eMPDESGNAME,
        this.eMPQUALIFICATION,
        this.eMPADHNO,
        this.eMPPANNO,
        this.eMPTYPCODE,
        this.eMPPHTURL,
        this.eMPDEPTNAME,
        this.eMPADRSPRSN,
        this.eMPADRSPRMN});

  Data.fromJson(Map<String, dynamic> json) {
    eMPCODE = json['EMP_CODE'];
    eMPNAME = json['EMP_NAME'];
    eMPDOB = json['EMP_DOB'];
    empIdNo = json['Emp_IdNo'];
    eMPMOB = json['EMP_MOB'];
    eMPMAILID = json['EMP_MAIL_ID'];
    eMPGNDR = json['EMP_GNDR'];
    eMPDOJ = json['EMP_DOJ'];
    eMPDESGNAME = json['EMP_DESG_NAME'];
    eMPQUALIFICATION = json['EMP_QUALIFICATION'];
    eMPADHNO = json['EMP_ADH_NO'];
    eMPPANNO = json['EMP_PAN_NO'];
    eMPTYPCODE = json['EMP_TYP_CODE'];
    eMPPHTURL = json['EMP_PHT_URL'];
    eMPDEPTNAME = json['EMP_DEPT_NAME'];
    eMPADRSPRSN = json['EMP_ADRS_PRSN'];
    eMPADRSPRMN = json['EMP_ADRS_PRMN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EMP_CODE'] = this.eMPCODE;
    data['EMP_NAME'] = this.eMPNAME;
    data['EMP_DOB'] = this.eMPDOB;
    data['Emp_IdNo'] = this.empIdNo;
    data['EMP_MOB'] = this.eMPMOB;
    data['EMP_MAIL_ID'] = this.eMPMAILID;
    data['EMP_GNDR'] = this.eMPGNDR;
    data['EMP_DOJ'] = this.eMPDOJ;
    data['EMP_DESG_NAME'] = this.eMPDESGNAME;
    data['EMP_QUALIFICATION'] = this.eMPQUALIFICATION;
    data['EMP_ADH_NO'] = this.eMPADHNO;
    data['EMP_PAN_NO'] = this.eMPPANNO;
    data['EMP_TYP_CODE'] = this.eMPTYPCODE;
    data['EMP_PHT_URL'] = this.eMPPHTURL;
    data['EMP_DEPT_NAME'] = this.eMPDEPTNAME;
    data['EMP_ADRS_PRSN'] = this.eMPADRSPRSN;
    data['EMP_ADRS_PRMN'] = this.eMPADRSPRMN;
    return data;
  }
}
