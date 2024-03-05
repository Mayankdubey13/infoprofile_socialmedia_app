import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';

class AppPreferences {
  static SharedPreferences? sp;
  static late AppPreferences _preferences;

  AppPreferences._internal(){
    init();
  }

  factory AppPreferences(){
    _preferences = AppPreferences._internal();
    return _preferences;
  }

  static init() async {
    sp ??= await SharedPreferences.getInstance();
  }

  static Future<bool> saveUser(UserModel user) async{
    init();
    sp!.setString("token", user.token);
    sp!.setString("userId", user.userId);
    sp!.setString("name", user.name);
    sp!.setString("userName", user.userName);
    sp!.setString("email", user.email);
    sp!.setString("displayPicture", user.displayPicture);
    return true ;
  }

  static Future<String> getToken() async{
    init();
    String? token = sp!.getString("token");
    return token!;
  }

  static Future<String> getUserId() async{
    init();
    String ?userId = sp!.getString("userId");
    return userId!;
  }

  static Future<String> getName() async{
    init();
    String ?name = sp!.getString("name");
    print("^^^^^^^^^^^^^^^^^^______$name");
    return name!;
  }

  static Future<String> getUserName() async{
    init();
    String ?userName = sp!.getString("userName");
    print("^^^^^^^^^^^^^^^^^^______$userName");
    return userName!;
  }

  static Future<String> getEmail() async{
    init();
    String ?email = sp!.getString("email");
    return email!;
  }
  static Future<String> displayPicture() async{
    init();
    String? displayPicture = sp!.getString("displayPicture");
    return displayPicture!;
  }
  static Future<UserModel> getUser() async{

    init();
    String? token = sp!.getString("token");
    String ?userId = sp!.getString("userId");
    String ?name = sp!.getString("name");
    String ?userName = sp!.getString("userName");
    String ?email = sp!.getString("email");
    String ?displayPicture = sp!.getString("displayPicture");

    return UserModel(userId: userId.toString(), token: token.toString(), name: name.toString(), userName: userName.toString(), email: email.toString(), displayPicture: displayPicture.toString());
  }

  static Future<bool> removeUser() async{
    init();
    return sp!.clear();
  }
}