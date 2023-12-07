class FeeModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  FeeModel({this.success, this.message, this.responseCode, this.data});

  FeeModel.fromJson(Map<String, dynamic> json) {
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
  String? collectionDate;
  String? amount;
  String? recipt;
  String? dueHead;

  Data({this.collectionDate, this.amount, this.recipt, this.dueHead});

  Data.fromJson(Map<String, dynamic> json) {
    collectionDate = json['collectionDate'];
    amount = json['amount'];
    recipt = json['recipt'];
    dueHead = json['dueHead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['collectionDate'] = this.collectionDate;
    data['amount'] = this.amount;
    data['recipt'] = this.recipt;
    data['dueHead'] = this.dueHead;
    return data;
  }
}
