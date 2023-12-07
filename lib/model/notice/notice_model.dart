class NoticeModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  NoticeModel({this.success, this.message, this.responseCode, this.data});

  NoticeModel.fromJson(Map<String, dynamic> json) {
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
  String? noticeCode;
  String? title;
  String? typ;
  String? noticeTo;
  String? noticeDesc;
  String? cmnName;
  String? notice;
  String? noticeDate;
  String? isViewed;
  String? UploadFile;

  Data({
    this.noticeCode,
    this.title,
    this.typ,
    this.noticeTo,
    this.noticeDesc,
    this.cmnName,
    this.notice,
    this.isViewed,
    this.noticeDate,
    this.UploadFile,
  });

  Data.fromJson(Map<String, dynamic> json) {
    noticeCode = json['noticeCode'];
    title = json['title'];
    typ = json['typ'];
    noticeTo = json['noticeTo'];
    noticeDesc = json['noticeDesc'];
    cmnName = json['cmn_name'];
    notice = json['notice'];
    noticeDate = json['noticeDate'];
    isViewed = json['isViewed'];
    UploadFile = json['UploadFile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['noticeCode'] = this.noticeCode;
    data['title'] = this.title;
    data['typ'] = this.typ;
    data['noticeTo'] = this.noticeTo;
    data['noticeDesc'] = this.noticeDesc;
    data['cmn_name'] = this.cmnName;
    data['notice'] = this.notice;
    data['noticeDate'] = this.noticeDate;
    data['isViewed'] = this.isViewed;
    data['UploadFile'] = this.UploadFile;
    return data;
  }
}
