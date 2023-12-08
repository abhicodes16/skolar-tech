class AdminHomeModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  AdminHomeModel({this.success, this.message, this.responseCode, this.data});

  AdminHomeModel.fromJson(Map<String, dynamic> json) {
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
  String? textDtls;
  String? value;
  String? colour;
  String? icon;

  Data({this.textDtls, this.value, this.colour, this.icon});

  Data.fromJson(Map<String, dynamic> json) {
    textDtls = json['textDtls'];
    value = json['value'];
    colour = json['colour'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['textDtls'] = this.textDtls;
    data['value'] = this.value;
    data['colour'] = this.colour;
    data['icon'] = this.icon;
    return data;
  }
}
