class BookListModel {
  bool? success;
  String? message;
  int? responseCode;
  List<BookListData>? data;

  BookListModel({this.success, this.message, this.responseCode, this.data});

  BookListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    responseCode = json['responseCode'];
    if (json['data'] != null) {
      data = <BookListData>[];
      json['data'].forEach((v) {
        data!.add(new BookListData.fromJson(v));
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

class BookListData {
  String? bookLanguage;
  String? authorName;
  String? publisherName;
  String? edition;
  String? availabilities;
  int? noOfBooks;

  BookListData(
      {this.bookLanguage,
        this.authorName,
        this.publisherName,
        this.edition,
        this.availabilities,
        this.noOfBooks});

  BookListData.fromJson(Map<String, dynamic> json) {
    bookLanguage = json['bookLanguage'];
    authorName = json['authorName'];
    publisherName = json['publisherName'];
    edition = json['edition'];
    availabilities = json['availabilities'];
    noOfBooks = json['noOfBooks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookLanguage'] = this.bookLanguage;
    data['authorName'] = this.authorName;
    data['publisherName'] = this.publisherName;
    data['edition'] = this.edition;
    data['availabilities'] = this.availabilities;
    data['noOfBooks'] = this.noOfBooks;
    return data;
  }
}
