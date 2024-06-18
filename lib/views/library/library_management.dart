import 'dart:convert';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pns_skolar/style/theme_constants.dart';
import 'package:pns_skolar/widget/error_dialouge.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../model/Library/book_list_model.dart';
import '../../model/course/branch_select_model.dart';
import '../../model/get_book_model.dart';
import '../../repo/Course/select_class_repo.dart';
import '../../style/palette.dart';
import '../../utils/api_constant.dart';
import '../../widget/success_dialouge.dart';
import '../../widget/toast.dart';

class LibraryManagement extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LibraryManagement_State();
  }
}

class LibraryManagement_State extends State<LibraryManagement> {
  var height = Get.height;
  var width = Get.width;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectBranchApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Library Management',
          style: Palette.appbarTitle,
        ),
        flexibleSpace: Container(decoration: Palette.appbarGradient),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, right: 15, left: 15),
        child: Column(
          children: [
            loading
                ? Expanded(
                    child: Center(
                        child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(),
                  )))
                : _selectBranchModelList.isEmpty
                    ? SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Select Branch",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 5,
                          ),
                          CustomDropdown<String>(
                            decoration: CustomDropdownDecoration(
                                expandedFillColor: Colors.white,
                                closedFillColor: Colors.grey.shade200),
                            hintText: 'Select Branch',
                            items: List.generate(_selectBranchModelList.length,
                                (index) {
                              return "${_selectBranchModelList[index].cLSNAME.toString()}";
                            }),
                            initialItem:
                                "${_selectBranchModelList[0].cLSNAME.toString()}",
                            onChanged: (value) {
                              setState(() {
                                selectedBranchValue = _selectBranchModelList
                                    .firstWhere(
                                        (branch) => branch.cLSNAME == value)
                                    .cLSCODE; // Assuming id is the property storing the ID

                                _getBook(selectedBranchValue).then((value) =>
                                    bookList(
                                        selectedBranchValue, selectedBookID));
                                print("code --->${selectedBranchValue}");
                              });
                            },
                          ),
                        ],
                      ),
            SizedBox(
              height: 10,
            ),
            bookLoading
                ? SizedBox()
                : bookData.isEmpty
                    ? SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Select Book",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 5,
                          ),
                          CustomDropdown<String>(
                            decoration: CustomDropdownDecoration(
                                expandedFillColor: Colors.white,
                                closedFillColor: Colors.grey.shade200),
                            hintText: 'Select Book',
                            items: List.generate(bookData.length, (index) {
                              return "${bookData[index].bookName.toString()}";
                            }),
                            initialItem: "${bookData[0].bookName.toString()}",
                            onChanged: (value) {
                              setState(() {
                                selectedBookID = bookData
                                    .firstWhere(
                                        (branch) => branch.bookName == value)
                                    .bookId; // Assuming id is the property storing the ID

                                print("code --->${selectedBranchValue}");
                                bookList(selectedBranchValue, selectedBookID);
                              });
                            },
                          ),
                        ],
                      ),
            SizedBox(
              height: 10,
            ),
            
            bookListLoading ?
            Expanded(child: Center(child: SizedBox(height: 30,width: 30,child: CircularProgressIndicator(),))) :
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Available Books",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 5,
                  ),

                  bookListData.isEmpty ?
                  Expanded(child: Text("No Data Found..!"))
                      :
                  Expanded(
                    child: ListView.builder(
                      itemCount: bookListData.length,
                      itemBuilder: (context, index) {
                        var dataIndex = bookListData[index];

                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row(
                                  children: [

                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [

                                          Container(
                                            decoration: BoxDecoration(
                                                color: kThemeColor.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(color: kThemeColor)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6,right: 6,bottom: 3,top: 3
                                              ),
                                              child: Text(
                                                "${dataIndex.bookLanguage ?? "-"}",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    color: kThemeColor),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Number Of Books : ",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.grey),
                                          ),

                                          Text(
                                            "${dataIndex.noOfBooks ?? "-"}",
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.blue),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),

                                SizedBox(
                                  height: 10,
                                ),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${dataIndex.authorName ?? "-"}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: kThemeColor),
                                      ),
                                    ),
                                    Text(
                                      "${dataIndex.availabilities.toString().toLowerCase() == "yes" ? "Available" : "Unavailable"}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: dataIndex.availabilities
                                                      .toString()
                                                      .toLowerCase() ==
                                                  "yes"
                                              ? Colors.green
                                              : Colors.red),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),


                                Row(
                                  children: [
                                    Text(
                                      "Publisher : ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${dataIndex.publisherName ?? "-"}",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            color: kThemeColor),
                                      ),
                                    ),

                                    Text(
                                      "${dataIndex.edition ?? "-"} Edition",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.orange.shade600),
                                    )
                                  ],
                                ),




                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool loading = false;
  List<BranchSelectDataModel> _selectBranchModelList = [];
  int? selectedBranchValue;

  Future<void> selectBranchApi() async {
    setState(() {
      loading = true;
    });
    SelectClassRepo selectClassRepo = SelectClassRepo();
    try {
      BranchSelectModel data = await selectClassRepo.fetchBranchData();

      if (data.success!) {
        setState(() {
          _selectBranchModelList = data.data!;
          _getBook(data.data![0].cLSCODE);
        });
      }
    } catch (e) {
      print('Exeption $e');
      print('$selectedBranchValue');
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  var schoolCode;
  var token;
  var userID;
  bool bookLoading = false;
  var bookData = <Data>[];
  var selectedBookID;

  Future<void> _getBook(
    branchId,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      schoolCode = pref.getString('schoolCode');
      token = pref.getString('token');
      userID = pref.getString('userId');
      bookLoading = true;
      print("--->$token");
    });

    try {
      final params = {
        'schoolCode': '$schoolCode',
      };

      final uri =
          Uri.parse(ApiConstant.GET_BOOKS).replace(queryParameters: params);

      final response = await http.post(
        uri,
        headers: {
          'apikey': ApiConstant.API_KEY,
          'Content-Type': 'application/json',
          'token': token
        },
        body: json.encode({
          'branchId': '${branchId}',
        }),
      );

      print('Request Fields:');
      print('branchId: $branchId');
      print('branchId: ${json.decode(response.body)}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)['data'];
        print("-->response $responseData");
        if (json.decode(response.body)['success'] == true) {
          final getBookModel questionHistory =
              getBookModel.fromJson(json.decode(response.body));

          setState(() {
            bookData = questionHistory.data ?? [];
            bookList(selectedBranchValue, bookData[0].bookId);
          });
        }
      } else {
        Get.back();
        ErrorDialouge.showErrorDialogue(context, "Please Login Again");
      }
    } catch (e) {
      Utils().themetoast(e.toString());
    } finally {
      setState(() {
        bookLoading = false;
      });
    }
  }

  bool bookListLoading = false;

  var bookListData = <BookListData>[];

  Future<void> bookList(branchId, bookId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      schoolCode = pref.getString('schoolCode');
      token = pref.getString('token');
      userID = pref.getString('userId');
      bookListLoading = true;
      print("--->$token");
    });

    try {
      final params = {
        'schoolCode': '$schoolCode',
      };

      final uri =
          Uri.parse(ApiConstant.BOOK_LIST).replace(queryParameters: params);

      final response = await http.post(
        uri,
        headers: {
          'apikey': ApiConstant.API_KEY,
          'Content-Type': 'application/json',
          'token': token
        },
        body: json.encode({
          'branchId': '${branchId}',
          'bookId': '${bookId}',
        }),
      );

      print('Request Fields:');
      print('branchId: $branchId');
      print('branchId: ${json.decode(response.body)}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)['data'];
        print("-->response $responseData");
        if (json.decode(response.body)['success'] == true) {
          final BookListModel bookData =
              BookListModel.fromJson(json.decode(response.body));

          setState(() {
            bookListData = bookData.data ?? [];
          });
        }
      }
    } catch (e) {
      Utils().themetoast(e.toString());
    } finally {
      setState(() {
        bookListLoading = false;
      });
    }
  }
}
