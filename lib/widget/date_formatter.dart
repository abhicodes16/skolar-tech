import 'package:intl/intl.dart';

class DateFormatter {
  static String convertDateFormat(String dateTimeString) {
    DateTime dateTime = DateFormat('yyyy-MM-dd').parse(dateTimeString);
    DateFormat newDateFormat = DateFormat('dd-MM-yyyy');
    String selectedDate = newDateFormat.format(dateTime);
    return selectedDate;
  }
}

class DateFormatterDMYD {
  static String convertDateFormat(String dateTimeString) {
    DateTime dateTime = DateFormat('yyyy-MM-dd').parse(dateTimeString);
    DateFormat newDateFormat = DateFormat('MMMMEEEEd');
    String selectedDate = newDateFormat.format(dateTime);
    return selectedDate;
  }
}

class DateFormatterWD {
  static String convertDateFormat(String dateTimeString) {
    DateTime dateTime = DateFormat('yyyy-MM-dd').parse(dateTimeString);
    DateFormat newDateFormat = DateFormat('dd-MM-yyyy');
    String selectedDate = newDateFormat.format(dateTime);
    return selectedDate;
  }
}

class DateFormatterDDMMYY {
  static String convertDateFormat(String dateTimeString) {
    DateTime dateTime = DateFormat('dd/MM/yyyy').parse(dateTimeString);
    DateFormat newDateFormat = DateFormat('dd-MM-yyyy      EEE');
    String selectedDate = newDateFormat.format(dateTime);
    return selectedDate;
  }
}

class DateFormatterDay {
  static String convertDateFormat(String dateTimeString) {
    DateTime dateTime = DateFormat('dd-MMM-yyyy').parse(dateTimeString);
    DateFormat newDateFormat = DateFormat('d');
    String selectedDate = newDateFormat.format(dateTime);
    return selectedDate;
  }
}

class DateFormatterE {
  static String convertDateFormat(String dateTimeString) {
    DateTime dateTime = DateFormat('dd-MMM-yyyy').parse(dateTimeString);
    DateFormat newDateFormat = DateFormat('E');
    String selectedDate = newDateFormat.format(dateTime);
    return selectedDate;
  }
}
