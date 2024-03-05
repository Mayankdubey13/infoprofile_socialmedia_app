import 'package:demo_project/models/fetchPostLike.dart';
import 'package:demo_project/models/userParticularPostResponse.dart';
import 'package:demo_project/respository/like_repo.dart';
import 'package:demo_project/respository/post_repo.dart';
import 'package:demo_project/utils/_app_helper/app_prefrences.dart';
import 'package:demo_project/utils/routes/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../respository/auth_respository.dart';
import '../../../utils/utils.dart';
import '../../user_view_model.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyParticularPostViewProvider extends ChangeNotifier {
  final _myRepo = AuthRespository();
  LikeRepo likeRepo = LikeRepo();
  PostRepo postRepo = PostRepo();
  String? name;
  bool _isLikingOrUnliking = false;
  TextEditingController editingController = TextEditingController();
  bool get isLikingOrUnliking => _isLikingOrUnliking;

  void setLikingOrUnliking(bool value) {
    _isLikingOrUnliking = value;
    notifyListeners();
  }

  bool isLike = false;

  void setIsLike() {
    isLike = !isLike;
    notifyListeners();
  }

  Future<void> likePostApi(dynamic postId, BuildContext context,String userIdPostLike) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");

    try {
      await likeRepo.likePostApi(postId.toString(), token.toString(),userIdPostLike);
      // If the API call is successful, update the state
     // setIsLike();
    } catch (error) {
      // Handle the error, e.g., show a toast or log it
      Utils.toastMessage(error.toString());
      print(error.toString());
    }
  }

  Future<void> unLikePostApi(dynamic postId, BuildContext context) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");

    try {
      await likeRepo.unLikePostApi(postId.toString(), token.toString());
      // If the API call is successful, update the state
    //  setIsLike();
    } catch (error) {
      // Handle the error, e.g., show a toast or log it
      Utils.toastMessage(error.toString());
      print(error.toString());
    }
  }

  Future<String?> getUserName() async {
    try {
      name = await UserViewModel().getName();
      return name;
    } catch (error) {
      print("Error fetching username: $error");
      return null; // or return a default username
    }
  }

  Future<PostResponse> getParticularPostApi(String postId) async {
    PostResponse ? user;
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");
   // String ?userId = sp.getString("userId");
    print("$token      ----=----------,");
    final response = await postRepo.getParticularPostApi(postId.toString(),token.toString());
    print("------------------------------------$response");
    debugPrint(response["data"]["post"][0]["name"]);
    try {
      user = PostResponse.fromJson(response!);
      debugPrint("------------->${user.posts[0].user.name}");
      // return response;
    }
    catch(e){
      print("===========$e");
    }
    return user!;
  }

  Future<void> deletePostApi(dynamic postId, BuildContext context) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");

    try {
      await postRepo.deletePostApi( postId.toString(), token.toString());
      // If the API call is successful, update the state
      Utils.toastMessage("This post is delete Sucessful");
      Navigator.of(context).popUntil((route) => route.isFirst);
     // setIsLike();
    } catch (error) {
      // Handle the error, e.g., show a toast or log it
      Utils.toastMessage(error.toString());
      print(error.toString());
    }
  }

  Future<void> reportPostApi(dynamic postId, BuildContext context) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");

    try {
      await postRepo.reportPostApi(postId.toString(), token.toString());
      Utils.toastMessage("This post is report Sucessful");
      Navigator.of(context).popUntil((route) => route.isFirst);
      // If the API call is successful, update the state
      // setIsLike();
    } catch (error) {
      // Handle the error, e.g., show a toast or log it
      Utils.toastMessage(error.toString());
      print(error.toString());
    }
  }

 Future<String?> getUerId() async {
     String? postUserId = await AppPreferences.getUserId();
     return postUserId;
  }

  Future<void> editPostApi(String postId,BuildContext context) async{
    //setSignUpLoading(true);
    // debugPrint("Data is $data");
    Map<String,dynamic> data =
    {
      "caption": editingController.text.trim().toString()
    };
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");
    postRepo.editPostApi(data,postId,token.toString()).then((value) {
      //setLoading(false);
      editingController.clear();
      debugPrint("Edit post sucessfully");
      Utils.toastMessage("Edit post Sucessfully");
      Navigator.pop(context);
      // Navigator.of(context).popUntil((route) => route.isFirst);


    }).onError((error, stackTrace){
      // setLoading(false);
      if(kDebugMode) {
        Utils.toastMessage(error.toString());
        //  print( "Error occur in api call in SignUpScreen Provider$error");
      }
    });
  }


}


// 6537cfec1abf727a01300f76