class FeedbackHistoryModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  FeedbackHistoryModel(
      {this.success, this.message, this.responseCode, this.data});

  FeedbackHistoryModel.fromJson(Map<String, dynamic> json) {
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
  int? fDBKID;
  int? eNTITID;
  String? eNTITNAME;
  String? sATSLVL;

  Data({this.fDBKID, this.eNTITID, this.eNTITNAME, this.sATSLVL});

  Data.fromJson(Map<String, dynamic> json) {
    fDBKID = json['FDBK_ID'];
    eNTITID = json['ENTIT_ID'];
    eNTITNAME = json['ENTIT_NAME'];
    sATSLVL = json['SATS_LVL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FDBK_ID'] = this.fDBKID;
    data['ENTIT_ID'] = this.eNTITID;
    data['ENTIT_NAME'] = this.eNTITNAME;
    data['SATS_LVL'] = this.sATSLVL;
    return data;
  }
}
