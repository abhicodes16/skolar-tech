class LogEntityModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  LogEntityModel({this.success, this.message, this.responseCode, this.data});

  LogEntityModel.fromJson(Map<String, dynamic> json) {
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
  int? entityId;
  String? entityName;

  Data({this.entityId, this.entityName});

  Data.fromJson(Map<String, dynamic> json) {
    entityId = json['entityId'];
    entityName = json['entityName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entityId'] = this.entityId;
    data['entityName'] = this.entityName;
    return data;
  }
}
