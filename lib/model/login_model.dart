class LoginModel {
  String? sts;
  String? msg;
  String? message;
  String? token;
  String? userId;
  String? userType;
  String? userName;
  String? gender;
  String? userDOB;
  String? userMobileNo;
  String? userLoginId;
  String? sTDNAME;
  String? sTDGNDR;
  String? sTDDOB;
  String? sTDIDNO;
  String? sTDMOB;

  LoginModel(
      {this.sts,
      this.msg,
      this.message,
      this.token,
      this.userId,
      this.userName,
      this.userType,
      this.gender,
      this.userDOB,
      this.userMobileNo,
      this.userLoginId,
      this.sTDNAME,
      this.sTDGNDR,
      this.sTDDOB,
      this.sTDIDNO,
      this.sTDMOB});

  LoginModel.fromJson(Map<String, dynamic> json) {
    sts = json['sts'];
    msg = json['msg'];
    message = json['Message'];
    token = json['token'];
    userId = json['UserId'];
    userType = json['userType'];
    userName = json['userName'];
    gender = json['gender'];
    userMobileNo = json['userMobileNo'];
    userLoginId = json['userLoginId'];
    userDOB = json['userDOB'];
    sTDNAME = json['STD_NAME'];
    sTDGNDR = json['STD_GNDR'];
    sTDDOB = json['STD_DOB'];
    sTDIDNO = json['STD_IDNO'];
    sTDMOB = json['STD_MOB'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sts'] = this.sts;
    data['msg'] = this.msg;
    data['Message'] = this.message;
    data['token'] = this.token;
    data['UserId'] = this.userId;
    data['userName'] = this.userName;
    data['userType'] = this.userType;
    data['gender'] = this.gender;
    data['userDOB'] = this.userDOB;
    data['userMobileNo'] = this.userMobileNo;
    data['userLoginId'] = this.userLoginId;
    data['STD_NAME'] = this.sTDNAME;
    data['STD_GNDR'] = this.sTDGNDR;
    data['STD_DOB'] = this.sTDDOB;
    data['STD_IDNO'] = this.sTDIDNO;
    data['STD_MOB'] = this.sTDMOB;
    return data;
  }
}
