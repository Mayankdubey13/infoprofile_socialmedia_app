
import 'package:demo_project/utils/routes/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../user_view_model.dart';


class SplashServices {

   final userView = UserViewModel();
  Future<UserModel> getUserData()=> userView.getUser();

  void checkAuthetication(BuildContext context) async{
    getUserData().then((value) async {
     // print(value.token.toString());
      if(value.token.toString()== "null" || value.token.toString()== "" || value.token.isEmpty){
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamedAndRemoveUntil(context, RoutesName.tutorialScreen, (_)=>false);
      }
      else
      {
         // Utils.toastMessage(value.token);
          await Future.delayed(const Duration(seconds: 3));
          Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (route) => false);
      }

    }).onError((error, stackTrace){
      if(kDebugMode){
        print(error.toString());
      }
    });
  }

}