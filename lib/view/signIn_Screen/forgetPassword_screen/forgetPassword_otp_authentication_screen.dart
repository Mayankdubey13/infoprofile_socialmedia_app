
import 'package:demo_project/view_model/signIn_screen_provider/forget_screen_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_image_url.dart';
import '../../../res/app_string.dart';
import '../../../res/components/round_button.dart';
import '../../../utils/utils.dart';

class ForgetPasswordOtpAuthenticationScreen extends StatefulWidget{
  String email;

  ForgetPasswordOtpAuthenticationScreen({super.key,required this.email});
  @override
  State<ForgetPasswordOtpAuthenticationScreen> createState() => _ForgetPasswordOtpAuthenticationScreenState();
}

class _ForgetPasswordOtpAuthenticationScreenState extends State<ForgetPasswordOtpAuthenticationScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
   return  Scaffold(
     body:SingleChildScrollView(
       child: Container(
         height: MediaQuery.of(context).size.height,
         width: MediaQuery.of(context).size.width,
         child: Stack(
           children: [
             Column(
               children: [
                 Expanded(
                   child: Container(

                     width:  double.infinity,
                     decoration: BoxDecoration(
                       gradient: Utils.myGradient()
                     ),
                     child: Column(
                       //  mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(height: 50,),
                         Center(child: SvgPicture.asset(AppImageUrl.logo)),
                         SizedBox(height: 40,),
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 25.0),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                 AppString.otpAuthentication,style: TextStyle(color: AppColor.white,fontWeight: FontWeight.bold,fontSize: 24),
// style: AppStyle.whiteBold30,
                               ),
                               SizedBox(height: 5,),
                               Text(
                                 AppString.otpInstruction,
                                 style: TextStyle(color: AppColor.white,fontSize: 14,fontWeight: FontWeight.w300),
//   style: AppStyle.whiteMedium16,
                               ),
                             ],
                           ),
                         )
                       ],
                     ),
                   ),
                 ),
                 Expanded(child: Container(
                   color: Colors.white,
                 ))
               ],
             ),
             Center(
               child: Container(
                 height: 200,
                 decoration: BoxDecoration(
                   color: AppColor.white,
                   borderRadius: BorderRadius.circular(40),
                   border: Border.all(color: AppColor.black, width: 0.25),
                 ),
                 child:Consumer<ForgetScreenProvider>(
                     builder: (context,value,child) {
                       return Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 20),
                         child: Form(
                           key: _formKey,
                           child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 SizedBox(
                                   width: 300,
                                   child: OtpTextField(
                                     keyboardType: TextInputType.number,
                                     numberOfFields: 4,
                                     // borderColor: ,
                                     showFieldAsBox: true,
                                     fieldWidth:60,
                                     onCodeChanged: (String code) {},
                                     onSubmit: (String verificationCode){
                                       Map<String, dynamic> data = {
                                         "email": widget.email.toString().trim(),
                                         "OTP": verificationCode
                                       };
                                       debugPrint(widget.email.toString().trim());

                                       debugPrint( "$verificationCode");
                                       value.otpAuthenticationApi(data, context);
                                     }, // end onSubmit
                                   ),
                                 ),
                                 SizedBox(height: 20,),
                                 RoundButton(text: "Resend OTP",loading: value.Loading,focusNode: value.buttonFocusNode,
                                     width:150.0,
                                     onPress: () async {

                                     }
                                 ),
                               ]
                           ),
                         ),
                       );
                     }
                 ),

               ),
             )
           ],
         ),
       ),
     ),
   );
  }
}












