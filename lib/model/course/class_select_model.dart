class ClassSelectModel {
  bool? success;
  String? message;
  int? responseCode;
  List<ClassSelectDataModel>? data;

  ClassSelectModel({this.success, this.message, this.responseCode, this.data});

  ClassSelectModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    responseCode = json['responseCode'];
    if (json['data'] != null) {
      data = <ClassSelectDataModel>[];
      json['data'].forEach((v) {
        data!.add(new ClassSelectDataModel.fromJson(v));
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

class ClassSelectDataModel {
  int? cLSCODE;
  String? cLSNAME;

  ClassSelectDataModel({this.cLSCODE, this.cLSNAME});

  ClassSelectDataModel.fromJson(Map<String, dynamic> json) {
    cLSCODE = json['CLS_CODE'];
    cLSNAME = json['CLS_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CLS_CODE'] = this.cLSCODE;
    data['CLS_NAME'] = this.cLSNAME;
    return data;
  }
}
