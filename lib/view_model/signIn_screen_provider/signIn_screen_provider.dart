import 'package:demo_project/utils/routes/routes_name.dart';
import 'package:demo_project/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../respository/auth_respository.dart';
import '../../utils/utils.dart';

class SignInScreenProvider extends ChangeNotifier{

  final _myRepo = AuthRespository();
  bool _loading = false;
  bool get loading =>_loading;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  FocusNode emailFocus = FocusNode();

  FocusNode passwordFocus = FocusNode();
  FocusNode buttonFocusNode = FocusNode();
  bool _obs =true;
  bool get obs =>_obs;

   setObs(){
     _obs = ! _obs;
     notifyListeners();
   }

  void setLoading (bool element){
    _loading=element;
    notifyListeners();
  }
  Future<void> loginApi(dynamic data,BuildContext context) async{
    debugPrint(data["email"]);
    debugPrint(data["password"]);
    _myRepo.loginApi(data).then((value) {
      debugPrint("Response login: $value");
      Utils.toastMessage("Sucessfull");
      Map<String, dynamic> user =  {
         "userId":value["data"]["userId"],
        "token": value["data"]["token"],
        "name": value["data"]["user"]["name"],
      "userName":value["data"]["user"]["userName"],
        "email":value["data"]["user"]["email"],
      };
               print("$user");
      UserViewModel().saveUser(UserModel.fromJson(user));
      setLoading(false);
      print(">>>>>>>>>>>>>>>>>>!!!!!>>>>>>Suceesssssssssss naviagte");

      Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (_) => false);
      emailController.clear();
      passwordController.clear();

    }).onError((error, stackTrace){
      print("+*******************===>>>>>>>>>>>>>$error");
      setLoading(false);
      if(kDebugMode) {
        Utils.toastMessage(error.toString());
        print(error.toString());

      }
    });

  }

}