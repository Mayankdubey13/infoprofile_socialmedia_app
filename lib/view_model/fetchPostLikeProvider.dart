import 'package:demo_project/models/fetchPostComment.dart';
import 'package:demo_project/respository/like_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/fetchPostLike.dart';
import '../respository/auth_respository.dart';

class FetchPostLikeProvider extends ChangeNotifier{
  final _myRepo = AuthRespository();
  LikeRepo likeRepo = LikeRepo();
  Future<FetchPostLike> getlikeApi(String postId) async {
    FetchPostLike ? user;
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");
    // String ?userId = sp.getString("userId");
    print("$token      ----=----------,");
    final response = await likeRepo.getlikeApi(postId.toString(),token.toString());
    print("------------------------------------$response");
    //   debugPrint(response["data"]["post"][0]["name"]);
    try {
      user = FetchPostLike.fromJson(response);
      // debugPrint("------------->${user.data.posts[0].user.name}");
      // return response;
    }
    catch(e){
      print("===========$e");
    }
    return user!;
  }
}