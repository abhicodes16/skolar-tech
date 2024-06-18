class Designations_model {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  Designations_model(
      {this.success, this.message, this.responseCode, this.data});

  Designations_model.fromJson(Map<String, dynamic> json) {
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
  int? desgId;
  String? desgName;

  Data({this.desgId, this.desgName});

  Data.fromJson(Map<String, dynamic> json) {
    desgId = json['desgId'];
    desgName = json['desgName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desgId'] = this.desgId;
    data['desgName'] = this.desgName;
    return data;
  }
}
