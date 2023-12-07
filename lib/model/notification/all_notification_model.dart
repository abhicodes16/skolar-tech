class AllNotificationModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  AllNotificationModel(
      {this.success, this.message, this.responseCode, this.data});

  AllNotificationModel.fromJson(Map<String, dynamic> json) {
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
  String? ntfType;
  String? ntfTitle;
  String? ntfbody;
  String? ntfDatetime;

  Data({this.ntfType, this.ntfTitle, this.ntfbody, this.ntfDatetime});

  Data.fromJson(Map<String, dynamic> json) {
    ntfType = json['ntfType'];
    ntfTitle = json['ntfTitle'];
    ntfbody = json['ntfbody'];
    ntfDatetime = json['ntfDatetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ntfType'] = this.ntfType;
    data['ntfTitle'] = this.ntfTitle;
    data['ntfbody'] = this.ntfbody;
    data['ntfDatetime'] = this.ntfDatetime;
    return data;
  }
}
