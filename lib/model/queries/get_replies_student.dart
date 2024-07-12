class GetReplyStudent {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  GetReplyStudent({this.success, this.message, this.responseCode, this.data});

  GetReplyStudent.fromJson(Map<String, dynamic> json) {
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
  int? replyId;
  int? replyBy;
  String? teacherName;
  String? replyById;
  String? queryTitle;
  String? queryDetails;
  String? replyDetails;
  String? replyAttachment;
  String? createdDatetime;

  Data(
      {this.replyId,
        this.replyBy,
        this.teacherName,
        this.replyById,
        this.queryTitle,
        this.queryDetails,
        this.replyDetails,
        this.replyAttachment,
        this.createdDatetime});

  Data.fromJson(Map<String, dynamic> json) {
    replyId = json['replyId'];
    replyBy = json['replyBy'];
    teacherName = json['teacherName'];
    replyById = json['replyById'];
    queryTitle = json['queryTitle'];
    queryDetails = json['queryDetails'];
    replyDetails = json['replyDetails'];
    replyAttachment = json['replyAttachment'];
    createdDatetime = json['createdDatetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['replyId'] = this.replyId;
    data['replyBy'] = this.replyBy;
    data['teacherName'] = this.teacherName;
    data['replyById'] = this.replyById;
    data['queryTitle'] = this.queryTitle;
    data['queryDetails'] = this.queryDetails;
    data['replyDetails'] = this.replyDetails;
    data['replyAttachment'] = this.replyAttachment;
    data['createdDatetime'] = this.createdDatetime;
    return data;
  }
}
