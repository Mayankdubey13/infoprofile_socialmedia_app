import 'package:demo_project/data/network/baseApiServices.dart';
import 'package:demo_project/data/network/networkApiServices.dart';
import 'package:demo_project/res/app_url.dart';
import 'package:demo_project/utils/_app_helper/app_prefrences.dart';
import 'package:flutter/cupertino.dart';
import '../../models/search_response_model.dart';

class SearchUserRepository {

  final BaseApiServices _apiServices = NetworkApiServices();
  Map<String, String> header = {
    "Authorization": "token",
    "Content-Type": "application/json",
  };
  Future<ApiResponseUserData?> searchUser({required String username}) async {
    ApiResponseUserData? res;
    String? token = await AppPreferences.getToken();
    header['Authorization'] = token;
    await _apiServices.getGetApiResponseWithHeader(AppUrl.searchUserEndPoint+username, header).then((value){
      debugPrint("Search response is $value");
      try{
        res = ApiResponseUserData.fromJson(value);
      }
      catch (e){
        debugPrint("Error in conversion$e");
      }
    }).onError((error, stackTrace){
      debugPrint("Search response error: $error");
    });
    debugPrint("Returning response ${res!.data[0].userName}");
    return res;
  }
}