import 'package:demo_project/view_model/signIn_screen_provider/forget_screen_provider.dart';
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

class ForgotEnterNewPassword extends StatefulWidget{
  String token;
   ForgotEnterNewPassword({super.key,required this.token});

  @override
  State<ForgotEnterNewPassword> createState() => _ForgotEnterNewPasswordState();
}

class _ForgotEnterNewPasswordState extends State<ForgotEnterNewPassword> {
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
                                     AppString.newPassword,style: TextStyle(color: AppColor.white,fontWeight: FontWeight.bold,fontSize: 24),
// style: AppStyle.whiteBold30,
                                   ),
                                   SizedBox(height: 5,),
                                   Text(
                                     AppString.newPasswordInstruction,
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
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             Row(mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text(AppString.dontHaveAnAccount),
                                 InkWell(
                                     onTap: (){
                                       Navigator.pushNamed(context, RoutesName.signUpScreen);
                                     },
                                     child: Text(AppString.signUp,style: TextStyle(fontSize:15,color: AppColor.titorialScreenbuttonTextColor),
                                     )),
                               ],

                             ),
                             SizedBox(height:MediaQuery.of(context).size.height*0.13,)
                           ],
                         )
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
                             decoration: BoxDecoration(
                               color: AppColor.white,
                               borderRadius: BorderRadius.circular(40),
                               border: Border.all(color: AppColor.black, width: 0.25),
                             ),
                             child:Consumer<ForgetScreenProvider>(
                                 builder: (context,value,child) {
                                   return Padding(
                                     padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                     child: Form(
                                         key: _formKey,
                                         child:Column(
                                             mainAxisAlignment: MainAxisAlignment.center,
                                             crossAxisAlignment: CrossAxisAlignment.center,
                                             children: [
                                               const SizedBox(height: 25,),
                                               TextFormField(
                                                 controller: value.newPasswordController,
                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                 obscureText: value.obs,
                                                 focusNode: value.newPasswordFocus,
                                                 style: TextStyle(fontSize: 15),
                                                 validator: Utils.isValidPass,
                                                 onFieldSubmitted: (values){
                                                   Utils.fieldFocusNode(context, value.newPasswordFocus, value.newConformPasswordFocus);
                                                 },
                                                 decoration: InputDecoration(
                                                   hintText: "New Password",
                                                   contentPadding: EdgeInsets.zero,
                                                   isDense: true,
                                                   errorStyle: TextStyle(fontSize: 10.0),
                                                   prefixIcon: const Icon(Icons.lock),
                                                   suffixIcon: InkWell(
                                                       onTap: (){
                                                         value.setObs();
                                                       },
                                                       child: const Icon(Icons.change_circle)),
                                                   labelText: "New Password",
                                                   border:  OutlineInputBorder(
                                                     borderRadius: BorderRadius.circular(30.0)
                                                   ),
                                                 ),
                                               ),
                                               const SizedBox(height: 25,),
                                               TextFormField(
                                                 controller: value.ConformNewPasswordController,
                                                   autovalidateMode: AutovalidateMode.onUserInteraction,
                                                 obscureText: value.obs1,
                                                 style: TextStyle(fontSize: 15),
                                                 focusNode: value.newConformPasswordFocus,
                                                 validator: Utils.isValidPass,
                                                 onFieldSubmitted: (values){
                                                   Utils.fieldFocusNode(context, value.newConformPasswordFocus, value.buttonFocusNode);
                                                 },
                                                 decoration: InputDecoration(
                                                   hintText: "Conform New Password",
                                                   contentPadding: EdgeInsets.zero,
                                                   isDense: true,
                                                   errorStyle: TextStyle(fontSize: 10.0),
                                                   prefixIcon: const Icon(Icons.lock),
                                                   suffixIcon: InkWell(
                                                       onTap: (){
                                                         value.setObs1();
                                                       },
                                                       child: const Icon(Icons.change_circle)),
                                                   labelText: "Conform New Password",
                                                   border: OutlineInputBorder(
                                                     borderRadius: BorderRadius.circular(30.0)
                                                   ),
                                                 ),
                                               ),
                                               const SizedBox(height: 25,),
                                               RoundButton(text: "LOGIN",loading: value.Loading,focusNode: value.buttonFocusNode,
                                                   width: 160.0,

                                                   onPress: () async
                                                   {
                                                     Utils.hideKeyboard(
                                                         context);
                                                     if (_formKey.currentState!.validate()) {
                                                        value.setLoading(true);
                                                       Map data = {
                                                   "newPassword": value.newPasswordController.text.toString().trim(),
                                                       };
                                                       value.forgotEnterNewPassword(data,widget.token, context);
                                                        debugPrint("Api Hit");

                                                        await Future.delayed(const Duration(seconds: 1));value.setLoading(false);
                                                      }

                                                   }

                                                   ),
                                             ]
                                         )


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