import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class UserViewModel extends ChangeNotifier{


   Future<bool> saveUser(UserModel user) async{
     final SharedPreferences sp = await SharedPreferences.getInstance();
     sp.setString("token", user.token);
     sp.setString("userId", user.userId);
     sp.setString("name", user.name);
     sp.setString("userName", user.userName);
     sp.setString("email", user.email);
     sp.setString("displayPicture", user.displayPicture);
     return true ;
   }

    Future<String> getToken() async{
      final SharedPreferences sp = await SharedPreferences.getInstance();
      String? token = sp.getString("token");
      return token!;
    }
   Future<String> getUserId() async{
     final SharedPreferences sp = await SharedPreferences.getInstance();
     String ?userId = sp.getString("userId");
     return userId!;
   }
   Future<String> getName() async{
     final SharedPreferences sp = await SharedPreferences.getInstance();
     String ?name = sp.getString("name");
     print("^^^^^^^^^^^^^^^^^^______$name");
     return name!;
   }
   Future<String> getUserName() async{
     final SharedPreferences sp = await SharedPreferences.getInstance();
     String ?userName = sp.getString("userName");
     print("^^^^^^^^^^^^^^^^^^______$userName");
     return userName!;
   }
   Future<String> getEmail() async{
     final SharedPreferences sp = await SharedPreferences.getInstance();
     String ?email = sp.getString("email");
     return email!;
   }
   Future<UserModel> getUser() async{

     final SharedPreferences sp = await SharedPreferences.getInstance();
     String? token = sp.getString("token");
     String ?userId = sp.getString("userId");
     String ?name = sp.getString("name");
     String ?userName = sp.getString("userName");
     String ?email = sp.getString("email");
     String ?displayPicture=sp.getString("displayPicture");

     return UserModel(userId: userId.toString(), token: token.toString(), name: name.toString(), userName: userName.toString(), email: email.toString(), displayPicture:displayPicture.toString() );
   }

   Future<bool> removeUser() async{
     final SharedPreferences sp = await SharedPreferences.getInstance();
     return sp.clear();
   }
}