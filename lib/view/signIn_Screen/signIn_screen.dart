import 'package:demo_project/res/app_colors.dart';
import 'package:demo_project/res/app_image_url.dart';
import 'package:demo_project/view_model/signIn_screen_provider/signIn_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../res/app_string.dart';
import '../../res/components/round_button.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';

class SignInScreen extends StatefulWidget{
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                        gradient: Utils.myGradient(),
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
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
                                  AppString.signIn,style: TextStyle(color: AppColor.white,fontWeight: FontWeight.bold,fontSize: 24),
// style: AppStyle.whiteBold30,
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  AppString.signInInstruction,
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80),
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
                            child:Consumer<SignInScreenProvider>(
                                builder: (context,value,child) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                    child: Form(
                                      key: _formKey,
                                      child:Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            TextFormField(
                                              controller:  value.emailController,
                                              autovalidateMode: AutovalidateMode.onUserInteraction,
                                               focusNode: value.emailFocus,

                                               style: TextStyle(fontSize: 15),
                                               onFieldSubmitted: (values){
                                                 Utils.fieldFocusNode(context, value.emailFocus,value.passwordFocus);
                                               },
                                               validator: Utils.isValidEmail,
                                               decoration:  InputDecoration(
                                                 contentPadding: EdgeInsets.symmetric(horizontal: 12),
                                                   hintText: "Email",
                                                  // helperText: "helloe",
                                                   isDense: true,
                                                errorStyle: const TextStyle(fontSize: 10.0),
                                                //   helperText: " ",

                                                   prefixIcon: Icon(Icons.mail_lock),
                                                   labelText: "Email",
                                                   //contentPadding: EdgeInsets.zero,
                                                   //contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                                                   border : OutlineInputBorder(
                                                     borderRadius: BorderRadius.circular(30.0)
                                                   ),
                                                 errorBorder : OutlineInputBorder(
                                                     borderRadius: BorderRadius.circular(30.0)
                                                 )
                                                 // focusedBorder: OutlineInputBorder(
                                                 //     borderRadius: BorderRadius.circular(30.0),
                                                 //   borderSide: BorderSide(
                                                 //     color: AppColor.blue
                                                 //   )
                                                 //
                                                 // ),
                                               ),
                                             ),
                                            SizedBox(height:10,),
                                            TextFormField(
                                              controller: value.passwordController,
                                             autovalidateMode: AutovalidateMode.onUserInteraction,
                                              obscureText: value.obs,
                                              focusNode: value.passwordFocus,
                                              style: TextStyle(fontSize: 15),
                                              validator: Utils.isValidPass,
                                              // onFieldSubmitted: (values){
                                              //   Utils.fieldFocusNode(context, value.passwordFocus, value.buttonFocusNode);
                                              // },
                                              decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                                              // helperText: "",
                                                hintText: "Password",
                                                isDense: true,
                                                errorStyle: const TextStyle(fontSize: 10.0),
                                                prefixIcon: const Icon(Icons.lock),
                                                suffixIcon: InkWell(
                                                    onTap: (){
                                                      value.setObs();
                                                    },
                                                    child: const Icon(Icons.change_circle)),
                                                labelText: "Password",
                                                border:  OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(30.0)
                                                ),
                                                  errorBorder : OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(30.0)
                                                  )
                                                // focusedBorder: OutlineInputBorder(
                                                //     borderRadius: BorderRadius.circular(30.0)
                                                // ),
                                              ),
                                            ),
                                            SizedBox(height:8,),
                                            InkWell(
                                              onTap: (){
                                        Navigator.pushNamed(context, RoutesName.forgetPasswordScreen);
                                              },
                                              child: Align(
                                                 alignment: Alignment.topRight,
                                                  child: Text(AppString.forgetPassword,style: TextStyle(color: AppColor.titorialScreenbuttonTextColor,fontWeight: FontWeight.normal,fontSize: 14))),
                                            ),
                                            SizedBox(height: 15,),
                                            RoundButton(text: "LOGIN",loading: value.loading,focusNode: value.buttonFocusNode,
                                                width: 160.0,

                                                onPress: () async {
                                                  Utils.hideKeyboard(context);
                                                  behavior: HitTestBehavior.translucent;
                                                  if (_formKey.currentState!.validate()) {
                                                    value.setLoading(true);
                                                    dynamic data = {
                                                      "email": value.emailController.text.trim(),
                                                      "password": value.passwordController.text.trim()
                                                    };

                                                  print(data);
                                                    value.loginApi(data, context);
                                                   // debugPrint("Api Hit");
                                                    await Future.delayed(const Duration(seconds: 1));
                                                    value.setLoading(false);
                                                  }

                                                }),
                                            SizedBox(height: 25,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(AppString.dontHaveAnAccount),
                                                InkWell(
                                                    onTap: (){
                                                      Navigator.pushNamedAndRemoveUntil(context, RoutesName.signUpScreen, (route) => false);
                                                    },
                                                    child: Text(AppString.signUp,style: TextStyle(fontSize:15,color: AppColor.titorialScreenbuttonTextColor),
                                                    )),
                                              ],

                                            )
                                          ]
                                      )


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



