
import 'package:demo_project/utils/routes/routes_name.dart';
import 'package:demo_project/view/home_screen/home_screen.dart';
import 'package:demo_project/view/SignIn_Screen/signIn_screen.dart';
import 'package:demo_project/view/home_screen/myAdd_post_screen/myAddPost_screen.dart';
import 'package:demo_project/view/home_screen/myHomeView/myHomeView.dart';
import 'package:demo_project/view/home_screen/myHomeView/specificUser_screen.dart';
import 'package:demo_project/view/home_screen/myProfileView/editProfileView.dart';
import 'package:demo_project/view/home_screen/myProfileView/myParticularPostView.dart';
import 'package:demo_project/view/home_screen/myProfileView/myProfileView.dart';
import 'package:demo_project/view/home_screen/mySearch_screen/mySearch_screen.dart';
import 'package:demo_project/view/home_screen/notification_screen.dart';
import 'package:demo_project/view/signIn_Screen/forgetPassword_screen/forgetPassword_otp_authentication_screen.dart';
import 'package:demo_project/view/signIn_Screen/forgetPassword_screen/forgetPassword_screen.dart';
import 'package:demo_project/view/signIn_Screen/forgetPassword_screen/forgot_enter_new_password.dart';
import 'package:demo_project/view/signUp_screen/complete_profile_screen.dart';
import 'package:demo_project/view/signUp_screen/otp_authentication_screen.dart';
import 'package:demo_project/view/signUp_screen/signUp_screen.dart';
import 'package:demo_project/view/splash_screen.dart';
import 'package:demo_project/view/tutorial_screen.dart';
import 'package:flutter/material.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){

    switch(settings.name){
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (BuildContext context)=>SplashScreen());
      case RoutesName.tutorialScreen:
        return MaterialPageRoute(builder: (BuildContext context)=>TutorialScreen());
      case RoutesName.signUpScreen:
        return MaterialPageRoute(builder: (BuildContext context)=>SignUpScreen());
      case RoutesName.signInScreen:
        return MaterialPageRoute(builder: (BuildContext context)=>SignInScreen());
      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context)=>HomeScreen());
      case RoutesName.otpAuthenticationScreen:
        Map<String, dynamic> mp = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (BuildContext context)=>OtpAuthenticationScreen(email: mp['email'],));
      case RoutesName.completeProfileScreen:
        return MaterialPageRoute(builder: (BuildContext context)=>CompleteProfileScreen());
      case RoutesName.forgetPasswordScreen:
        return MaterialPageRoute(builder: (BuildContext context)=>ForgetPasswordScreen());
      case RoutesName.forgotPasswordOtpAuthenticationScreen:
        Map<String,dynamic> mp = settings.arguments as Map<String,dynamic>;
        return MaterialPageRoute(builder: (BuildContext context)=>ForgetPasswordOtpAuthenticationScreen( email: mp["email"],));
      case RoutesName.forgotEnterNewPassword:
        Map<String,dynamic> mp = settings.arguments as Map<String,dynamic>;
        return MaterialPageRoute(builder: (BuildContext context)=>ForgotEnterNewPassword(token: mp["token"],));
      case RoutesName.myProfileScreen:
        return MaterialPageRoute(builder: (BuildContext context)=>MyProfileView());
      case RoutesName.myAddPostScreen:
        return MaterialPageRoute(builder: (BuildContext context)=>MyAddPostScreen());
      case RoutesName.mySearchScreen:
        return MaterialPageRoute(builder: (BuildContext context)=>MySearchScreen());
      case RoutesName.myHomeScreen:
        return MaterialPageRoute(builder: (BuildContext context)=>MyHomeView());
      case RoutesName.myParticularPostView:
        Map<String,dynamic> mp = settings.arguments as Map<String,dynamic>;
        return MaterialPageRoute(builder: (BuildContext context)=>MyParticularPostView( post: mp["post"],));
      case RoutesName.specificUserScreen:
        Map<String,dynamic> mp = settings.arguments as Map<String,dynamic>;
        return MaterialPageRoute(builder: (BuildContext context)=>SpecificUserScreen(userDeatils: mp["UserDetail"],));
      case RoutesName.specificUserParticularPostScreen:
        Map<String,dynamic> mp = settings.arguments as Map<String,dynamic>;
        return MaterialPageRoute(builder: (BuildContext context)=>SpecificUserScreen(userDeatils: mp["post"],));
      case RoutesName.editProfileScreen:
        return MaterialPageRoute(builder: (BuildContext context)=>EditProfileView());
      case RoutesName.notificationScreen:
        return MaterialPageRoute(builder: (BuildContext context)=>NotificationScreen());
      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text("No routes are there"),
            ),
          );
        });
    }

  }
}