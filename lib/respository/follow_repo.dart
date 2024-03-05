import 'dart:convert';
import 'package:demo_project/utils/_app_helper/app_prefrences.dart';
import 'package:flutter/cupertino.dart';

import '../data/network/baseApiServices.dart';
import '../data/network/networkApiServices.dart';
import '../utils/_app_helper/api_key.dart';
import 'notification_repo.dart';


class FollowRepo{

  final BaseApiServices _apiServices = NetworkApiServices();
  final NotificationRepo _notificationRepo = NotificationRepo();

  Map<String, String> header = {
    ApiKeys.authorization: "Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==",
    ApiKeys.accept: ApiKeys.applicationJson,
  };
  Future<dynamic> getFollowerApi(dynamic params ,String token ) async{
    try{
      Map<String, String> header =  {
        "Authorization": token,
        "Content-Type": "application/json",
      };
      //  final Uri uri = Uri.parse(AppUrl.getProfile).replace(queryParameters: params);
      dynamic response = await _apiServices.getGetApiResponseWithHeader('https://premsocial.appskeeper.in/v1/profile/followers?userId=$params',header);
      print("my auth_respoitry respnse :-$response");
      return response ;

    }
    catch(e){
      rethrow;
    }
  }

  Future<dynamic> getFolloweringApi(dynamic params ,String token ) async{
    try{
      Map<String, String> header =  {
        "Authorization": token,
        "Content-Type": "application/json",
      };
      //  final Uri uri = Uri.parse(AppUrl.getProfile).replace(queryParameters: params);
      dynamic response = await _apiServices.getGetApiResponseWithHeader('https://premsocial.appskeeper.in/v1/profile/following?userId=$params',header);
      print("my auth_respoitry respnse :-$response");
      return response ;

    }
    catch(e){
      rethrow;
    }
  }
  Future<dynamic> followUserApi(dynamic params,String token) async{

    dynamic response;
    try {
      Map<String, String> header =  {
        "Authorization": token,
        "Content-Type": "application/json",
      };
      response = await _apiServices.postAPIWithHeader(
          'https://premsocial.appskeeper.in/v1/profile/follow?followingId=$params', header: header  );
      debugPrint("=====================$response");
    }
    catch(e){

      debugPrint("Error occur $e");
      rethrow;
    }
    await _notificationRepo.addPushNotification(params, params, "startedFollowing");
    return response;
  }

  Future<dynamic> unFollowUserApi(dynamic params ,String token ) async{
    try{
      Map<String, String> header =  {
        "Authorization": token,
        "Content-Type": "application/json",
      };
      //  final Uri uri = Uri.parse(AppUrl.getProfile).replace(queryParameters: params);
      dynamic response = await _apiServices.getDeleteApiResponseHeader('https://premsocial.appskeeper.in/v1/profile/unfollow?followingId=$params',header);
      print("my auth_respoitry respnse :-$response");
      return response ;

    }
    catch(e){
      rethrow;
    }
  }

}