import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../respository/auth_respository.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';

class ForgetScreenProvider extends ChangeNotifier{

  final _myRepo = AuthRespository();

  TextEditingController emailController = TextEditingController();
  FocusNode  emailFocus= FocusNode();
  FocusNode buttonFocusNode = FocusNode();
  bool _Loading = false;
  bool get Loading =>_Loading;
  void setLoading (bool element){
    _Loading=element;
    notifyListeners();
  }
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController ConformNewPasswordController = TextEditingController();
  FocusNode  newPasswordFocus= FocusNode();
  FocusNode  newConformPasswordFocus= FocusNode();
  bool _obs =true;
  bool get obs =>_obs;
  setObs(){
    _obs = ! _obs;
    notifyListeners();
  }
  @override
  void dispose() {
    // TODO: implement dispose

    emailController.dispose();
    newPasswordController.dispose();
    newConformPasswordFocus.dispose();
  }
  bool _obs1 =true;
  bool get obs1 =>_obs1;
  setObs1(){
    _obs1 = ! _obs1;
    notifyListeners();
  }


  Future<void> forgotPasswordApi(dynamic data,BuildContext context) async{
    debugPrint(data["email"]);
    debugPrint(data["password"]);
    _myRepo.forgetPasswordApi(data).then((value) {
      debugPrint("Response login: $value");
      Utils.toastMessage("Sucessfull");
      //UserViewModel().saveUser(value['data'].toString());
      setLoading(false);
      Navigator.pushNamed(context, RoutesName.forgotPasswordOtpAuthenticationScreen, arguments: {'email':emailController.text.toString().trim()});
    }).onError((error, stackTrace){
      print("+*******************===>>>>>>>>>>>>>$error");
      setLoading(false);
      if(kDebugMode) {
        Utils.toastMessage(error.toString());
        print(error.toString());

      }
    });

  }
  Future<void> otpAuthenticationApi(dynamic data,BuildContext context) async{
    debugPrint(data["email"]);
    debugPrint(data["password"]);
    _myRepo.otpAuthenticationApi(data).then((value) {
      String token = value["data"];
      debugPrint(token);
      //debugPrint("Response login: $value");
      Utils.toastMessage("Sucessfull");
     // UserViewModel().saveUser(value['data'].toString());
      setLoading(false);
      Navigator.pushNamed(context, RoutesName.forgotEnterNewPassword,arguments: {
        "token":token
      });

    }).onError((error, stackTrace){
      print("+*******************===>>>>>>>>>>>>>$error");
      setLoading(false);
      if(kDebugMode) {
        Utils.toastMessage(error.toString());
        print(error.toString());

      }
    });

  }

  Future<void> forgotEnterNewPassword(dynamic data,String token,BuildContext context) async{
    //setSignUpLoading(true);
    debugPrint("Data is $data");
    _myRepo.forgotEnterNewPassword(data,token).then((value) {
     setLoading(false);
      debugPrint("SignUp Successfull $value");
      Navigator.pushNamed( context, RoutesName.signInScreen, );

    }).onError((error, stackTrace){
      setLoading(false);
      if(kDebugMode) {
        Utils.toastMessage(error.toString());
      //  print( "Error occur in api call in SignUpScreen Provider$error");
      }
    });
  }


}