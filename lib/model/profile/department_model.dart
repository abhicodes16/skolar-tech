class Departments_model {
  bool? success;
  String? message;
  int? responseCode;
  List<DepartMentData>? data;

  Departments_model({this.success, this.message, this.responseCode, this.data});

  Departments_model.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    responseCode = json['responseCode'];
    if (json['data'] != null) {
      data = <DepartMentData>[];
      json['data'].forEach((v) {
        data!.add(new DepartMentData.fromJson(v));
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

class DepartMentData {
  int? deptId;
  String? deptName;

  DepartMentData({this.deptId, this.deptName});

  DepartMentData.fromJson(Map<String, dynamic> json) {
    deptId = json['deptId'];
    deptName = json['deptName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deptId'] = this.deptId;
    data['deptName'] = this.deptName;
    return data;
  }
}
