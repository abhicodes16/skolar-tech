class GetTeacherQueries {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  GetTeacherQueries({this.success, this.message, this.responseCode, this.data});

  GetTeacherQueries.fromJson(Map<String, dynamic> json) {
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
  int? queryID;
  int? teacherID;
  String? teacherName;
  int? studentID;
  String? studentName;
  String? queryTitle;
  String? queryDetails;
  String? queryAttachment;
  String? createdDatetime;

  Data(
      {this.queryID,
        this.teacherID,
        this.teacherName,
        this.studentID,
        this.studentName,
        this.queryTitle,
        this.queryDetails,
        this.queryAttachment,
        this.createdDatetime});

  Data.fromJson(Map<String, dynamic> json) {
    queryID = json['queryID'];
    teacherID = json['teacherID'];
    teacherName = json['teacherName'];
    studentID = json['studentID'];
    studentName = json['studentName'];
    queryTitle = json['queryTitle'];
    queryDetails = json['queryDetails'];
    queryAttachment = json['queryAttachment'];
    createdDatetime = json['createdDatetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['queryID'] = this.queryID;
    data['teacherID'] = this.teacherID;
    data['teacherName'] = this.teacherName;
    data['studentID'] = this.studentID;
    data['studentName'] = this.studentName;
    data['queryTitle'] = this.queryTitle;
    data['queryDetails'] = this.queryDetails;
    data['queryAttachment'] = this.queryAttachment;
    data['createdDatetime'] = this.createdDatetime;
    return data;
  }
}
