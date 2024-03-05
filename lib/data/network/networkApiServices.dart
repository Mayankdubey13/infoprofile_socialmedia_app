import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../res/app_string.dart';
import '../response/api_exceptions.dart';
import 'baseApiServices.dart';

class NetworkApiServices extends BaseApiServices {
  @override

  Future getGetApiResponse(String url) async {
    http.Response res;
    try {
      res = await http.get(Uri.parse(url));
      debugPrint("Response is Successfully returning");
      return returnResponse(res);
    } on SocketException {
      throw InternetException(AppString.noNetwork);
    } on RequestTimeOut {
      throw RequestTimeOut(AppString.takingMoreTime);
    }
  }
  @override

  Future getGetApiResponseWithHeader(String url,dynamic header) async {
    http.Response res;
    try {
      res = await http.get(Uri.parse(url), headers : header);
      debugPrint("Response is Successfully returning");
      return returnResponse(res);
    } on SocketException {
      throw InternetException(AppString.noNetwork);
    } on RequestTimeOut {
      throw RequestTimeOut(AppString.takingMoreTime);
    }
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJSON;
    try {
      debugPrint("--------------- post api ----------");
      debugPrint(data.toString());
      final response = await http
          .post(Uri.parse(url), body: data,)
          .timeout(const Duration(seconds: 10));
      responseJSON = returnResponse(response);
      debugPrint("status code :"+response.statusCode.toString());
    } on SocketException{
      throw FetchDataException("No Internet");
    }

    debugPrint("jsonResponse : "+responseJSON.toString());

    return responseJSON;
  }

  @override
   Future<dynamic> postAPIWithHeader(String url, {dynamic data, dynamic header}) async {
    dynamic responseJSON;
    try {
      final response = await http
          .post(Uri.parse(url), body: data, headers: header)
          .timeout(const Duration(seconds: 10));
      responseJSON = returnResponse(response);
      debugPrint("jsonResponse"+responseJSON.toString());
      // debugPrint("status code :"+response.statusCode.toString());
    } on SocketException{
      throw FetchDataException("No Internet");
    }
    return responseJSON;
  }

  @override
  Future getPatchApiResponseHeader ( String url, dynamic data,  dynamic header) async {
    dynamic responseJson;
    try {
      final response = await
      patch(Uri.parse(url), body: data, headers: header)
          .timeout(const Duration(seconds: 10));

      debugPrint("API Call Success****** ${response.statusCode}");
      responseJson = returnResponse(response);
      debugPrint("API Call Success $responseJson");
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future getDeleteApiResponseHeader ( String url,dynamic header) async {
    dynamic responseJson;
    try {
      final response = await
     delete(Uri.parse(url), headers: header)
          .timeout(const Duration(seconds: 10));

      debugPrint("API Call Success****** ${response.statusCode}");
      responseJson = returnResponse(response);
      debugPrint("API Call Success $responseJson");
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    debugPrint("status code :"+response.statusCode.toString());
    debugPrint("status code :"+response.body.toString());

    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw InvalidUrl(jsonDecode(response.body)['message']);
      case 500:
        throw InternalServerException(jsonDecode(response.body)['message']);
      default:
        throw FetchDataException(jsonDecode(response.body)['message']);
    }
  }

}