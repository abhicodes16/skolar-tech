class AttsHdrModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  AttsHdrModel({this.success, this.message, this.responseCode, this.data});

  AttsHdrModel.fromJson(Map<String, dynamic> json) {
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
  int? sts;
  String? msg;
  int? hDRID;

  Data({this.sts, this.msg, this.hDRID});

  Data.fromJson(Map<String, dynamic> json) {
    sts = json['sts'];
    msg = json['msg'];
    hDRID = json['HDR_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sts'] = this.sts;
    data['msg'] = this.msg;
    data['HDR_ID'] = this.hDRID;
    return data;
  }
}
