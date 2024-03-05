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

class PostRepo{

  final BaseApiServices _apiServices = NetworkApiServices();
  final NotificationRepo _notificationRepo = NotificationRepo();

  Map<String, String> header = {
    ApiKeys.authorization: "Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==",
    ApiKeys.accept: ApiKeys.applicationJson,
  };

  Future<dynamic> addPostApi(dynamic data,String token) async{

    try {
      Map<String, String> header =  {
        "Authorization": "$token",
        "Content-Type":  "application/json",
      };
      debugPrint(AppUrl.addPost);
      dynamic response = await _apiServices.postAPIWithHeader(
          AppUrl.addPost, data:jsonEncode(data), header: header);
      debugPrint("add post  api response $response");
      return response;
    }
    catch(e){
      rethrow;
    }
  }

  Future<dynamic> getParticularPostApi(dynamic params ,String token ) async{
    try{
      Map<String, String> header =  {
        "Authorization": token,
        "Content-Type": "application/json",
      };
      //  final Uri uri = Uri.parse(AppUrl.getProfile).replace(queryParameters: params);
      dynamic response = await _apiServices.getGetApiResponseWithHeader('https://premsocial.appskeeper.in/v1/post/post?postId=$params',header);
      print("my auth_respoitry respnse :-$response");
      return response ;

    }
    catch(e){
      rethrow;
    }
  }

  Future<dynamic> getSpecificUserParticularPostApi(dynamic params ,String token ) async{
    try{
      Map<String, String> header =  {
        "Authorization": token,
        "Content-Type": "application/json",
      };
      //  final Uri uri = Uri.parse(AppUrl.getProfile).replace(queryParameters: params);
      dynamic response = await _apiServices.getGetApiResponseWithHeader('https://premsocial.appskeeper.in/v1/post/post?postId=$params',header);
      print("my auth_respoitry respnse :-$response");
      return response ;

    }
    catch(e){
      rethrow;
    }
  }
  Future<dynamic> deletePostApi(dynamic params ,String token ) async{
    try{
      Map<String, String> header =  {
        "Authorization": token,
        "Content-Type": "application/json",
      };
      //  final Uri uri = Uri.parse(AppUrl.getProfile).replace(queryParameters: params);
      dynamic response = await _apiServices.getDeleteApiResponseHeader('https://premsocial.appskeeper.in/v1/post/post?postId=$params',header);
      print("my auth_respoitry respnse :-$response");
      return response ;

    }
    catch(e){
      rethrow;
    }
  }


  Future<dynamic> editPostApi(dynamic data,String postId,String token) async{
    try {
      Map<String, String> header =  {
        "Authorization": "$token",
        "Content-Type":  "application/json",
      };
      dynamic response = await _apiServices.getPatchApiResponseHeader(
          "https://premsocial.appskeeper.in/v1/post/post?postId=$postId", jsonEncode(data), header);
      debugPrint(" Edit Post Response $response");
      return response;
    }
    catch(e){
      rethrow;
    }
  }


  Future<dynamic> reportPostApi(dynamic params,String token) async{

    try {
      Map<String, String> header =  {
        "Authorization": token,
        "Content-Type": "application/json",
      };
      dynamic response = await _apiServices.postAPIWithHeader(
          'https://premsocial.appskeeper.in/v1/post/report-post?postId=$params', header: header  );
      debugPrint("=====================$response");
      return response;
    }
    catch(e){

      debugPrint("Error occur $e");
      rethrow;
    }
  }


}