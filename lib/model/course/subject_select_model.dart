class SubjectSelectModel {
  bool? success;
  String? message;
  int? responseCode;
  List<SubjectSelectDataModel>? data;

  SubjectSelectModel(
      {this.success, this.message, this.responseCode, this.data});

  SubjectSelectModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    responseCode = json['responseCode'];
    if (json['data'] != null) {
      data = <SubjectSelectDataModel>[];
      json['data'].forEach((v) {
        data!.add(new SubjectSelectDataModel.fromJson(v));
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

class SubjectSelectDataModel {
  int? sBJCODE;
  int? cLSCODE;
  String? sBJNAME;
  int? sEMENAME;

  SubjectSelectDataModel({this.sBJCODE, this.cLSCODE, this.sBJNAME, this.sEMENAME});

  SubjectSelectDataModel.fromJson(Map<String, dynamic> json) {
    sBJCODE = json['SBJ_CODE'];
    cLSCODE = json['CLS_CODE'];
    sBJNAME = json['SBJ_NAME'];
    sEMENAME = json['SEME_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SBJ_CODE'] = this.sBJCODE;
    data['CLS_CODE'] = this.cLSCODE;
    data['SBJ_NAME'] = this.sBJNAME;
    data['SEME_NAME'] = this.sEMENAME;
    return data;
  }
}
