class SchoolInfoModel {
  bool? success;
  String? message;
  int? responseCode;
  List<SchoolData>? data;

  SchoolInfoModel({this.success, this.message, this.responseCode, this.data});

  SchoolInfoModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    responseCode = json['responseCode'];
    if (json['data'] != null) {
      data = <SchoolData>[];
      json['data'].forEach((v) {
        data!.add(new SchoolData.fromJson(v));
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

class SchoolData {
  String? schoolId;
  String? schoolName;
  String? address;
  String? logoUrl;
  String? bannerUrl;
  String? mail;
  String? phoneNo;
  String? website;
  String? connectionStringName;

  SchoolData(
      {this.schoolId,
      this.schoolName,
      this.address,
      this.logoUrl,
      this.bannerUrl,
      this.mail,
      this.phoneNo,
      this.website,
      this.connectionStringName});

  SchoolData.fromJson(Map<String, dynamic> json) {
    schoolId = json['schoolId'];
    schoolName = json['schoolName'];
    address = json['address'];
    logoUrl = json['logoUrl'];
    bannerUrl = json['bannerUrl'];
    mail = json['mail'];
    phoneNo = json['phoneNo'];
    website = json['website'];
    connectionStringName = json['connectionStringName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['schoolId'] = this.schoolId;
    data['schoolName'] = this.schoolName;
    data['address'] = this.address;
    data['logoUrl'] = this.logoUrl;
    data['bannerUrl'] = this.bannerUrl;
    data['mail'] = this.mail;
    data['phoneNo'] = this.phoneNo;
    data['website'] = this.website;
    data['connectionStringName'] = this.connectionStringName;
    return data;
  }
}
