import 'package:demo_project/res/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_image_url.dart';
import '../../../res/app_string.dart';
import '../../../res/components/round_button.dart';
import '../../../utils/routes/routes_name.dart';
import '../../../utils/utils.dart';
import '../../../view_model/signIn_screen_provider/forget_screen_provider.dart';

class ForgetPasswordScreen extends StatefulWidget{
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                                  AppString.forgotPassword,style: TextStyle(color: AppColor.white,fontWeight: FontWeight.bold,fontSize: 24),
// style: AppStyle.whiteBold30,
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  AppString.forgetPasswordInstruction,
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
              SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                          TextFormField(
                                            controller:  value.emailController,
                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                            focusNode: value.emailFocus,
                                            style: TextStyle(fontSize: 15),
                                            onFieldSubmitted: (values){
                                              Utils.fieldFocusNode(context, value.emailFocus,value.buttonFocusNode);
                                            },
                                            validator: Utils.isValidEmail,
                                            decoration:InputDecoration(
                                              isDense: true,
                                                hintText: "Email",
                                                contentPadding: EdgeInsets.zero,
                                                errorStyle: TextStyle(fontSize: 10.0),
                                                prefixIcon: Icon(Icons.mail_lock),
                                                labelText: "Email",
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(30.0)
                                                )
                                            ),
                                          ),
                                          // Text(
                                          //   "hello",
                                          //   style: AppFonts.headerStyle(),
                                          // ),
                                          SizedBox(height: 20,),
                                          RoundButton(text: "Next",loading: value.Loading,focusNode: value.buttonFocusNode,
                                              width: 160.0,
                                              onPress: () async {
                                                if (_formKey.currentState!.validate()){
                                                  value.setLoading(true);
                                                  dynamic data =
                                                  {
                                                    "email" : value.emailController.text.toString().trim()
                                                  };
                                                  print(data);
                                                  value.forgotPasswordApi(data, context);
                                                  // debugPrint("Api Hit");
                                                  await Future.delayed(const Duration(seconds: 1));
                                                  value.setLoading(false);
                                                }
                                              }
                                          ),
                                        ]
                                    ),
                                  ),
                                );
                              }
                          ),

                        ),
                      ),
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}