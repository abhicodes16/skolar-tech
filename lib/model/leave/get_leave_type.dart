class GetLeaveType {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  GetLeaveType({this.success, this.message, this.responseCode, this.data});

  GetLeaveType.fromJson(Map<String, dynamic> json) {
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
  int? leaveId;
  String? leaveName;

  Data({this.leaveId, this.leaveName});

  Data.fromJson(Map<String, dynamic> json) {
    leaveId = json['leaveId'];
    leaveName = json['leaveName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leaveId'] = this.leaveId;
    data['leaveName'] = this.leaveName;
    return data;
  }
}
