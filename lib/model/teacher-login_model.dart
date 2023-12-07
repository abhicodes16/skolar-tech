class LoginTeacherModel {
  String? sts;
  String? msg;
  String? message;
  String? token;
  String? userId;
  String? eMPNAME;
  String? eMPMOB;
  String? eMPMAILID;
  String? eMPGNDR;
  String? eMPDOB;
  String? empIdNo;

  LoginTeacherModel(
      {this.sts,
      this.msg,
      this.message,
      this.token,
      this.userId,
      this.eMPNAME,
      this.eMPMOB,
      this.eMPMAILID,
      this.eMPGNDR,
      this.eMPDOB,
      this.empIdNo});

  LoginTeacherModel.fromJson(Map<String, dynamic> json) {
    sts = json['sts'];
    message = json['Message'];
    msg = json['msg'];
    token = json['token'];
    userId = json['UserId'];
    eMPNAME = json['EMP_NAME'];
    eMPMOB = json['EMP_MOB'];
    eMPMAILID = json['EMP_MAIL_ID'];
    eMPGNDR = json['EMP_GNDR'];
    eMPDOB = json['EMP_DOB'];
    empIdNo = json['Emp_IdNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sts'] = this.sts;
    data['msg'] = this.msg;
    data['Message'] = this.message;
    data['token'] = this.token;
    data['UserId'] = this.userId;
    data['EMP_NAME'] = this.eMPNAME;
    data['EMP_MOB'] = this.eMPMOB;
    data['EMP_MAIL_ID'] = this.eMPMAILID;
    data['EMP_GNDR'] = this.eMPGNDR;
    data['EMP_DOB'] = this.eMPDOB;
    data['Emp_IdNo'] = this.empIdNo;
    return data;
  }
}
