import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/api_constant.dart';
import '../../widget/error_dialouge.dart';
import '../../widget/loading_dialogue.dart';
import '../../widget/success_home_dialog.dart';
import '../../widget/toast.dart';

class ReplyDialog extends StatefulWidget {
  final String queryId;

  const ReplyDialog({Key? key, required this.queryId}) : super(key: key);

  @override
  _ReplyDialogState createState() => _ReplyDialogState();
}

class _ReplyDialogState extends State<ReplyDialog> {
  final TextEditingController _replyController = TextEditingController();

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
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Text("Enter Your Reply")),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          controller: _replyController,
                          maxLines: 2,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          decoration:
                              _MobiletextFieldDecoration(label: "Reply")),
                      SizedBox(
                        height: 20,
                      ),
                      _atteachedImgWidget(),
                      SizedBox(
                        height: 20,
                      ),
                      _sbmitBtn()
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 35,
                child: Icon(Icons.reply, color: Colors.white, size: 35),
              ),
            ),
          ],
        )
      ],
    );
  }

  Future<void> openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      setState(() {
        selectedFilePath = file.path!;
        selectedFileName = file.name;
      });
      //sendFileToApi(filePath: file.path!);
    } else {
      // User canceled the picker
    }
  }

  Widget _atteachedImgWidget() {
    return Card(
      shape: Palette.cardShape,
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      elevation: 0,
      color: kThemeColor.withOpacity(0.1),
      child: InkWell(
        onTap: openFilePicker,
        child: SizedBox(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.attach_file, color: Colors.grey),
                    selectedFileName != null
                        ? Container(
                            // width: Get.width*0.8,
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              '  $selectedFileName',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: width * 0.03,
                              ),
                            ),
                          )
                        : Text(
                            '  Attech PDF / Documents',
                            style: Palette.subTitleGrey,
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _MobiletextFieldDecoration({String? label}) {
    return InputDecoration(
      hintText: "Enter Reply",
      suffixIcon: Icon(
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

  Future<void> _uploadFile() async {
    LoadingDialog.showLoadingDialog(context);
    SharedPreferences pref = await SharedPreferences.getInstance();

    String schoolCode = pref.getString('schoolCode') ?? '';
    final params = {
      'schoolCode': '$schoolCode',
    };

    var request = http.MultipartRequest(
        "POST",
        Uri.parse('${ApiConstant.TEACHER_POST_REPLY}')
            .replace(queryParameters: params));

    request.headers['token'] = pref.getString('token')!;
    request.headers['apikey'] = ApiConstant.API_KEY;
    request.headers['Content-Type'] = 'multipart/form-data';

    request.fields['replyById'] = widget.queryId.toString();
    request.fields['replyDetails'] = _replyController.text.toString();

    if (selectedFilePath == null) {
      selectedFilePath = null;
    } else {
      var uploadFile = await http.MultipartFile.fromPath(
        "replyAttachment",
        selectedFilePath!,
        contentType: MediaType('application', 'pdf'),
      );
      request.files.add(uploadFile);
    }

    print('Requested Fields:');
    print('Fields: ${request.fields}');
    print('File Details:');
    request.files.forEach((element) {
      print("field :::::: ${element.field}");
      print('File Name: ${element.filename}');
      print('Content Type: ${element.contentType}');
      print('Size: ${element.length}');
    });

    // Send JSON payload using POST request
    var response = await request.send();

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
        if (_replyController.text.isEmpty) {
          Utils().themetoast("Please Enter Your Reply");
        } else if (selectedFilePath == null) {
          ErrorDialouge.showErrorDialogue(
              context, 'Please Atteched Document or File');
        } else {
          _uploadFile();
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
            ? Center(
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
    _replyController.dispose();
    super.dispose();
  }
}
