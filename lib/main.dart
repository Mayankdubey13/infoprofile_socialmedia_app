import 'package:demo_project/utils/_app_helper/app_prefrences.dart';
import 'package:demo_project/utils/routes/routes.dart';
import 'package:demo_project/utils/routes/routes_name.dart';
import 'package:demo_project/view_model/fetchPostCommentProvider.dart';
import 'package:demo_project/view_model/fetchPostLikeProvider.dart';
import 'package:demo_project/view_model/fetchUserFolloweProvider.dart';
import 'package:demo_project/view_model/fetchUserFollowingProvider.dart';
import 'package:demo_project/view_model/home_screen_provider/home_screen_provider.dart';
import 'package:demo_project/view_model/home_screen_provider/myAddPost_screen_provider.dart';
import 'package:demo_project/view_model/home_screen_provider/myHome_screen_provider/like_post_provider.dart';
import 'package:demo_project/view_model/home_screen_provider/myHome_screen_provider/myHome_screen_provider.dart';
import 'package:demo_project/view_model/home_screen_provider/myHome_screen_provider/specificUserParticularPost_screen_provider.dart';
import 'package:demo_project/view_model/home_screen_provider/myHome_screen_provider/specificUser_screen_provider.dart';
import 'package:demo_project/view_model/home_screen_provider/myProfile_screen_provider/editProfileViewProvider.dart';
import 'package:demo_project/view_model/home_screen_provider/myProfile_screen_provider/myParticularPostView_provider.dart';
import 'package:demo_project/view_model/home_screen_provider/myProfile_screen_provider/myProfile_screen_provider.dart';
import 'package:demo_project/view_model/home_screen_provider/mySearchScreenProvider.dart';
import 'package:demo_project/view_model/home_screen_provider/notification_screen_provider.dart';
import 'package:demo_project/view_model/likeApiHit_Provider.dart';
import 'package:demo_project/view_model/signIn_screen_provider/forget_screen_provider.dart';
import 'package:demo_project/view_model/signIn_screen_provider/signIn_screen_provider.dart';
import 'package:demo_project/view_model/signUp_screen_provider/complete_profile_screen_provider.dart';
import 'package:demo_project/view_model/signUp_screen_provider/otp_authentication_screen_provider.dart';
import 'package:demo_project/view_model/signUp_screen_provider/signUp_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>SignInScreenProvider()),
      ChangeNotifierProvider(create: (_)=>SignUpScreenProvider()),
      ChangeNotifierProvider(create: (_)=>OtpAuthenticationScreenProvider()),
      ChangeNotifierProvider(create: (_)=>CompleteProfileScreenProvider()),
      ChangeNotifierProvider(create: (_)=>ForgetScreenProvider()),
      ChangeNotifierProvider(create: (_)=>HomeScreenProvider()),
      ChangeNotifierProvider(create: (_)=>LikePostProvider()),
      ChangeNotifierProvider(create: (_)=>MyParticularPostViewProvider()),
      ChangeNotifierProvider(create: (_)=>MyHomeScreenProvider()),
      ChangeNotifierProvider(create: (_)=>MyAddPostScreenProvider()),
      ChangeNotifierProvider(create: (_)=>MySearchScreenprovider()),
      ChangeNotifierProvider(create: (_)=>MyProfileScreenProvider()),
      ChangeNotifierProvider(create: (_)=>FetchPostLikeProvider()),
      ChangeNotifierProvider(create: (_)=>FetchPostCommentProvider()),
      ChangeNotifierProvider(create: (_)=>SpecificUserScreenProvider()),
      // ChangeNotifierProvider(create: (_)=>LikeApiHitProvider()),
      // ChangeNotifierProvider(create: (_)=>SpecificUserParticularPostScreenProvider()),
      ChangeNotifierProvider(create: (_)=>FetchUserFollowerProvider()),
      ChangeNotifierProvider(create: (_)=>FetchUserFollowingProvider()),
      ChangeNotifierProvider(create: (_)=>EditProfileViewProvider()),
      ChangeNotifierProvider(create: (_)=>NotificationScreenProvider()),

    ],
        child:MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,

        ),
        initialRoute: RoutesName.splashScreen,
        onGenerateRoute:Routes.generateRoute
        )
    );
    }

}
