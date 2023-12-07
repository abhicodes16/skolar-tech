class SubjectDetailsModel {
  bool? success;
  String? message;
  int? responseCode;
  List<SubjectData>? data;

  SubjectDetailsModel(
      {this.success, this.message, this.responseCode, this.data});

  SubjectDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    responseCode = json['responseCode'];
    if (json['data'] != null) {
      data = <SubjectData>[];
      json['data'].forEach((v) {
        data!.add(new SubjectData.fromJson(v));
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

class SubjectData {
  int? sLNO;
  int? teacherId;
  String? teacherName;
  int? branchId;
  String? branchName;
  int? semesterId;
  String? semesterName;
  int? subjectId;
  String? subjectName;

  SubjectData(
      {this.sLNO,
      this.teacherId,
      this.teacherName,
      this.branchId,
      this.branchName,
      this.semesterId,
      this.semesterName,
      this.subjectId,
      this.subjectName});

  SubjectData.fromJson(Map<String, dynamic> json) {
    sLNO = json['SL_NO'];
    teacherId = json['TeacherId'];
    teacherName = json['TeacherName'];
    branchId = json['BranchId'];
    branchName = json['BranchName'];
    semesterId = json['SemesterId'];
    semesterName = json['SemesterName'];
    subjectId = json['SubjectId'];
    subjectName = json['SubjectName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SL_NO'] = this.sLNO;
    data['TeacherId'] = this.teacherId;
    data['TeacherName'] = this.teacherName;
    data['BranchId'] = this.branchId;
    data['BranchName'] = this.branchName;
    data['SemesterId'] = this.semesterId;
    data['SemesterName'] = this.semesterName;
    data['SubjectId'] = this.subjectId;
    data['SubjectName'] = this.subjectName;
    return data;
  }
}
