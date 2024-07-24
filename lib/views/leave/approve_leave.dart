import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/api_constant.dart';
import '../../widget/error_dialouge.dart';
import '../../widget/loading_dialogue.dart';
import '../../widget/success_home_dialog.dart';
import '../../widget/toast.dart';

class ApproveDialog extends StatefulWidget {
  final String leaveId;
  final String status;

  const ApproveDialog({Key? key, required this.status, required this.leaveId})
      : super(key: key);

  @override
  _ApproveDialogState createState() => _ApproveDialogState();
}

class _ApproveDialogState extends State<ApproveDialog> {
  final TextEditingController _remarkController = TextEditingController();

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
                content: Container(
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Text(widget.status == "A"
                              ? "Approve Leave"
                              : "Reject Leave")),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.status == "A"
                                ? "Approval Date : "
                                : "Rejection Date : ",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              "${DateFormat('dd MMM yyyy').format(DateTime.now())}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  color: Colors.red.shade500),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          controller: _remarkController,
                          maxLines: 1,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          decoration:
                              _MobiletextFieldDecoration(label: "Remark")),
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
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 35,
                child: widget.status == "A"
                    ? Icon(Icons.check, color: Colors.white, size: 35)
                    : Icon(Icons.close, color: Colors.white, size: 35),
              ),
            ),
          ],
        )
      ],
    );
  }

  InputDecoration _MobiletextFieldDecoration({String? label}) {
    return InputDecoration(
      hintText: "Enter Remark",
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

  String? selectedFilePath;
  String? selectedFileName;

  Future<void> _approveLeave() async {
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
        Uri.parse('${ApiConstant.APPROVE_LEAVE}')
            .replace(queryParameters: params));

    request.body = json.encode({
      "leaveId": "${widget.leaveId}",
      "approvalStatus": "${widget.status}",
      "approvalDate": "${DateFormat('yyyy-MM-dd').format(DateTime.now())}",
      "approvalRemarks": _remarkController.text.toString()
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
        if (_remarkController.text.isEmpty) {
          Utils().themetoast("Please Enter Remark");
        } else {
          _approveLeave();
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
    _remarkController.dispose();
    super.dispose();
  }
}
