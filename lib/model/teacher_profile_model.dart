class TeacherProfileModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  TeacherProfileModel(
      {this.success, this.message, this.responseCode, this.data});

  TeacherProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? eMPDESGCODE;
  String? eMPQUAL;
  String? eMPADHNO;
  String? eMPPANNO;
  String? eMPFTHNM;
  String? eMPTYPCODE;
  String? eMPPHTURL;
  String? eMPDEPTCODE;
  String? eMPADRSPRSN;
  String? eMPADRSPRMN;
  String? cREATEDDATE;

  Data(
      {this.eMPCODE,
      this.eMPNAME,
      this.eMPDOB,
      this.empIdNo,
      this.eMPMOB,
      this.eMPMAILID,
      this.eMPGNDR,
      this.eMPDOJ,
      this.eMPDESGCODE,
      this.eMPQUAL,
      this.eMPADHNO,
      this.eMPPANNO,
      this.eMPFTHNM,
      this.eMPTYPCODE,
      this.eMPPHTURL,
      this.eMPDEPTCODE,
      this.eMPADRSPRSN,
      this.eMPADRSPRMN,
      this.cREATEDDATE});

  Data.fromJson(Map<String, dynamic> json) {
    eMPCODE = json['EMP_CODE'];
    eMPNAME = json['EMP_NAME'];
    eMPDOB = json['EMP_DOB'];
    empIdNo = json['Emp_IdNo'];
    eMPMOB = json['EMP_MOB'];
    eMPMAILID = json['EMP_MAIL_ID'];
    eMPGNDR = json['EMP_GNDR'];
    eMPDOJ = json['EMP_DOJ'];
    eMPDESGCODE = json['EMP_DESG_CODE'];
    eMPQUAL = json['EMP_QUAL'];
    eMPADHNO = json['EMP_ADH_NO'];
    eMPPANNO = json['EMP_PAN_NO'];
    eMPFTHNM = json['EMP_FTH_NM'];
    eMPTYPCODE = json['EMP_TYP_CODE'];
    eMPPHTURL = json['EMP_PHT_URL'];
    eMPDEPTCODE = json['EMP_DEPT_CODE'];
    eMPADRSPRSN = json['EMP_ADRS_PRSN'];
    eMPADRSPRMN = json['EMP_ADRS_PRMN'];
    cREATEDDATE = json['CREATED_DATE'];
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
    data['EMP_DESG_CODE'] = this.eMPDESGCODE;
    data['EMP_QUAL'] = this.eMPQUAL;
    data['EMP_ADH_NO'] = this.eMPADHNO;
    data['EMP_PAN_NO'] = this.eMPPANNO;
    data['EMP_FTH_NM'] = this.eMPFTHNM;
    data['EMP_TYP_CODE'] = this.eMPTYPCODE;
    data['EMP_PHT_URL'] = this.eMPPHTURL;
    data['EMP_DEPT_CODE'] = this.eMPDEPTCODE;
    data['EMP_ADRS_PRSN'] = this.eMPADRSPRSN;
    data['EMP_ADRS_PRMN'] = this.eMPADRSPRMN;
    data['CREATED_DATE'] = this.cREATEDDATE;
    return data;
  }
}
