import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pns_skolar/model/teacher_profile_model.dart';
import 'package:pns_skolar/repo/profile/teacher_profile_repo.dart';
import 'package:pns_skolar/style/palette.dart';
import 'package:pns_skolar/style/theme_constants.dart';
import 'package:pns_skolar/views/academicCalendar.dart';
import 'package:pns_skolar/views/attendance/attendance.dart';
import 'package:pns_skolar/views/change_pass.dart';
import 'package:pns_skolar/views/courses/subject_details.dart';
import 'package:pns_skolar/views/exam/exam_schedule.dart';
import 'package:pns_skolar/views/feedback/feedback_entity.dart';
import 'package:pns_skolar/views/holiday/holidays.dart';
import 'package:pns_skolar/views/leave/applyForleave.dart';
import 'package:pns_skolar/views/leave/leaveStatus.dart';
import 'package:pns_skolar/views/leave/leaveSummery.dart';
import 'package:pns_skolar/views/news/news.dart';
import 'package:pns_skolar/views/notice/notice.dart';
import 'package:pns_skolar/views/pre_year_que/select_class_sem.dart';
import 'package:pns_skolar/views/pre_year_que/upload_que_history.dart';
import 'package:pns_skolar/views/profile/TeacherProfile.dart';
import 'package:pns_skolar/views/profile/profile.dart';
import 'package:pns_skolar/views/query/student_queries.dart';
import 'package:pns_skolar/views/query/view_queries.dart';
import 'package:pns_skolar/views/school_code_screen.dart';
import 'package:pns_skolar/views/staff/staff_details.dart';
import 'package:pns_skolar/views/staff/staff_list.dart';
import 'package:pns_skolar/views/test/test_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/menu_control_bloc.dart';
import '../model/Details/std_admsn_dtls_model.dart';
import '../model/Details/student_details_model.dart';
import '../model/homework/home_work_summary_model.dart';
import '../model/menu_control_model.dart';
import '../model/notice/notice_summary_model.dart';
import '../repo/homework/homework_repo.dart';
import '../repo/notice/notice_repo.dart';
import '../repo/profile/profile_repo.dart';
import '../style/assets_constants.dart';
import '../utils/response.dart';
import '../widget/error_message.dart';
import '../widget/loading.dart';
import 'attendance/student_attendance_details.dart';
import 'demoPage.dart';
import 'examResult/exam_result.dart';
import 'fee/fee_collection.dart';
import 'holiday/current_month_holiday.dart';
import 'homework/homework.dart';
import 'login.dart';
import 'notification/notification_type.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool? isLogin = false;
  bool? isTeacher = false;
  bool isLoading = true;
  String? sTDNAME = '';
  String? eMPNAME = '';
  String sTDPHTURL = '';
  String eMPPHTURL = '';
  String? sTDDOB = '';
  String? eMPDOB = '';
  String? eMPDESGCODE = '';
  String? sTDMOB = '';
  String? eMPMOB = '';
  String? sTDEMAIL = '';
  String? eMPMAILID = '';
  String? sTDSemester = '';
  String? sTDROLNO = '';
  String? sTDBRANCH = '';

  String unread = '';
  String unreadHomework = '';

  MenuControlBloc menuControlBloc = MenuControlBloc();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _checkLogin();
    });
  }

  final List<Widget> _pages = [
    DemoPage(),
    const MyProfile(),
    Attendance(),
    NoticePage(),
    NewsPage(),
    CurMnthHolidayList()
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAlertDialog();
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.logout),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            _customHdr(size: size),
            StreamBuilder(
              stream: menuControlBloc.dataStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      return Loading(loadingMessage: snapshot.data.message);
                    case Status.COMPLETED:
                      return _gridMenuWidgets(snapshot.data.data);
                    case Status.ERROR:
                      return ErrorMessage(
                        errorMessage: snapshot.data.message,
                      );
                  }
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _gridMenuWidgets(MenuControlModel menuControlModel) {
    MenuControlData menuControlData = MenuControlData();
    if (menuControlModel.data != null) {
      if (menuControlModel.data!.isNotEmpty) {
        menuControlData = menuControlModel.data!.first;
      }
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.58,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: GridView.count(
                shrinkWrap: true,
                primary: false,
                crossAxisCount: 3,
                childAspectRatio: 1.1,
                children: [
                  if (menuControlData.pROFILE == 'Y')
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            if (isTeacher!) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TeacherProfile(),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyProfile(),
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              color: Color(0xFF6FE08D),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        )
                      ],
                    ),

                  if (menuControlData.aTTENDANCE == 'Y')
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            isTeacher!
                                ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const AttendanceDetails(),
                              ),
                            )
                                : Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Attendance(),
                              ),
                            );
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              color: Color(0xFF61BDFD),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Attendance',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        )
                      ],
                    ),

                  if (menuControlData.nOTICE == 'Y')
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NoticePage(),
                              ),
                            ).then((value) => setDataForNoticeAPI());
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 243, 78, 78),
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.report_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                              unread.isNotEmpty && unread != '0'
                                  ? Positioned(
                                top: 0,
                                right: 0,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(26.0)),
                                  color: Colors.white,
                                  elevation: 8,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        6, 2, 6, 2),
                                    child: Text(
                                      unread,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12.5,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Notice',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        )
                      ],
                    ),

                  if (menuControlData.nOTIFICATIONS == 'Y')
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotificationType(),
                              ),
                            );
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFCF2F),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.notifications,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Notification',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        )
                      ],
                    ),

                  if (menuControlData.nEWS == 'Y')
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsPage(),
                              ),
                            );
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              color: Color(0xFFCB84FB),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.newspaper,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'News',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        )
                      ],
                    ),
                  if (menuControlData.hOLIDAY == 'Y')
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            if (isTeacher!) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CurMnthHolidayList(),
                                ),
                              );
                            } else {
                              CalenderBottomDialog();
                            }
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              color: Color(0xFF78E667),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.calendar_today_sharp,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Calendar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        )
                      ],
                    ),
                  if (!isTeacher! && menuControlData.hOMEWORK == 'Y')
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeWorkPage(),
                              ),
                            ).then((value) => setDataFromAPIHomework());
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 255, 175, 1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.menu_book_rounded,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                              unreadHomework.isNotEmpty && unreadHomework != '0'
                                  ? Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(26.0)),
                                        color: Colors.white,
                                        elevation: 8,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              6, 2, 6, 2),
                                          child: Text(
                                            unreadHomework,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Assignment',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        )
                      ],
                    ),
                  if (!isTeacher! && menuControlData.rESULTPUBLISH == 'Y')
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            ExamBottomDialog();
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => ExamResult(),
                            //   ),
                            // );
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 57, 60, 226),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.note_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Exam',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        )
                      ],
                    ),
                  if (!isTeacher! && menuControlData.fEES == 'Y')
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FeeCollectionPage(),
                              ),
                            );
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 76, 174, 231),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.monetization_on_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Fees',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        )
                      ],
                    ),
                  if (isTeacher! && menuControlData.lEAVE == 'Y')
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            leaveBottomDialog();
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.purple.shade600,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.note_alt_rounded,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Leave',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        )
                      ],
                    ),
                  //New Added for Teacher
                  if (isTeacher! && menuControlData.hOMEWORK == 'Y')
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SubjectDetails(
                                  isTeacherHomework: true,
                                  isTeacher: true,
                                ),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 255, 175, 1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.menu_book_rounded,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                              unreadHomework.isNotEmpty && unreadHomework != '0'
                                  ? Positioned(
                                top: 0,
                                right: 0,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(26.0)),
                                  color: Colors.white,
                                  elevation: 8,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        6, 2, 6, 2),
                                    child: Text(
                                      unreadHomework,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12.5,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Assignment',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        )
                      ],
                    ),
                  if (isTeacher! && menuControlData.hOMEWORK == 'Y')
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(()=>TestDetails());
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(211, 31, 156, 1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Icon(CupertinoIcons.text_badge_star,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),


                              unreadHomework.isNotEmpty && unreadHomework != '0'
                                  ? Positioned(
                                top: 0,
                                right: 0,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(26.0)),
                                  color: Colors.white,
                                  elevation: 8,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        6, 2, 6, 2),
                                    child: Text(
                                      unreadHomework,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12.5,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Test',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        )
                      ],
                    ),
                  if (!isTeacher! && menuControlData.fEEDBACK == 'Y')
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FeedbackEntity(),
                              ),
                            );
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              color: Colors.cyan,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.feedback_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Feedback',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        )
                      ],
                    ),
                  if (isTeacher! )
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(()=>ViewQueries());
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.red.shade600,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.question_answer_sharp,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Query',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        )
                      ],
                    ),

                  if (isTeacher! )
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(()=>StaffList());
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade900,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.group,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Staff',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        )
                      ],
                    ),

                  if (!isTeacher! )
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(()=>StudentQueries(),
                            arguments: {
                              'branchID' : sTDBRANCH
                            }
                            );
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.green.shade600,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.question_answer_sharp,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Query',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        )
                      ],
                    ),
                ],
              ),
            ),
            isTeacher! && menuControlData.cOURSECOVERED == 'Y'
                ? Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 5, bottom: 5),
                    child: Card(
                      elevation: 5,
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {

                           Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SubjectDetails()
                              )
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: ListTile(
                            title: Text('Course Covered'),
                            trailing: Icon(CupertinoIcons.arrow_right),
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
            !isTeacher! && menuControlData.pREVIOUSYEARQUESTIONS == 'Y' ?
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 5, bottom: 5),
              child: Card(
                elevation: 5,
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {
                      Get.to(QuestionHistory());
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: ListTile(
                      title: Text("Download Previous Year Questions"),
                      trailing: Icon(CupertinoIcons.arrow_right),
                    ),
                  ),
                ),
              ),
            )
            :
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 5, bottom: 5),
              child: Card(
                elevation: 5,
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {
                    if(isTeacher! && menuControlData.pREVIOUSYEARQUESTIONS == 'Y'){
                      PreYearQueBottomDialog();
                    }else{
                      Get.to(QuestionHistory());
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: ListTile(
                      title: Text("Previous Year Questions"),
                      trailing: Icon(CupertinoIcons.arrow_right),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
              child: Card(
                elevation: 5,
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChnagePassword(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: ListTile(
                      title: Text('Change Password'),
                      trailing: Icon(CupertinoIcons.arrow_right),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void PreYearQueBottomDialog() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return SizedBox(
            // height: 240,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          '',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18.0),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.close, size: 22),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(height: 5),
                Container(
                  height: 200,
                  // color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 15, right: 20, left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            if (isTeacher!) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SubjectDetails(
                                    isPrevYearQue: true,
                                    isTeacher: true,
                                  ),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SelectClassSem(),
                                ),
                              );
                            }
                          },
                          child: Card(
                            child: ListTile(
                              title: Text("Upload Previous Year Questions"),
                              trailing: CircleAvatar(
                                  radius: 15,
                                  foregroundColor: kThemeColor,
                                  child: Icon(Icons.arrow_right)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            Get.to(QuestionHistory());
                          },
                          child: Card(
                            child: ListTile(
                              title: Text("Previous Year Questions History"),
                              trailing: CircleAvatar(
                                  radius: 15,
                                  foregroundColor: kThemeColor,
                                  child: Icon(Icons.arrow_right)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15)
              ],
            ),
          );
        });
  }



  void CalenderBottomDialog() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return SizedBox(
            // height: 240,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          '',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18.0),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.close, size: 22),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(height: 5),
                Container(
                  height: 200,
                  // color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 15, right: 20, left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            Get.to(CurMnthHolidayList());
                            // Get.to(ApplyForLeave());
                          },
                          child: Card(
                            child: ListTile(
                              title: Text("Holidays"),
                              trailing: CircleAvatar(
                                  radius: 15,
                                  foregroundColor: kThemeColor,
                                  child: Icon(Icons.arrow_right)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            Get.to(AcademicCalender());
                          },
                          child: Card(
                            child: ListTile(
                              title: Text("Academic Calender"),
                              trailing: CircleAvatar(
                                  radius: 15,
                                  foregroundColor: kThemeColor,
                                  child: Icon(Icons.arrow_right)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15)
              ],
            ),
          );
        });
  }

  void ExamBottomDialog() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return SizedBox(
            // height: 240,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          '',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18.0),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.close, size: 22),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(height: 5),
                Container(
                  height: 200,
                  // color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 15, right: 20, left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            Get.to(ExamSchedule());
                            // Get.to(ApplyForLeave());
                          },
                          child: Card(
                            child: ListTile(
                              title: Text("Exam Schedule"),
                              trailing: CircleAvatar(
                                  radius: 15,
                                  foregroundColor: kThemeColor,
                                  child: Icon(Icons.arrow_right)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            Get.to(ExamResult());
                          },
                          child: Card(
                            child: ListTile(
                              title: Text("Exam Result"),
                              trailing: CircleAvatar(
                                  radius: 15,
                                  foregroundColor: kThemeColor,
                                  child: Icon(Icons.arrow_right)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15)
              ],
            ),
          );
        });
  }

  void leaveBottomDialog() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return SizedBox(
            // height: 240,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          '',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18.0),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.close, size: 22),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(height: 5),
                Container(
                  height: 270,
                  // color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 15, right: 20, left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            Get.to(ApplyForLeave());
                          },
                          child: Card(
                            child: ListTile(
                              title: Text("Apply For Leave"),
                              trailing: CircleAvatar(
                                  radius: 15,
                                  foregroundColor: kThemeColor,
                                  child: Icon(Icons.arrow_right)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            Get.to(LeaveSatus());
                          },
                          child: Card(
                            child: ListTile(
                              title: Text("Leave Status"),
                              trailing: CircleAvatar(
                                  radius: 15,
                                  foregroundColor: kThemeColor,
                                  child: Icon(Icons.arrow_right)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            Get.to(LeaveSummery());
                          },
                          child: Card(
                            child: ListTile(
                              title: Text("Leave Summary"),
                              trailing: CircleAvatar(
                                  radius: 15,
                                  foregroundColor: kThemeColor,
                                  child: Icon(Icons.arrow_right)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15)
              ],
            ),
          );
        });
  }

  Widget _customHdr({required Size size}) {
    return Container(
      height: size.height * 0.3,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              top: 50,
            ),
            height: size.height * 0.4 - 27,
            decoration: const BoxDecoration(
              color: Color(0xff392850),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: !isLoading
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isTeacher! ? eMPNAME ?? '' : sTDNAME ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                  color: Color.fromARGB(255, 190, 188, 188),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                width: 180,
                                child: Text(
                                  isTeacher!
                                      ? eMPDESGCODE ?? ''
                                      : sTDBRANCH ?? '',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                    color: Color.fromARGB(255, 190, 188, 188),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              isTeacher!
                                  ? const SizedBox()
                                  : Text(
                                      '($sTDSemester)',
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        height: 1.5,
                                        color:
                                            Color.fromARGB(255, 190, 188, 188),
                                      ),
                                    ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    child: const Icon(
                                      CupertinoIcons.calendar,
                                      color: kWhite,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      isTeacher! ? eMPDOB ?? '' : sTDDOB ?? '',
                                      style: const TextStyle(
                                        color: kWhite,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    child: const Icon(
                                      CupertinoIcons.phone,
                                      color: kWhite,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      isTeacher! ? eMPMOB ?? '' : sTDMOB ?? '',
                                      style: const TextStyle(
                                        color: kWhite,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    child: const Icon(
                                      CupertinoIcons.mail,
                                      color: kWhite,
                                    ),
                                  ),
                                  Container(
                                    child: SizedBox(
                                      width: 150,
                                      child: Text(
                                        isTeacher!
                                            ? eMPMAILID ?? ''
                                            : sTDEMAIL ?? '',
                                        style: const TextStyle(
                                          color: kWhite,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              _tchProfileImg(),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _tchProfileImg() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x54000000),
            spreadRadius: 3,
            blurRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0), //or 15.0
        child: Container(
          height: 120.0,
          width: 110.0,
          color: kThemeColor,
          child: sTDPHTURL.isEmpty && eMPPHTURL.isEmpty
              ? Image.asset(Assets.avatar)
              : Image.network(
                  isTeacher! ? eMPPHTURL : sTDPHTURL,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }

  void logoutUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String schoolLabel = pref.getString('schoolCodeName') ?? '';

    pref.clear();
    pref.setString('schoolCodeName', schoolLabel);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SchoolCodeScreen()),
      (route) => false,
    );
  }

  showAlertDialog() {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text(
        "Cancel",
        style: TextStyle(
            fontFamily: kThemeFont, fontSize: 14.0, color: Colors.black),
      ),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        "Yes",
        style: TextStyle(
            fontFamily: kThemeFont, fontSize: 14.0, color: kThemeColor),
      ),
      onPressed: () {
        Navigator.pop(context, false);
        logoutUser();
        // Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Logout"),
      content: const Text("Are you sure you want to logout?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void setAdmsnDataFromAPI() async {
    DetailsRepo detailsRepo = DetailsRepo();
    StdAdmsnDtlsModel studentDetails = await detailsRepo.fetchAdmsnData();

    setState(
      () {
        //isLoading = false;
        sTDBRANCH = studentDetails.data![0].sTDBRANCH!;
        sTDROLNO = studentDetails.data![0].sTDROLNO!;
        sTDSemester = studentDetails.data![0].sTDSemester!;
      },
    );
  }

  void setDataFromAPI() async {
    DetailsRepo detailsRepo = DetailsRepo();
    StudentDetailsModel studentDetails = await detailsRepo.fetchData();

    setState(
      () {
        sTDNAME = studentDetails.data![0].sTDNAME!;
        sTDDOB = studentDetails.data![0].sTDDOB!;
        sTDMOB = studentDetails.data![0].sTDMOB!;
        sTDPHTURL = studentDetails.data![0].sTDPHTURL ?? '';
        print('profile ::: $sTDPHTURL');
        isLoading = false;
      },
    );
  }

  void setTeacherDataFromAPI() async {
    TeacherProfileRepo detailsRepo = TeacherProfileRepo();
    TeacherProfileModel teacherDetails = await detailsRepo.fetchData();
    setState(
      () {
        eMPNAME = teacherDetails.data![0].eMPNAME!;
        eMPPHTURL = teacherDetails.data![0].eMPPHTURL ?? '';
        eMPDESGCODE = teacherDetails.data![0].eMPDESGCODE!;
        eMPMAILID = teacherDetails.data![0].eMPMAILID!;
        eMPMOB = teacherDetails.data![0].eMPMOB!;
        eMPDOB = teacherDetails.data![0].eMPDOB!;
        isLoading = false;
      },
    );
  }

  Future<void> _checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      isLogin = pref.getBool('isLoggedIn') ?? false;
      if (isLogin!) {
        isTeacher = pref.getBool('isTeacher') ?? false;
        if (isTeacher!) {
          setTeacherDataFromAPI();
        } else {
          setDataFromAPI();
          setAdmsnDataFromAPI();
          setDataForNoticeAPI();
          setDataFromAPIHomework();
        }
      }
    });
  }

  void setDataForNoticeAPI() async {
    NoticeRepo noticeRepo = NoticeRepo();
    NoticeSummaryModel noticeSummaryModel = await noticeRepo.fetchSummaryData();

    setState(() {
      if (noticeSummaryModel.data != null) {
        if (noticeSummaryModel.data!.isNotEmpty) {
          unread = noticeSummaryModel.data![0].unread!;
        }
      }
    });
  }

  void setDataFromAPIHomework() async {
    HomeWorkRepo homeworkRepo = HomeWorkRepo();
    HomeWorkSummaryModel data = await homeworkRepo.fetchSummaryData();
    setState(() {
      if (data.data != null) {
        if (data.data!.isNotEmpty) {
          unreadHomework = data.data![0].incompleteHW!;
        }
      }
    });
  }
}
