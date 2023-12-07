class NewsModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  NewsModel({this.success, this.message, this.responseCode, this.data});

  NewsModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? subTitle;
  String? fImageUrl;
  String? bImageUrl;
  String? details;
  String? tCNRFLUR;
  String? tCNPSTDT;

  Data(
      {this.title,
      this.subTitle,
      this.fImageUrl,
      this.bImageUrl,
      this.details,
      this.tCNRFLUR,
      this.tCNPSTDT});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subTitle = json['subTitle'];
    fImageUrl = json['fImageUrl'];
    bImageUrl = json['bImageUrl'];
    details = json['details'];
    tCNRFLUR = json['TCN_RFL_UR'];
    tCNPSTDT = json['TCN_PST_DT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subTitle'] = this.subTitle;
    data['fImageUrl'] = this.fImageUrl;
    data['bImageUrl'] = this.bImageUrl;
    data['details'] = this.details;
    data['TCN_RFL_UR'] = this.tCNRFLUR;
    data['TCN_PST_DT'] = this.tCNPSTDT;
    return data;
  }
}
