import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:pns_skolar/widget/date_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/api_constant.dart';
import '../../widget/error_dialouge.dart';
import '../../widget/loading_dialogue.dart';
import '../../widget/success_home_dialog.dart';
import '../../widget/toast.dart';

class AddColDialog extends StatefulWidget {

  const AddColDialog({Key? key,})
      : super(key: key);

  @override
  _AddColDialogState createState() => _AddColDialogState();
}

class _AddColDialogState extends State<AddColDialog> {
  final TextEditingController _descriptionController = TextEditingController();

  bool submitLoading = false;

  var height = Get.height;
  var width = Get.width;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context)
        .size
        .width; // Assuming 'width' is defined somewhere in your class.

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: AlertDialog(
                //key: key,
                //backgroundColor: Colors.white,
                content: SizedBox(
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Align(
                          alignment: Alignment.center,
                          child: Text("Employee COL Entry")),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Select Start Date : ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      selectStartDatePicker(),

                      const SizedBox(
                        height: 10,
                      ),

                      const Text("Select End Date : ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      selectEndDatePicker(),

                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          controller: _descriptionController,
                          maxLines: 2,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          decoration:
                              _MobiletextFieldDecoration(label: "Description")),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _sbmitBtn()
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 35,
                child:Icon(Icons.add, color: Colors.white, size: 35),
              ),
            ),
          ],
        )
      ],
    );
  }

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  Widget selectStartDatePicker() {
    return Container(
      // margin: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Center(
        child: TextField(
          controller: startDateController,
          decoration: etBoxDecoration('Start Date'),
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: kThemeColor,
                        onPrimary: kWhite,
                        onSurface: kThemeColor,
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          primary: Colors.red,
                        ),
                      ),
                    ),
                    child: child!,
                  );
                },
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2101));

            if (pickedDate != null) {
              print(pickedDate);
              String formattedDate =
              DateFormat('dd-MM-yyyy').format(pickedDate);
              print(formattedDate);
              setState(() {
                startDateController.text = formattedDate;
              });
            } else {
              print("Date is not selected");
            }
          },
        ),
      ),
    );
  }

  Widget selectEndDatePicker() {
    return Container(
      // margin: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Center(
        child: TextField(
          controller: endDateController,
          decoration: etBoxDecoration('End Date'),
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: kThemeColor,
                        onPrimary: kWhite,
                        onSurface: kThemeColor,
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          primary: Colors.red,
                        ),
                      ),
                    ),
                    child: child!,
                  );
                },
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2101));

            if (pickedDate != null) {
              print(pickedDate);
              String formattedDate =
              DateFormat('dd-MM-yyyy').format(pickedDate);
              print(formattedDate);
              setState(() {
                endDateController.text = formattedDate;
              });
            } else {
              print("Date is not selected");
            }
          },
        ),
      ),
    );
  }


  InputDecoration etBoxDecoration(String label) {
    return InputDecoration(
      fillColor: white,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kThemeColor.withOpacity(0.1), width: 2.0),
        borderRadius: BorderRadius.circular(7.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kThemeColor.withOpacity(0.1), width: 2.0),
        borderRadius: BorderRadius.circular(7.0),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: kThemeColor.withOpacity(0.1), width: 2.0),
        borderRadius: BorderRadius.circular(7.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kThemeColor.withOpacity(0.1), width: 2.0),
        borderRadius: BorderRadius.circular(7.0),
      ),
      contentPadding: const EdgeInsets.all(15.0),
      hintText: label,
      hintStyle: const TextStyle(color: Colors.grey),
    );
  }

  InputDecoration _MobiletextFieldDecoration({String? label}) {
    return InputDecoration(
      hintText: "Enter Description",
      suffixIcon: const Icon(
        Icons.messenger,
      ),
      counter: const Offstage(),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
              BorderSide(width: 2.0, color: Colors.grey.withOpacity(0.1))),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
              BorderSide(width: 2.0, color: Colors.grey.withOpacity(0.1))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
              BorderSide(width: 2.0, color: Colors.grey.withOpacity(0.1))),
      contentPadding: const EdgeInsets.all(15.0),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.1),
      labelText: "$label",
      alignLabelWithHint: true,
      labelStyle: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w400,
      ),
    );
  }


  Future<void> addColEntry() async {
    LoadingDialog.showLoadingDialog(context);
    SharedPreferences pref = await SharedPreferences.getInstance();

    String schoolCode = pref.getString('schoolCode') ?? '';
    final params = {
      'schoolCode': '$schoolCode',
    };

    var headers = {
      'apikey': ApiConstant.API_KEY,
      'Content-Type': 'application/json',
      'token': pref.getString('token')!,
    };

    var request = http.Request(
        'POST',
        Uri.parse('${ApiConstant.ADD_EMP_COL_ENTRY}')
            .replace(queryParameters: params));

    request.body = json.encode({
      "fromDate": "${DateFormatter.newConvertDateFormat(startDateController.text.toString())}",
      "toDate": "${DateFormatter.newConvertDateFormat(endDateController.text.toString())}",
      "descriptions": _descriptionController.text.toString()
    });
    request.headers.addAll(headers);

    print("${request.body}");
    http.StreamedResponse response = await request.send();
    var responsed = await http.Response.fromStream(response);
    // Listen for response
    try {
      if (response.statusCode == 200) {
        var decode = json.decode(responsed.body);
        print("${json.decode(responsed.body)}");
        Navigator.pop(context);
        // Set response
        if (decode['success'] != null) {
          if (decode['success']) {
            SuccessHomeDialog.show(
                context, decode['data'][0]['msg'].toString());
          } else {
            ErrorDialouge.showErrorDialogue(context, decode['message']);
          }
        }
      } else {
        // Handle non-200 status code
        print('Error: ${response.statusCode}');
        print('Response: ${responsed.body}');
        Navigator.pop(context);
      }
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(context, e.toString());
    }
  }

  Widget _sbmitBtn() {
    return InkWell(
      onTap: () {
        if (_descriptionController.text.isEmpty) {
          Utils().themetoast("Please Enter Description");
        } else {
          addColEntry();
        }
      },
      child: Container(
        width: width * 1,
        height: 45,
        decoration: BoxDecoration(
          color: kThemeColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: submitLoading
            ? const Center(
                child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    )),
              )
            : Center(
                child: Text(
                "Submit",
                style: Palette.whiteBtnTxt,
              )),
      ),
    );
  }

  var schoolCode;
  var token;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
