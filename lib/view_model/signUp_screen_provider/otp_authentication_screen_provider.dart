import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:otp_text_field/otp_field.dart';

import '../../respository/auth_respository.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';

class OtpAuthenticationScreenProvider extends ChangeNotifier{

  final _myRepo = AuthRespository();
  OtpFieldController otpController = OtpFieldController();
  @override
  FocusNode otpFieldFocus = FocusNode();
  FocusNode buttonFocusNode = FocusNode();

  bool _Loading = false;
  bool get Loading =>_Loading;

  @override
  void setLoading (bool element){
    _Loading=element;
    notifyListeners();
  }

  Future<void> signupApi(dynamic data,BuildContext context) async{
   // setSignUpLoading(true);
    Map<String, dynamic> dat = data;
    _myRepo.SignUpApiAuth(dat).then((value) {
      Navigator.pushNamed( context, RoutesName.signInScreen);
      if(kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace){
     // setSignUpLoading(false);
      if(kDebugMode) {
        Utils.toastMessage(error.toString());
        print(error.toString());
      }
    });
  }
}