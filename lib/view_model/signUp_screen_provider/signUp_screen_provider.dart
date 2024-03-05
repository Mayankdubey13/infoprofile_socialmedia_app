import 'package:demo_project/utils/routes/routes_name.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../respository/auth_respository.dart';
import '../../../utils/utils.dart';

class SignUpScreenProvider extends ChangeNotifier{
  final _myRepo = AuthRespository();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController conformPasswordController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode userNameFocus = FocusNode();
  FocusNode nameFocus = FocusNode();
  FocusNode conformPasswordFocus = FocusNode();
  FocusNode buttonFocusNode = FocusNode();
  bool _signUpLoading = false;
  bool get signUpLoading =>_signUpLoading;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    nameController.dispose();
    conformPasswordController.dispose();

  }
  void setSignUpLoading (bool element){
    _signUpLoading=element;
    notifyListeners();
  }
  bool _obs =true;
  bool get obs =>_obs;
  setObs(){
    _obs = ! _obs;
    notifyListeners();
  }
  bool _obs1 =true;
  bool get obs1 =>_obs1;
  setObs1(){
    _obs1 = ! _obs1;
    notifyListeners();
  }
  Future<void> signupApi(dynamic data,BuildContext context) async{
    //setSignUpLoading(true);
    debugPrint("Data is $data");
    _myRepo.SignUpApi(data).then((value) {
      setSignUpLoading(false);
      debugPrint("SignUp Successfull $value");
      Navigator.pushNamed( context, RoutesName.otpAuthenticationScreen, arguments: {'email': emailController.text.toString().trim()});
      emailController.clear();
      userNameController.clear();
      passwordController.clear();
      conformPasswordController.clear();
      nameController.clear();

    }).onError((error, stackTrace){
      setSignUpLoading(false);
      if(kDebugMode) {
        Utils.toastMessage(error.toString());
        print( "Error occur in api call in SignUpScreen Provider$error");
      }
    });
  }
}