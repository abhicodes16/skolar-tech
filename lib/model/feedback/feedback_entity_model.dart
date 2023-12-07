class FeedbackEntityModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  FeedbackEntityModel(
      {this.success, this.message, this.responseCode, this.data});

  FeedbackEntityModel.fromJson(Map<String, dynamic> json) {
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
  int? eNTITID;
  String? eNTITNAME;
  String? iSACTIVE;

  Data({this.eNTITID, this.eNTITNAME, this.iSACTIVE});

  Data.fromJson(Map<String, dynamic> json) {
    eNTITID = json['ENTIT_ID'];
    eNTITNAME = json['ENTIT_NAME'];
    iSACTIVE = json['IS_ACTIVE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ENTIT_ID'] = this.eNTITID;
    data['ENTIT_NAME'] = this.eNTITNAME;
    data['IS_ACTIVE'] = this.iSACTIVE;
    return data;
  }
}
