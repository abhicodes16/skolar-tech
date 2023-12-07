class HomeWorkSummaryModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  HomeWorkSummaryModel(
      {this.success, this.message, this.responseCode, this.data});

  HomeWorkSummaryModel.fromJson(Map<String, dynamic> json) {
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
  String? totalHW;
  String? completedHW;
  String? incompleteHW;

  Data({this.totalHW, this.completedHW, this.incompleteHW});

  Data.fromJson(Map<String, dynamic> json) {
    totalHW = json['totalHW'];
    completedHW = json['completedHW'];
    incompleteHW = json['incompleteHW'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalHW'] = this.totalHW;
    data['completedHW'] = this.completedHW;
    data['incompleteHW'] = this.incompleteHW;
    return data;
  }
}
