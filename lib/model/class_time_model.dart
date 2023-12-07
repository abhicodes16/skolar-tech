class ClassStartTimeModel {
  bool? success;
  String? message;
  int? responseCode;
  List<StartTimeData>? data;

  ClassStartTimeModel(
      {this.success, this.message, this.responseCode, this.data});

  ClassStartTimeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    responseCode = json['responseCode'];
    if (json['data'] != null) {
      data = <StartTimeData>[];
      json['data'].forEach((v) {
        data!.add(new StartTimeData.fromJson(v));
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

class StartTimeData {
  String? classStartTime;

  StartTimeData({this.classStartTime});

  StartTimeData.fromJson(Map<String, dynamic> json) {
    classStartTime = json['ClassStartTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClassStartTime'] = this.classStartTime;
    return data;
  }
}
