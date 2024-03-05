import 'package:demo_project/res/app_colors.dart';
import 'package:demo_project/res/app_string.dart';
import 'package:demo_project/utils/routes/routes_name.dart';
import 'package:demo_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TutorialScreen extends StatefulWidget{
  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  int pos = 0;
  PageController pageController =PageController(initialPage: 0, keepPage: false, viewportFraction: 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  PageView(
        onPageChanged: (index) {
          pos = index;
          setState(() {
          });
        },
        controller: pageController,
        pageSnapping: true,
        reverse: false,
        allowImplicitScrolling: true,
        physics: const ClampingScrollPhysics(),
        children: [

          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColor.bodyBackgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0,left: 20,bottom: 70,top: 40),
              child: Column(

                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8,right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end
                      , children: [
                      Utils.textButton(onPressed: (){
                        pageController.animateToPage(pos+3, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                      }, buttonText: "Skip",elevation: 8.0,),
                    ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Center(child: LottieBuilder.asset("assets/lottie/tutorialScreen1.json")),
                        SizedBox(height: MediaQuery.of(context).size.height*0.1),
                        Text(
                          AppString.tutorialScreen1Text,style: TextStyle(fontSize: 16,color: AppColor.fontTextColor),textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  Utils.textButton(onPressed: (){
                    pageController.animateToPage(++pos, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                  }, buttonText: AppString.tutorialButtonText,elevation: 8),
                  // InkWell(
                  //   onTap: (){
                  //     // pos = 0;
                  //     pageController.animateToPage(pos++, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                  //   },
                  //   child: Container(
                  //       height: 40,
                  //       width: double.infinity,
                  //     decoration: BoxDecoration(
                  //       border:Border.all(width: 1,
                  //       color: AppColor.fadeBlack
                  //       )
                  //     ),
                  //     child: Center(child: Text(AppString.tutorialButtonText, style: TextStyle(color: AppColor.titorialScreenbuttonTextColor,fontSize: 16),)),
                  //
                  //   ),
                  // ),
                  // SizedBox(height: 30,)
                ],
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColor.bodyBackgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0,left: 20,bottom: 70,top :40),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end
                      , children: [
                      Utils.textButton(onPressed: (){
                        pageController.animateToPage(pos+2, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                      }, buttonText: "Skip",elevation: 8.0,),
                    ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: LottieBuilder.asset("assets/lottie/splashScreen.json",)),
                        SizedBox(height: MediaQuery.of(context).size.height*0.1),
                        Text(
                          AppString.tutorialScreen2Text,style: TextStyle(fontSize: 16,color: AppColor.fontTextColor),textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  // InkWell(
                  //   onTap: (){
                  //     // pos = 1;
                      // pageController.animateToPage(++pos, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                  //   },
                  //   child: Container(
                  //     height: 40,
                  //     width: double.infinity,
                  //     decoration: BoxDecoration(
                  //         border:Border.all(width: 1,
                  //             color: AppColor.fadeBlack
                  //         )
                  //     ),child: Center(child: Text(AppString.tutorial2ButtonText,style: TextStyle(fontSize: 16,color: AppColor.titorialScreenbuttonTextColor),)),
                  //
                  //
                  //   ),
                  // ),
                  Utils.textButton(onPressed: (){
                    pageController.animateToPage(++pos, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                  }, buttonText: AppString.tutorial2ButtonText,elevation: 8),
                 // SizedBox(height: 15,)
                ],
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColor.bodyBackgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0,left: 20,bottom: 70,top: 40),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end
                      , children: [
                      Utils.textButton(onPressed: (){
                        pageController.animateToPage(pos+1, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                      }, buttonText: "Skip",elevation: 8.0,),
                    ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: LottieBuilder.asset("assets/lottie/tutorialScreen1.json",)),
                        SizedBox(height: MediaQuery.of(context).size.height*0.1),
                        Text(
                          AppString.tutorialScreen3Text,style: TextStyle(fontSize: 16,color: AppColor.fontTextColor),textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  // InkWell(
                  //   onTap: (){
                  //     pageController.animateToPage(++pos, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                  //   },
                  //   child: Container(
                  //     height: 40,
                  //     width: double.infinity,
                  //     decoration: BoxDecoration(
                  //         border:Border.all(width: 1,
                  //             color: AppColor.fadeBlack
                  //         )
                  //     ),
                  //     child: Center(child: Text(AppString.tutorial3ButtonText,style: TextStyle(color: AppColor.titorialScreenbuttonTextColor,fontSize: 16),)),
                  //
                  //   ),
                  // ),
                  // SizedBox(height: 30,)
                  Utils.textButton(onPressed: (){
                    pageController.animateToPage(++pos, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                  }, buttonText: AppString.tutorial3ButtonText,elevation: 8),
                ],
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColor.bodyBackgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0,left: 20,bottom: 70),
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LottieBuilder.asset("assets/lottie/welcome.json",),
                          SizedBox(height: 50,),
                          Text(
                            AppString.tutorialScreen4Text1,style: TextStyle(fontSize: 25,color: AppColor.fontTextColor,fontWeight: FontWeight.w600),textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 15,),
                          Text(
                            AppString.tutorialScreen4Text2,style: TextStyle(fontSize: 16,color: AppColor.fontTextColor),textAlign: TextAlign.center,
                          ),

                        ],
                      ),
                    ),
                    Container(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Utils.textButton(onPressed: (){
                            Navigator.pushNamedAndRemoveUntil(context, RoutesName.signInScreen, (route) => false);
                          }, buttonText: AppString.tutorial4buttonText1,elevation: 8),
                          SizedBox(width: 15,),
                          Utils.textButton(onPressed: (){
                            Navigator.pushNamedAndRemoveUntil(context, RoutesName.signUpScreen, (route) => false);
                          }, buttonText: AppString.tutorial4buttonText2,elevation: 8),
                        ],
                      ),
                    ),

                  ],
                ),

              ),
            ),
          ),

        ],
      ),
    );
  }
}