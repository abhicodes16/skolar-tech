class EmpModel {
  bool? success;
  String? message;
  int? responseCode;
  List<EmpData>? data;

  EmpModel({this.success, this.message, this.responseCode, this.data});

  EmpModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    responseCode = json['responseCode'];
    if (json['data'] != null) {
      data = <EmpData>[];
      json['data'].forEach((v) {
        data!.add(new EmpData.fromJson(v));
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

class EmpData {
  int? empId;
  String? empName;

  EmpData({this.empId, this.empName});

  EmpData.fromJson(Map<String, dynamic> json) {
    empId = json['empId'];
    empName = json['empName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['empId'] = this.empId;
    data['empName'] = this.empName;
    return data;
  }
}
