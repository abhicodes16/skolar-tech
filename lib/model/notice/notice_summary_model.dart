class NoticeSummaryModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  NoticeSummaryModel(
      {this.success, this.message, this.responseCode, this.data});

  NoticeSummaryModel.fromJson(Map<String, dynamic> json) {
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
  String? totalNotice;
  String? readNotice;
  String? unread;

  Data({this.totalNotice, this.readNotice, this.unread});

  Data.fromJson(Map<String, dynamic> json) {
    totalNotice = json['totalNotice'];
    readNotice = json['readNotice'];
    unread = json['unread'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalNotice'] = this.totalNotice;
    data['readNotice'] = this.readNotice;
    data['unread'] = this.unread;
    return data;
  }
}
