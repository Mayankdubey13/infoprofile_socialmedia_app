import 'package:demo_project/utils/routes/routes_name.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../res/app_colors.dart';
import '../../res/app_image_url.dart';
import '../../res/app_string.dart';
import '../../res/components/round_button.dart';
import '../../utils/utils.dart';
import '../../view_model/signUp_screen_provider/signUp_screen_provider.dart';

class SignUpScreen extends StatefulWidget{
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height+80,
        //  height: 1000,
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
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40,),
                          Center(child: SvgPicture.asset(AppImageUrl.logo)),
                          const SizedBox(height: 30,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppString.signUp,style: const TextStyle(color: AppColor.white,fontWeight: FontWeight.bold,fontSize: 24),
// style: AppStyle.whiteBold30,
                                ),
                                const SizedBox(height: 5,),
                                Text(
                                  AppString.signUpInstruction,
                                  style: const TextStyle(color: AppColor.white,fontSize: 14,fontWeight: FontWeight.w300),
//   style: AppStyle.whiteMedium16,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                  ))
                ],
              ),
              SizedBox(
                      height: MediaQuery.of(context).size.height+80,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 200 ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(color: AppColor.black, width: 0.25),
                              ),
                              child:Consumer<SignUpScreenProvider>(
                                  builder: (context,value,child) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              TextFormField(
                                                controller: value.nameController,
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                               textInputAction: TextInputAction.next,
                                                style: const TextStyle(fontSize: 15),
                                                focusNode: value.nameFocus,
                                                onFieldSubmitted: (values){
                                                  Utils.fieldFocusNode(context, value.nameFocus,value.emailFocus);
                                                },
                                                validator: Utils.isValidName,
                                                decoration: InputDecoration(
                                                    hintText: "Full Name",
                                                    contentPadding: EdgeInsets.zero,
                                                    isDense: true,
                                                    errorStyle: const TextStyle(fontSize: 10.0),
                                                    prefixIcon: const Icon(Icons.person),
                                                    labelText: "Full Name",
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(30.0)
                                                    ),errorBorder : OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(30.0)
                                                )

                                                ),
                                              ),
                                              const SizedBox(height: 10,),
                                              TextFormField(
                                                controller: value.emailController,
                                               //   autovalidateMode: AutovalidateMode.onUserInteraction,
                                                style: const TextStyle(fontSize: 15),
                                                focusNode: value.emailFocus,
                                                onFieldSubmitted: (values){
                                                  Utils.fieldFocusNode(context, value.emailFocus,value.userNameFocus);
                                                },
                                                validator: Utils.isValidEmail,
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.zero,
                                                    hintText: "Email",
                                                    errorStyle: const TextStyle(fontSize: 10.0),
                                                    isDense: true,
                                                    prefixIcon: const Icon(Icons.mail_lock),
                                                    labelText: "Email",
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(30.0)
                                                    ),errorBorder : OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(30.0)
                                                )
                                                ),
                                              ),
                                              const SizedBox(height: 10,),
                                              TextFormField(
                                                controller: value.userNameController,
                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                style: const TextStyle(fontSize: 15),
                                                focusNode: value.userNameFocus,
                                                onFieldSubmitted: (values){
                                                  Utils.fieldFocusNode(context, value.userNameFocus,value.passwordFocus);
                                                },
                                                validator: Utils.isValidName,
                                                decoration: InputDecoration(
                                                    hintText: "User Name",
                                                    contentPadding: EdgeInsets.zero,
                                                    prefixIcon: const Icon(Icons.person),
                                                    isDense: true,
                                                    errorStyle: const TextStyle(fontSize: 10.0),
                                                    labelText: "User Name",
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(30.0),

                                                    ),
                                                    errorBorder : OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(30.0)
                                                    )
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              TextFormField(
                                                controller: value.passwordController,
                                                obscureText: value.obs,
                                                 autovalidateMode: AutovalidateMode.onUserInteraction,
                                                focusNode: value.passwordFocus,
                                                style: const TextStyle(fontSize: 15),
                                                validator: Utils.isValidPass,
                                                onFieldSubmitted: (values){
                                                  Utils.fieldFocusNode(context, value.passwordFocus, value.conformPasswordFocus);
                                                },
                                                decoration: InputDecoration(
                                                    isDense: true,
                                                  contentPadding: EdgeInsets.zero,
                                                  errorStyle: const TextStyle(fontSize: 10.0),
                                                  hintText: "Password",
                                                  prefixIcon: const Icon(Icons.lock),
                                                  suffixIcon: InkWell(
                                                      onTap: (){
                                                        value.setObs();
                                                      },
                                                      child: const Icon(Icons.change_circle)),
                                                  labelText: "Password",
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(30.0)
                                                  ),
                                                    errorBorder : OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(30.0)
                                                    )
                                                ),
                                              ),
                                              const SizedBox(height: 10,),
                                              TextFormField(
                                                controller: value.conformPasswordController,
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                style: const TextStyle(fontSize: 15),
                                                obscureText: value.obs1,
                                                focusNode: value.conformPasswordFocus,
                                                validator: Utils.isValidPass,
                                                onFieldSubmitted: (values){
                                                  Utils.fieldFocusNode(context, value.conformPasswordFocus, value.buttonFocusNode);
                                                },
                                                decoration: InputDecoration(
                                                  hintText: "Conform Password",
                                                    contentPadding: EdgeInsets.zero,
                                                    isDense: true,
                                                  errorStyle: const TextStyle(fontSize: 10.0),
                                                  prefixIcon: const Icon(Icons.lock),
                                                  suffixIcon: InkWell(
                                                      onTap: (){
                                                        value.setObs1();
                                                      },
                                                      child: const Icon(Icons.change_circle)),
                                                  labelText: "Conform Password",
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(30.0)
                                                  ),
                                                    errorBorder : OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(30.0)
                                                    )
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              RoundButton(text: "SignUp",
                                                  width: 160.0,
                                                  loading: value.signUpLoading, onPress: () async {
                                                    Utils.hideKeyboard(context);
                                                    HitTestBehavior.translucent;
                                                    if (_formKey.currentState!.validate()) {
                                                      value.setSignUpLoading(true);
                                                      Map<String, dynamic> data = {
                                                        "name":value.nameController.text.toString().trim(),
                                                        "email": value.emailController.text.toString().trim(),
                                                        "userName":value.userNameController.text.toString().trim(),
                                                        "password": value.passwordController.text.toString().trim()
                                                      };
                                                      value.signupApi(data, context);
                                                     // print("Api Hit");
                                                      debugPrint("Api Hit");
//  Utils.toastMessage("Api Hit");
                                                      await Future.delayed(const Duration(seconds: 1));
                                                      value.setSignUpLoading(false);
                                                    }
                                                  }),
                                              const SizedBox(height: 30,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  //  SizedBox(height: 200,),
                                                  Text(AppString.alreadyHaveAnAccount),
                                                  InkWell(
                                                      onTap: (){
                                                        Navigator.pushNamedAndRemoveUntil(context, RoutesName.signInScreen, (route) => false);
                                                      },
                                                      child: Text(AppString.signIn,style: TextStyle(fontSize:15,color: AppColor.titorialScreenbuttonTextColor),
                                                      )),
                                                ],

                                              )
                                            ]
                                        ),
                                      ),
                                    );
                                  }
                              ),

                            ),
                          ),
                        ],
                      ),
                    )
            )
            ],
          ),
        ),
      ),
    );


  }
}


