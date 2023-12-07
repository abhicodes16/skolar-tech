import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pns_skolar/views/school_code_screen.dart';
import '../widget/navigation_service.dart';
import 'api_constant.dart';
import 'custom_exception.dart';

class ApiProvider {
  Future<dynamic> httpMethod(
      {String? method, String? url, var requestBody}) async {
    http.Response? response;
    try {
      if (method == 'GET') {
        response = await http.get(
          Uri.parse(url!),
          headers: {
            'Content-Type': 'application/json',
            'apikey': ApiConstant.API_KEY,
          },
        );
      } else if (method == 'POST') {
        response = await http.post(
          Uri.parse(url!),
          headers: {
            'Content-Type': 'application/json',
            'apikey': ApiConstant.API_KEY,
          },
          body: json.encode(requestBody),
        );
      }
    } on SocketException {
      throw FetchDataException(' Will Back Soon');
    }
    return _response(response!);
  }

  // To pass headers params
  Future<dynamic> httpMethodWithToken(
      {String? method, String? url, var requestBody, String? token}) async {
    http.Response? response;
    try {
      if (method == 'GET') {
        response = await http.get(
          Uri.parse(url!),
          headers: {
            'Content-Type': 'application/json',
            'apikey': ApiConstant.API_KEY,
            'token': token!,
          },
        );
      } else if (method == 'POST') {
        response = await http.post(
          Uri.parse(url!),
          body: json.encode(requestBody),
          headers: {
            'Content-Type': 'application/json',
            'apikey': ApiConstant.API_KEY,
            'token': token!,
          },
        );
      }
    } on SocketException {
      throw FetchDataException('Will Back Soon');
    }
    return _response(response!);
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        debugPrint(response.body);
        return responseJson;
      case 400:
        debugPrint(response.statusCode.toString());
        debugPrint(response.body.toString());
        return BadRequestException(response.body);
      case 401:
        debugPrint(response.statusCode.toString());
        debugPrint(response.body.toString());
        throw UnauthorisedException(response.body);
      case 403:
        debugPrint(response.statusCode.toString());
        debugPrint(response.body.toString());
        throw UnauthorisedException(response.body);
      case 404:
        debugPrint(response.statusCode.toString());
        debugPrint(response.body.toString());
        var responseJson = json.decode(response.body);
        return responseJson;
      case 405:
        debugPrint(response.statusCode.toString());
        debugPrint(response.body.toString());
        throw UnauthorisedException(response.body);
      case 422:
      case 500:
        debugPrint(response.statusCode.toString());
        debugPrint(response.body.toString());

        Navigator.pushAndRemoveUntil(
            NavigationService.navigatorKey.currentContext!,
            MaterialPageRoute(builder: (context) => SchoolCodeScreen()),
            (route) => false);

        return UnauthorisedException(response.body);
      default:
        var responseJson = json.decode(response.body.toString());
        throw FetchDataException(
            'Error : ${response.statusCode}\n$responseJson');
    }
  }
}
