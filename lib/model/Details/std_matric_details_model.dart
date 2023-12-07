class StdMatricDtlsModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  StdMatricDtlsModel(
      {this.success, this.message, this.responseCode, this.data});

  StdMatricDtlsModel.fromJson(Map<String, dynamic> json) {
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
  String? institutionName;
  String? boardName;
  String? marks;
  String? passingYear;
  String? passingCategory;
  String? securedMarks;

  Data(
      {this.sTDCODE,
      this.institutionName,
      this.boardName,
      this.marks,
      this.passingYear,
      this.passingCategory,
      this.securedMarks});

  Data.fromJson(Map<String, dynamic> json) {
    sTDCODE = json['STD_CODE'];
    institutionName = json['InstitutionName'];
    boardName = json['BoardName'];
    marks = json['Marks'];
    passingYear = json['PassingYear'];
    passingCategory = json['PassingCategory'];
    securedMarks = json['SecuredMarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STD_CODE'] = this.sTDCODE;
    data['InstitutionName'] = this.institutionName;
    data['BoardName'] = this.boardName;
    data['Marks'] = this.marks;
    data['PassingYear'] = this.passingYear;
    data['PassingCategory'] = this.passingCategory;
    data['SecuredMarks'] = this.securedMarks;
    return data;
  }
}
