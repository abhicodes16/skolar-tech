class DuaAmtModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  DuaAmtModel({this.success, this.message, this.responseCode, this.data});

  DuaAmtModel.fromJson(Map<String, dynamic> json) {
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
  String? dueDate;
  String? dueHead;
  String? amount;

  Data({this.dueDate, this.dueHead, this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    dueDate = json['dueDate'];
    dueHead = json['dueHead'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dueDate'] = this.dueDate;
    data['dueHead'] = this.dueHead;
    data['amount'] = this.amount;
    return data;
  }
}
