class DeleteQuestionModel {
  bool? success;
  String? message;
  int? responseCode;
  List<APIDATA>? data; // Change Data to APIDATA

  DeleteQuestionModel({this.success, this.message, this.responseCode, this.data});

  DeleteQuestionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    responseCode = json['responseCode'];
    if (json['data'] != null) {
      data = <APIDATA>[]; // Change Data to APIDATA
      json['data'].forEach((v) {
        data!.add(new APIDATA.fromJson(v)); // Change Data to APIDATA
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

class APIDATA { // Rename Data to APIDATA
  String? msg;
  int? sts;

  APIDATA({this.msg, this.sts});

  APIDATA.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    sts = json['sts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['sts'] = this.sts;
    return data;
  }
}
