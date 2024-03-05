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

class LikeRepo{

  final BaseApiServices _apiServices = NetworkApiServices();
  final NotificationRepo _notificationRepo = NotificationRepo();

  Map<String, String> header = {
    ApiKeys.authorization: "Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==",
    ApiKeys.accept: ApiKeys.applicationJson,
  };
  Future<dynamic> likePostApi(dynamic params,String token,String userIdPostLike) async{
    dynamic response;
    try {
      response = await _apiServices.postAPIWithHeader(
          'https://premsocial.appskeeper.in/v1/post/like?postId=$params', header: header  );
      debugPrint("=====================$response");
    }
    catch(e){

      debugPrint("Error occur $e");
      rethrow;
    }
    await _notificationRepo.addPushNotification(userIdPostLike, params, "like");
    return response;
  }

  Future<dynamic> unLikePostApi(dynamic params,String token) async{

    try {
      dynamic response = await _apiServices.getDeleteApiResponseHeader(
          'https://premsocial.appskeeper.in/v1/post/like?postId=$params', header  );
      debugPrint("=====================$response");
      return response;
    }
    catch(e){

      debugPrint("Error occur $e");
      rethrow;
    }
  }

  Future<dynamic> getlikeApi(dynamic params ,String token ) async{
    try{

      //  final Uri uri = Uri.parse(AppUrl.getProfile).replace(queryParameters: params);
      dynamic response = await _apiServices.getGetApiResponseWithHeader('https://premsocial.appskeeper.in/v1/post/likes?postId=$params',header);
      // print("my auth_respoitry respnse :-$response");
      return response ;

    }
    catch(e){
      rethrow;
    }
  }


}