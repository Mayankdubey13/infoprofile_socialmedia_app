import 'package:demo_project/respository/follow_repo.dart';
import 'package:demo_project/respository/profile_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/userProfile_model.dart';
import '../../../respository/auth_respository.dart';
import '../../../utils/utils.dart';

class SpecificUserScreenProvider extends ChangeNotifier{

  FollowRepo followRepo = FollowRepo();
  ProfileRepo profileRepo = ProfileRepo();

  UserProfile? user;
  Future<UserProfile?> userProfile(String userId) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");
    await profileRepo.getProfileApi(userId.toString(),token.toString()).then((value){
      user = UserProfile.fromJson(value!);
    }).onError((error, stackTrace){});
    // notifyListeners();
    return user;
  }

  Future<void> followUserApi(dynamic followingId, BuildContext context) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");

    try {
      await followRepo.followUserApi(followingId, token.toString());
      Utils.toastMessage("Follow this user");
      // If the API call is successful, update the state
      // setIsLike();
    } catch (error) {
      // Handle the error, e.g., show a toast or log it
      Utils.toastMessage(error.toString());
      // await Future.delayed(const Duration(seconds: 2));
      // notifyListeners();
      // print(error.toString());
    }
  }

  Future<void> unFollowUserApi(dynamic followingId, BuildContext context) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");

    try {
      await followRepo.unFollowUserApi(followingId, token.toString());
      Utils.toastMessage("UnFollow this user");
      // If the API call is successful, update the state
      //  setIsLike();
    } catch (error) {
      // Handle the error, e.g., show a toast or log it
      Utils.toastMessage(error.toString());
      // await Future.delayed(const Duration(seconds: 2));
      // notifyListeners();
      // print(error.toString());
    }
  }
}