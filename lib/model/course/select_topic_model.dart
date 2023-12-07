class SelectTopicModel {
  bool? success;
  String? message;
  int? responseCode;
  List<SelectTopicDataModel>? data;

  SelectTopicModel({this.success, this.message, this.responseCode, this.data});

  SelectTopicModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    responseCode = json['responseCode'];
    if (json['data'] != null) {
      data = <SelectTopicDataModel>[];
      json['data'].forEach((v) {
        data!.add(new SelectTopicDataModel.fromJson(v));
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

class SelectTopicDataModel {
  int? tOPICID;
  int? sUBID;
  String? tOPICNAME;

  SelectTopicDataModel({this.tOPICID, this.sUBID, this.tOPICNAME});

  SelectTopicDataModel.fromJson(Map<String, dynamic> json) {
    tOPICID = json['TOPIC_ID'];
    sUBID = json['SUB_ID'];
    tOPICNAME = json['TOPIC_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TOPIC_ID'] = this.tOPICID;
    data['SUB_ID'] = this.sUBID;
    data['TOPIC_NAME'] = this.tOPICNAME;
    return data;
  }
}
