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

class CommentRepo{

  final BaseApiServices _apiServices = NetworkApiServices();
  final NotificationRepo _notificationRepo = NotificationRepo();

  Map<String, String> header = {
    ApiKeys.authorization: "Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==",
    ApiKeys.accept: ApiKeys.applicationJson,
  };

  Future<dynamic> addPostCommentApi(String postId,dynamic data,String token, String postedById) async{

    dynamic response;
    try {
      response = await _apiServices.postAPIWithHeader('https://premsocial.appskeeper.in/v1/post/comment?postId=$postId', data:jsonEncode(data), header: header);
      debugPrint("add post api response $response");
    }
    catch(e){
      rethrow;
    }
    await _notificationRepo.addPushNotification(postedById, postId, "comment");
    return response;
  }
  Future<dynamic> deleteCommentApi(dynamic params ,String token ) async{
    try{
      dynamic response = await _apiServices.getDeleteApiResponseHeader('https://premsocial.appskeeper.in/v1/post/comment?commentId=$params',header);
      print("my auth_respoitry respnse :-$response");
      return response ;

    }
    catch(e){
      rethrow;
    }
  }

  Future<dynamic> editCommentApi(dynamic data,String commentId,String token) async{
    try {
      dynamic response = await _apiServices.getPatchApiResponseHeader(
          "https://premsocial.appskeeper.in/v1/post/comment?commentId=$commentId", jsonEncode(data), header);
      debugPrint("Eost Edit Post Response $response");
      return response;
    }
    catch(e){
      rethrow;
    }
  }

  Future<dynamic> getCommentApi(dynamic params ,String token ) async{
    try{
      //  final Uri uri = Uri.parse(AppUrl.getProfile).replace(queryParameters: params);
      dynamic response = await _apiServices.getGetApiResponseWithHeader('https://premsocial.appskeeper.in/v1/post/comments?postId=$params',header);
      // print("my auth_respoitry respnse :-$response");
      return response ;

    }
    catch(e){
      rethrow;
    }
  }

}