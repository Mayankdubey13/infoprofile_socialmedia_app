import 'package:demo_project/models/userProfile_model.dart';
import 'package:demo_project/respository/profile_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../respository/auth_respository.dart';

class MyProfileScreenProvider extends ChangeNotifier{

  ProfileRepo profileRepo = ProfileRepo();
  final repo = AuthRespository();
  static UserProfile ? user;
   Future<UserProfile?> userProfile() async {
     if(user != null) return user;
     final SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");
    String ?userId = sp.getString("userId");
    debugPrint("$token      ,,  $userId");
     final response = await profileRepo.getProfileApi(userId.toString(),token.toString());
     debugPrint("------------------------------------$response");
        debugPrint(response["data"]["profile"]["name"]);
        try {
          user = UserProfile.fromJson(response!);
          debugPrint("------------->${user!.data.profile.name}");
          // return response;
        }
        catch(e){
          debugPrint("===========$e");
        }
     return user;
  }
}