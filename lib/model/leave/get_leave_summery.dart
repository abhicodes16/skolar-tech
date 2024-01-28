class GetLeaveSummery {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  GetLeaveSummery({this.success, this.message, this.responseCode, this.data});

  GetLeaveSummery.fromJson(Map<String, dynamic> json) {
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
  String? leavename;
  String? totalBalance;
  String? usedTotal;
  String? availableBalance;

  Data(
      {this.leavename,
        this.totalBalance,
        this.usedTotal,
        this.availableBalance});

  Data.fromJson(Map<String, dynamic> json) {
    leavename = json['leavename'];
    totalBalance = json['totalBalance'];
    usedTotal = json['usedTotal'];
    availableBalance = json['availableBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leavename'] = this.leavename;
    data['totalBalance'] = this.totalBalance;
    data['usedTotal'] = this.usedTotal;
    data['availableBalance'] = this.availableBalance;
    return data;
  }
}
