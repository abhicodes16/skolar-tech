class getBookModel {
  bool? success;
  String? message;
  int? responseCode;
  List<Data>? data;

  getBookModel({this.success, this.message, this.responseCode, this.data});

  getBookModel.fromJson(Map<String, dynamic> json) {
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
  int? bookId;
  String? bookName;

  Data({this.bookId, this.bookName});

  Data.fromJson(Map<String, dynamic> json) {
    bookId = json['bookId'];
    bookName = json['bookName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookId'] = this.bookId;
    data['bookName'] = this.bookName;
    return data;
  }
}
