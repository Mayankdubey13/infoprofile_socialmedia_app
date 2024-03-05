import 'dart:convert';
import 'package:demo_project/utils/_app_helper/app_prefrences.dart';
import 'package:flutter/cupertino.dart';

import '../data/network/baseApiServices.dart';
import '../data/network/networkApiServices.dart';
import '../data/response/api_exceptions.dart';
import '../models/fetchNotification.dart';
import '../res/app_url.dart';
import '../utils/_app_helper/api_key.dart';
import 'notification_repo.dart';

class ProfileRepo{

  final BaseApiServices _apiServices = NetworkApiServices();
  final NotificationRepo _notificationRepo = NotificationRepo();

  Map<String, String> header = {
    ApiKeys.authorization: "Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==",
    ApiKeys.accept: ApiKeys.applicationJson,
  };

  Future<dynamic> getProfileApi(dynamic params ,String token ) async{
    try{
      Map<String, String> header =  {
        "Authorization": token,
        "Content-Type": "application/json",
      };
      //  final Uri uri = Uri.parse(AppUrl.getProfile).replace(queryParameters: params);
      dynamic response = await _apiServices.getGetApiResponseWithHeader('https://premsocial.appskeeper.in/v1/profile/profile?profileId=$params',header);
      print("my auth_respoitry respnse :-$response");
      return response ;

    }
    catch(e){
      rethrow;
    }
  }


  Future<dynamic> getProfileFeedApi(String token ) async{
    try{
      Map<String, String> header =  {
        "Authorization": token,
        "Content-Type": "application/json",
      };
      //  final Uri uri = Uri.parse(AppUrl.getProfile).replace(queryParameters: params);
      dynamic response = await _apiServices.getGetApiResponseWithHeader('https://premsocial.appskeeper.in/v1/profile/feed',header);
      print("my auth_respoitry respnse :-$response");
      return response ;

    }
    catch(e){
      rethrow;
    }
  }



  Future<dynamic> editProfileApi(dynamic data) async{
    String? token = await AppPreferences.getToken();
    try {
      Map<String, String> header =  {
        "Authorization": "$token",
        "Content-Type":  "application/json",
      };
      dynamic response = await _apiServices.getPatchApiResponseHeader(
          "https://premsocial.appskeeper.in/v1/profile/profile", jsonEncode(data), header);
      debugPrint(" Edit Post Response $response");
      return response;
    }
    catch(e){
      rethrow;
    }
  }


}