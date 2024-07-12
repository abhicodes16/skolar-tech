// ignore_for_file: constant_identifier_names

class ApiConstant {
  // static const String BASE_URL = "https://pns.ntier.in/";
  static const String BASE_URL = "https://skolartechapi.ntier.in/";

  static const String API_KEY = "1@N0G@ZKK@T2Z@U";

  static const String API_URL = '$BASE_URL/API/Master';

  // static const String LOGIN = '$API_URL/studentSignIn?schoolCode=';
  static const String LOGIN = '$API_URL/userSignIn?schoolCode=';
  static const String TEACHER_LOGIN = '$API_URL/teacherSignIn?schoolCode=';

  static const String TEACHER_PROFILE = '$API_URL/getTeacherProfile';

  static const String SCHOOL_INFO = '$API_URL/getSchoolInfo?schoolCode=';

  static const String BRANCH_NAME = '$API_URL/getBranchName';
  static const String CRS_COVERED_ = '$API_URL/postCourseCoveredByTeacherId';
  static const String SUBJECT_DETAILS = '$API_URL/getSubjectDetailsByTeacherId';
  static const String SELECT_SUBJECT = '$API_URL/postSubjectName';
  static const String SELECT_TOPIC = '$API_URL/postTopicName';
  static const String SELECT_CLASS = '$API_URL/getBranchName';
  static const String SELECT_SEMESTER = '$API_URL/getSemesterName';
  static const String CLASS_START_TIME = '$API_URL/postClassStartTime';

  static const String STD_DTLS = '$API_URL/getStudentDetails';
  static const String STD_ADMSN_DTLS = '$API_URL/getStdAdmissionDetails';
  static const String STD_LST_DTLS = '$API_URL/getStdLastinstitutionDetails';
  static const String STD_FML_DTLS = '$API_URL/getStdFamilyDetails';
  static const String STD_MTRC_DTLS = '$API_URL/getStdMatriculationDetails';

  static const String STD_NOTICE = '$API_URL/getNotice';
  static const String NOTICE_SUMMARY = '$API_URL/getNoticeSummary';
  static const String READ_STATUS = '$API_URL/postUpdateNoticeStatus';

  static const String STD_NEWS = '$API_URL/getNews';

  static const String ADMIN_HOME = '$API_URL/getAppAdminDashboard';
  static const String ADMIN_LOG = '$API_URL/getAppAdminLogEntities';
  static const String ADMIN_LOG_DETAILS = '$API_URL/postAppAdminActivityLogs';

  static const String ADMIN_CHANGE_PASS = '$API_URL/postAdminChangePassword';
  static const String STD_CHANGE_PASS = '$API_URL/postStudentChangePassword';
  static const String TEACHER_CHANGE_PASS = '$API_URL/postTeacherChangePassword';

  static const String HOLIDAY_LIST = '$API_URL/getHolidayList';
  static const String CURRENT_HOLIDAY_LIST =
      '$API_URL/postCurrentMonthHolidayList';

  static const String MENU_TEACHER = '$API_URL/getMenuControlDetailsForTeacher';
  static const String MENU_STUDENT = '$API_URL/getMenuControlDetailsForStudent';

  static const String FEE_COLLECTION = '$API_URL/getFeeCollectionDetails';
  static const String DUA_AMT = '$API_URL/getDueDetails';
  static const String UPCOMING_AMT = '$API_URL/getUpcomingPaymentDetails';
  static const String FEE_STRUCTURE = '$API_URL/getFeeStructure';

  static const String ATTENDANCE_LIST = '$API_URL/getAttendance';
  static const String ATTENDANCE_SUMMARY = '$API_URL/getAttendanceSummary';
  static const String MONTHLY_ATTENDANCE = '$API_URL/postMonthlyAttendance';
  static const String ATTENDACE_CLASS_WISE = '$API_URL/postAttendanceClassWise';

  static const String STUDENT_ATT_DTLS = '$API_URL/postStudentDetails';
  static const String ATT_HDR_INSRT = '$API_URL/postAttendanceHeaderInsert';

  static const String STD_FEES = '$API_URL/getFeeCollectionDetails';

  static const String PRE_YR_QUE = '$API_URL/postPreviousYearQuestionsDownload';
  static const String PRE_YR_QUE_UPLOAD =
      '$API_URL/postPreviousYearQuestionsByTeacher';

  static const String NOTIFICATION_TYPE = '$API_URL/getNotificationType';
  static const String NOTIFICATION_BYID = '$API_URL/PostNotificationByTypeId';
  static const String ALL_NOTIFICATION = '$API_URL/postAllNotificationById';

  static const String FEEDBACK_ENTITY = '$API_URL/getFeedbackEntityMaster';
  static const String ADD_FEEDBACK = '$API_URL/postStdFeedbackEntityWiseInsert';
  static const String FEEDBACK_HISTORY = '$API_URL/getStdFeedbackDetails';

  static const String HOMEWORK_LIST = '$API_URL/getHomeWork';
  static const String HOMEWORK_SUMMARY = '$API_URL/getHomeWorkSummary';
  static const String HOMEWORK_STATUS_UPDATE =
      '$API_URL/postUpdateHomeworkStatus';

  static const String EXAM_LIST = '$API_URL/getStudentExamDetails';
  static const String EXAM_DETAILS = '$API_URL/postStudentExamDetailsByExamId';
  static const String EXAM_RESULT_NAME = '$API_URL/getExamResultName';
  static const String EXAM_RESULT_COLUMN = '$API_URL/getExamResultColumnNames';
  static const String EXAM_RESULT_COLUMN_VAL =
      '$API_URL/postExamResultColumnValues';


  static const String GET_LEAVE_TYPE = '$API_URL/getLeaveTypeName';
  static const String POST_LEAVE = '$API_URL/postEmployeeLeaveApply';
  static const String GET_LEAVE_STATUS = '$API_URL/getEmployeeLeaveApplyStatus';
  static const String GET_LEAVE_SUMMERY = '$API_URL/getEmployeeLeaveSummary';



  static const String GET_EXAM_DECLARATION = '$API_URL/getExamDeclaration';
  static const String VIEw_EXAM_SCHEDULE = '$API_URL/postExamSchedule';


  static const String QUESTION_HISTORY = '$API_URL/getQuestionsUploadHistoryByTeacherId';
  static const String DELETE_QUESTIONS = '$API_URL/postPreviousYearQuestionsDeleteById';



  static const String UPLOAD_HOMEWORK = '$API_URL/postStudentHomeworkByTeacher';


  static const String GET_EXAMTYPE = '$API_URL/getExamTypeName';
  static const String INSERT_MARKS = '$API_URL/postStudentIACTMarkInsert';




  static const String ACADEMIC_CALENDAR = '$API_URL/postAcademicCalendar';

  //Queries
  static const String GET_QUERIES_TEACHER = '$API_URL/getStudentQueryByTeacher';
  static const String POST_REPLY_TEACHER = '$API_URL/postReplyForStudentSendQuery';
  static const String GET_REPLY_FROM_TEACHER = '$API_URL/getReplyDtlsForStudentSendQuery';
  static const String POST_QUERY = '$API_URL/postStudentSendQuery';
  static const String GET_DEPARTMENT_NAMES = '$API_URL/getEmpDepartmentName';
  static const String GET_EMP_NAMES = '$API_URL/postDeptWiseEmployeeName';
  static const String STUDENT_POST_QUERY = '$API_URL/postStudentQuery';
  static const String GET_STUDENT_QUERY = '$API_URL/getQueryReplyByStudent';
  static const String TEACHER_POST_REPLY = '$API_URL/postQueryReply';

  //Staff
  static const String GET_STAFF_DATA = '$API_URL/getStaffMembersDetails';

  static const String GET_DESIGNATIONS = '$API_URL/getDesignationNames';
  static const String GET_QUALIFICATIONS = '$API_URL/getQualificationNames';
  static const String GET_DEPARTMENTS = '$API_URL/getDepartmentNames';
  static const String UPDATE_PRPOFILE = '$API_URL/postTeacherProfileUpdate';

  //LIBRARY
  static const String GET_BOOKS = '$API_URL/postBookName';
  static const String BOOK_LIST = '$API_URL/postAvailableBookDetails';






}
