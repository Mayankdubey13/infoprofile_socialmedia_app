import 'package:demo_project/models/fetchUserFollower.dart';
import 'package:demo_project/respository/follow_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../respository/auth_respository.dart';

class FetchUserFollowerProvider extends ChangeNotifier{
  final _myRepo = AuthRespository();
  FollowRepo followRepo = FollowRepo();
  Future<FetchUserFollower> getFollowerApi(String userId) async {
    FetchUserFollower ? user;
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");
    // String ?userId = sp.getString("userId");
    print("$token      ----=----------,");
    final response = await followRepo.getFollowerApi(userId.toString(),token.toString());
    print("------------------------------------$response");
    //   debugPrint(response["data"]["post"][0]["name"]);
    try {
      user = FetchUserFollower.fromJson(response);
      // debugPrint("------------->${user.data.posts[0].user.name}");
      // return response;
    }
    catch(e){
      print("===========$e");
    }
    return user!;
  }
}