import 'package:demo_project/models/userParticularPostResponse.dart';
import 'package:demo_project/models/userProfile_model.dart';
import 'package:demo_project/respository/post_repo.dart';
import 'package:demo_project/respository/profile_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/feedProfile.dart';
import '../../../respository/auth_respository.dart';
import '../../../respository/like_repo.dart';
import '../../../utils/utils.dart';

class   MyHomeScreenProvider extends ChangeNotifier{
  LikeRepo likeRepo = LikeRepo();
  PostRepo postRepo = PostRepo();
  ProfileRepo profileRepo = ProfileRepo();
  TextEditingController editingController = TextEditingController();
  static FeedProfile? user;
  Future<FeedProfile> getParticularPostApi() async {
    if(user != null) return user!;
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");
    // String ?userId = sp.getString("userId");
    print("$token      ----=----------,");
    final response = await profileRepo.getProfileFeedApi(token.toString());
    print("------------------------------------$response");
  //  debugPrint(response["data"]["post"][0]["name"]);
    try {
      user =  FeedProfile.fromJson(response!);
    //  debugPrint("------------->${user.data.posts[0].user.name}");
      // return response;
    }
    catch(e){
      print("===========$e");
    }
    // notifyListeners();
    return user!;
  }

  Future<void> likePostApi(dynamic postId, BuildContext context,String userIdPostLike, int index) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");

    user!.feed[index].numberOfLikes += 1;
    user!.feed[index].liked = 1;
    notifyListeners();

    try {
      await likeRepo.likePostApi(postId.toString(), token.toString(),userIdPostLike);
     // notifyListeners();
      // If the API call is successful, update the state
      // setIsLike();
    } catch (error) {
      // Handle the error, e.g., show a toast or log it
      Utils.toastMessage(error.toString());
      print(error.toString());
    }
  }

  Future<void> unLikePostApi(dynamic postId, BuildContext context, int index) async {

    user!.feed[index].numberOfLikes -= 1;
    user!.feed[index].liked = 0;
    notifyListeners();

    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");

    try {
      await likeRepo.unLikePostApi(postId.toString(), token.toString());
          //notifyListeners();
      // If the API call is successful, update the state
      //  setIsLike();
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