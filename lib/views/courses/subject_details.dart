import 'package:flutter/material.dart';
import 'package:pns_skolar/views/courses/course_covered.dart';
import 'package:pns_skolar/views/homework/upload_homework.dart';
import 'package:pns_skolar/views/pre_year_que/pre_year_que.dart';
import 'package:pns_skolar/views/pre_year_que/upload_pre_year_que.dart';

import '../../bloc/course/subject_details_bloc.dart';
import '../../model/course/subject_details_model.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/response.dart';
import '../../widget/error_message.dart';
import '../../widget/loading.dart';
import '../../widget/no_data_foud.dart';
import '../attendance/student_attendance_details.dart';

class SubjectDetails extends StatefulWidget {
  bool isAttendace;
  bool isPrevYearQue;
  bool isTeacher;
  bool isTeacherHomework;
  SubjectDetails({
    super.key,
    this.isAttendace = false,
    this.isTeacherHomework = false,
    this.isPrevYearQue = false,
    this.isTeacher = true,
  });

  @override
  State<SubjectDetails> createState() => _SubjectDetailsState();
}

class _SubjectDetailsState extends State<SubjectDetails> {
  SubjectDetailsBloc subjectDetailsBloc = SubjectDetailsBloc();

  @override
  void initState() {
    super.initState();
    if (widget.isTeacher) {
      subjectDetailsBloc = SubjectDetailsBloc();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Subject Details',
          style: Palette.appbarTitle,
        ),
        flexibleSpace: Container(
          decoration: Palette.appbarGradient,
        ),
      ),
      body: StreamBuilder(
        stream: subjectDetailsBloc.dataStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Loading(loadingMessage: snapshot.data.message);
              case Status.COMPLETED:
                return _listWidget(snapshot.data.data);
              case Status.ERROR:
                return ErrorMessage(errorMessage: snapshot.data.message);
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget _listWidget(SubjectDetailsModel subjectDetailsModel) {
    if (subjectDetailsModel.data!.isEmpty) {
      return const NoDataFound();
    } else {
      return ListView.builder(
        itemCount: subjectDetailsModel.data!.length,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        itemBuilder: (context, index) {
          return Card(
            margin: kStandardMargin * 2,
            shape: Palette.cardShape,
            elevation: 8,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                if (widget.isAttendace) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AttendanceDetails(),
                    ),
                  );
                } else if (widget.isPrevYearQue) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UploadPreYearQue(
                        subCode: subjectDetailsModel.data![index].subjectId
                            .toString(),
                      ),
                    ),
                  );
                }  else if (widget.isTeacherHomework) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UploadHomework(
                        subCode: subjectDetailsModel.data![index].subjectId
                            .toString(),
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourseCovered(
                        sUBID: subjectDetailsModel.data![index].subjectId
                            .toString(),
                      ),
                    ),
                  );
                }
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${subjectDetailsModel.data![index].subjectName.toString() == "null" ? "-" : subjectDetailsModel.data![index].subjectName.toString()}",
                            style: Palette.themeTitle,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Branch : ${subjectDetailsModel.data![index].branchName ?? ''}',
                            style: Palette.titleSB,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Semester : ${subjectDetailsModel.data![index].semesterName ?? ''}',
                            style: Palette.titleSB,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Teacher : ${subjectDetailsModel.data![index].teacherName ?? ''}',
                            style: Palette.subTitleLK,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
