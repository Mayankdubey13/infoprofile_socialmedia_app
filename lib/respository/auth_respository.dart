import 'dart:convert';
import 'package:demo_project/utils/_app_helper/app_prefrences.dart';
import 'package:flutter/cupertino.dart';
import '../data/network/baseApiServices.dart';
import '../data/network/networkApiServices.dart';
import '../res/app_url.dart';
import 'notification_repo.dart';

class AuthRespository
{
  final BaseApiServices _apiServices = NetworkApiServices();
  final NotificationRepo _notificationRepo = NotificationRepo();


  Future<dynamic> loginApi(dynamic data) async{
    try {
      var response = await _apiServices.getPostApiResponse(
          AppUrl.loginEndPoint, data,);
      debugPrint("This is response of login $response");
      return response;
    }
    catch(e){
      print("CATCHINGGGGGGGGGGGGGG: $e");
      rethrow;
    }
  }
  Future<dynamic> forgetPasswordApi(dynamic data) async{
    try {
      var response = await _apiServices.getPostApiResponse(
        AppUrl.forgotPasswordEndPoint, data,);
      debugPrint("This is response of login $response");
      return response;
    }
    catch(e){
      print("CATCHINGGGGGGGGGGGGGG: $e");
      rethrow;
    }
  }

  Future<dynamic> otpAuthenticationApi(dynamic data) async{
    try {
      var response = await _apiServices.getPostApiResponse(
        AppUrl.forgotOtpAuthentication, data,);
      debugPrint("This is response of login $response");
      return response;
    }
    catch(e){
      print("CATCHINGGGGGGGGGGGGGG: $e");
      rethrow;
    }
  }

  Future<dynamic> forgotEnterNewPassword(dynamic data,String token) async{

    try {
      Map<String, String> header =  {
        "Authorization": "$token",
        "Content-Type":  "application/json",
      };
      dynamic response = await _apiServices.getPatchApiResponseHeader(
          AppUrl.updatePassword, jsonEncode(data), header);
      debugPrint("Signup api response $response");
      return response;
    }
    catch(e){
      rethrow;
    }
  }

  Future<dynamic> SignUpApi(dynamic data) async {

    try {
      Map<String, String> header =  {
        "Authorization": "Basic YWRtaW46YWRtaW4=",
        "Content-Type": "application/json",
      };
      dynamic response = await _apiServices.postAPIWithHeader(
          AppUrl.registerEndPont1,data:jsonEncode(data),header: header);
      debugPrint("Signup api response $response");
      return response;
    }
    catch(e){
      rethrow;
    }
  }

  Future<dynamic> SignUpApiAuth(Map<String, dynamic> data) async{
    debugPrint("==========$data.toString()");
    try {
      Map<String, String> header =  {
        "Authorization": "Basic YWRtaW46YWRtaW4=",
        "Content-Type": "application/json",
      };
      dynamic response = await _apiServices.postAPIWithHeader(
          AppUrl.registerEndPont2, data:jsonEncode(data),header: header  );
      debugPrint("=====================$response");
      return response;
    }
    catch(e){

      debugPrint("Error occur $e");
      rethrow;
    }
  }

  Future<dynamic> getUserDetailApi() async{
    try{

      dynamic response = await _apiServices.getGetApiResponse(AppUrl.getUserDeatils);
      return response ;

    }
    catch(e){
      rethrow;
    }
  }





}