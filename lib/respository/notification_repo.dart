import 'package:demo_project/utils/_app_helper/app_prefrences.dart';
import 'package:flutter/cupertino.dart';

import '../data/network/baseApiServices.dart';
import '../data/network/networkApiServices.dart';
import '../data/response/api_exceptions.dart';
import '../models/fetchNotification.dart';
import '../utils/_app_helper/api_key.dart';

class NotificationRepo {
  
  final BaseApiServices _baseAPIServices = NetworkApiServices();

  Map<String, String> header = {
    ApiKeys.authorization: "Basic c29jaWFsTWVkaWE6c29jaWFsQDEyMw==",
    ApiKeys.accept: ApiKeys.applicationJson,
  };

  Future<Map<String, dynamic>?> getAllNotification() async {
    Map<String, dynamic>? res;
    String? token = await AppPreferences.getToken();
    header[ApiKeys.authorization] = token;
    debugPrint(header.toString());
    await _baseAPIServices.getGetApiResponseWithHeader("https://premsocial.appskeeper.in/v1/user/notification-listing?page=1", header).then((value){
      // debugPrint("Notification received$value");
     res = value;
    }).onError((error, stackTrace){
      throw AppError("Error in getting notification response $error");
    });
   return res;
  }

  Future<void> addPushNotification(String receiverId, String activityId, String type) async {
    String? token = await AppPreferences.getToken();
    Map<String, String> headers = {
      ApiKeys.authorization : token,
      ApiKeys.accept : ApiKeys.applicationJson,
    };

    debugPrint("Receiver id is $receiverId and header is $headers");
    try {
      await _baseAPIServices.postAPIWithHeader("https://premsocial.appskeeper.in/v1/user/notification", data: { "recieverId": receiverId, "actionId": activityId, "type": type}, header: headers).then((value){
        debugPrint("Notification sent of type $value");
      }).onError((error, stackTrace){
        debugPrint("Error in sending notification $error");
      });
    } catch (error){
      debugPrint("Error in sending notification $error");
    }
  }

  Future<dynamic> deleteNotificationApi(dynamic notificationId ,String token ) async{
    try{
      Map<String, String> header =  {
        "Authorization": token,
        "Content-Type": "application/json",
      };
      //  final Uri uri = Uri.parse(AppUrl.getProfile).replace(queryParameters: params);
      dynamic response = await _baseAPIServices.getDeleteApiResponseHeader('https://premsocial.appskeeper.in/v1/user/notification?notificationId=$notificationId',header);
   //   print("my auth_respoitry respnse :-$response");
      return response ;

    }
    catch(e){
      rethrow;
    }
  }

}