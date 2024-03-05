import 'package:demo_project/res/app_image_url.dart';
import 'package:demo_project/res/app_lottie_url.dart';
import 'package:demo_project/res/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import '../view_model/services/splash_services.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    super.initState();
    splashServices.checkAuthetication(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppImageUrl.appLogo),
                    SvgPicture.asset(AppImageUrl.appName),
                  ],
                    ),
              ),
            ],
          ),

          ),
      ),
   
    );
  }
}