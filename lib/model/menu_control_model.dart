class MenuControlModel {
  bool? success;
  String? message;
  int? responseCode;
  List<MenuControlData>? data;

  MenuControlModel({this.success, this.message, this.responseCode, this.data});

  MenuControlModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    responseCode = json['responseCode'];
    if (json['data'] != null) {
      data = <MenuControlData>[];
      json['data'].forEach((v) {
        data!.add(new MenuControlData.fromJson(v));
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

class MenuControlData {
  int? mENUID;
  String? dASHBOARD;
  String? nOTIFICATIONS;
  String? pROFILE;
  String? aTTENDANCE;
  String? hOMEWORK;
  String? nEWS;
  String? nOTICE;
  String? hOLIDAY;
  String? fEES;
  String? lEAVE;
  String? rESULTPUBLISH;
  String? pREVIOUSYEARQUESTIONS;
  String? fEEDBACK;
  String? cOURSECOVERED;
  String? sENDQuery;

  MenuControlData(
      {this.mENUID,
      this.dASHBOARD,
      this.nOTIFICATIONS,
      this.pROFILE,
      this.aTTENDANCE,
      this.hOMEWORK,
      this.nEWS,
      this.nOTICE,
      this.hOLIDAY,
      this.fEES,
      this.lEAVE,
      this.cOURSECOVERED,
      this.pREVIOUSYEARQUESTIONS,
      this.fEEDBACK,
      this.rESULTPUBLISH,
      this.sENDQuery
      });

  MenuControlData.fromJson(Map<String, dynamic> json) {
    mENUID = json['MENU_ID'];
    dASHBOARD = json['DASHBOARD'];
    nOTIFICATIONS = json['NOTIFICATIONS'];
    pROFILE = json['PROFILE'];
    aTTENDANCE = json['ATTENDANCE'];
    hOMEWORK = json['HOMEWORK'];
    nEWS = json['NEWS'];
    nOTICE = json['NOTICE'];
    hOLIDAY = json['HOLIDAY'];
    fEES = json['FEES'];
    lEAVE = json['LEAVE'];
    cOURSECOVERED = json['COURSE_COVERED'];
    pREVIOUSYEARQUESTIONS = json['PREVIOUS_YEAR_QUESTIONS'];
    rESULTPUBLISH = json['RESULT_PUBLISH'];
    fEEDBACK = json['FEEDBACK'];
    sENDQuery = json['QUERY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MENU_ID'] = this.mENUID;
    data['DASHBOARD'] = this.dASHBOARD;
    data['NOTIFICATIONS'] = this.nOTIFICATIONS;
    data['PROFILE'] = this.pROFILE;
    data['ATTENDANCE'] = this.aTTENDANCE;
    data['HOMEWORK'] = this.hOMEWORK;
    data['NEWS'] = this.nEWS;
    data['NOTICE'] = this.nOTICE;
    data['HOLIDAY'] = this.hOLIDAY;
    data['FEES'] = this.fEES;
    data['LEAVE'] = this.lEAVE;
    data['COURSE_COVERED'] = this.cOURSECOVERED;
    data['PREVIOUS_YEAR_QUESTIONS'] = this.pREVIOUSYEARQUESTIONS;
    data['RESULT_PUBLISH'] = this.rESULTPUBLISH;
    data['FEEDBACK'] = this.fEEDBACK;
    data['QUERY'] = this.sENDQuery;
    return data;
  }
}
