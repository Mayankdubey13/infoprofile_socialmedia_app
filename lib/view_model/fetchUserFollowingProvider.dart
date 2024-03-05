import 'package:demo_project/models/fetchUserFollowiing.dart';
import 'package:demo_project/respository/follow_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../respository/auth_respository.dart';

class FetchUserFollowingProvider extends ChangeNotifier{
  FollowRepo followRepo = FollowRepo();
  Future<FetchUserFollowing> getFollowingApi(String userId) async {
    FetchUserFollowing ? user;
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");
    // String ?userId = sp.getString("userId");
    print("$token      ----=----------,");
    final response = await followRepo.getFolloweringApi(userId.toString(),token.toString());
    print("------------------------------------$response");
    //   debugPrint(response["data"]["post"][0]["name"]);
    try {
      user = FetchUserFollowing.fromJson(response);
      // debugPrint("------------->${user.data.posts[0].user.name}");
      // return response;
    }
    catch(e){
      print("===========$e");
    }
    return user!;
  }
}
