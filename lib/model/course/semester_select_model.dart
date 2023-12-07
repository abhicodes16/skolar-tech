class SemesterSelectModel {
  bool? success;
  String? message;
  int? responseCode;
  List<SemesterSelectDataModel>? data;

  SemesterSelectModel(
      {this.success, this.message, this.responseCode, this.data});

  SemesterSelectModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    responseCode = json['responseCode'];
    if (json['data'] != null) {
      data = <SemesterSelectDataModel>[];
      json['data'].forEach((v) {
        data!.add(new SemesterSelectDataModel.fromJson(v));
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

class SemesterSelectDataModel {
  int? sEMECODE;
  String? semesterName;

  SemesterSelectDataModel({this.sEMECODE, this.semesterName});

  SemesterSelectDataModel.fromJson(Map<String, dynamic> json) {
    sEMECODE = json['SEME_CODE'];
    semesterName = json['Semester_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SEME_CODE'] = this.sEMECODE;
    data['Semester_Name'] = this.semesterName;
    return data;
  }
}
