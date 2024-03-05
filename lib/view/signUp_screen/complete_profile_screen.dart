
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../res/app_colors.dart';
import '../../res/app_image_url.dart';
import '../../res/app_string.dart';
import '../../res/components/round_button.dart';
import '../../utils/utils.dart';
import '../../view_model/signUp_screen_provider/complete_profile_screen_provider.dart';

class CompleteProfileScreen extends StatefulWidget{
  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
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
                     color: Colors.blueAccent,
                     child: Column(
                       // mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(height: 50,),
                         Center(child: SvgPicture.asset(AppImageUrl.logo)),
                         SizedBox(height: 30,),
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 25.0),
                           child: Column(

                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                 AppString.signUp,style: TextStyle(color: AppColor.white,fontWeight: FontWeight.bold,fontSize: 24),
// style: AppStyle.whiteBold30,
                               ),
                               SizedBox(height: 5,),
                               Text(
                                 AppString.signUpInstruction,
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
                         child:Consumer<CompleteProfileScreenProvider>(
                             builder: (context,value,child) {
                               return Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                 child: Form(
                                   key: _formKey,
                                   child:
                                   Column(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       crossAxisAlignment: CrossAxisAlignment.center,
                                       children: [
                                         Container(
                                           height: 95,
                                           width: 95,
                                           child: Stack(
                                             children: [
                                               CircleAvatar(
                                                 radius: 75,
                                               ),
                                              Padding(
                                                padding: const EdgeInsets.only(right: 5),
                                                child: Align (
                                                    alignment: Alignment.bottomRight,
                                                    child: Icon(Icons.camera_alt_rounded,color: AppColor.fadeBlack,)),
                                              )
                                             ],
                                           ),
                                         ),
                                         SizedBox(
                                           height: 25,
                                         ),
                                         TextFormField(
                                           controller: value.fullNameController,
                                           focusNode: value.fullNameFocus,
                                           onFieldSubmitted: (values){
                                             Utils.fieldFocusNode(context, value.fullNameFocus,value.userNameFocus);
                                           },
                                           validator: Utils.isValidName,
                                           decoration: InputDecoration(
                                               hintText: "Full Name",
                                               prefixIcon: Icon(Icons.person),
                                               labelText: "Full Name",
                                               border: OutlineInputBorder()
                                           ),
                                         ),
                                         SizedBox(height: 25,),
                                         TextFormField(
                                           controller: value.userNameController,
                                           focusNode: value.userNameFocus,
                                           onFieldSubmitted: (values){
                                             Utils.fieldFocusNode(context, value.userNameFocus,value.dateOfBirthFocus);
                                           },
                                           validator: Utils.isValidEmail,
                                           decoration: InputDecoration(
                                               hintText: "User-name",
                                               prefixIcon: Icon(Icons.person_pin_outlined),
                                               labelText: "User-name",
                                               border: OutlineInputBorder()
                                           ),
                                         ),
                                         SizedBox(height: 25,),
                                         TextFormField(
                                           controller: value.dateOfBirthController,

                                           focusNode: value.dateOfBirthFocus,
                                          // validator: Utils.isValidPass,

                                           onFieldSubmitted: (values){
                                             Utils.fieldFocusNode(context, value.dateOfBirthFocus, value.buttonFocusNode);
                                           },

                                           decoration: InputDecoration(
                                             prefixIcon: Icon(Icons.calendar_month),
                                             hintText: "DD-MM-YYYY",
                                             labelText: "DD-MM-YYYY",
                                             border: OutlineInputBorder(),
                                           ),
                                         ),
                                         SizedBox(height: 25,),
                                         RoundButton(text: "SignUp",
                                             width: double.infinity,
                                             loading: value.Loading, onPress: () async {
                                               Utils.hideKeyboard(context);
//                                              if (_formKey.currentState!.validate()) {
//                                                value.setLoading(true);
//                                                Map data = {
//                                                  "email": value.emaflilController.text.toString().trim(),
//                                                  "password": value.passwordController.text.toString().trim()
//                                                };
//                                                value.signupApi(data, context);
//                                                print("Api Hit");
// //  Utils.toastMessage("Api Hit");
//                                                debugPrint("Api Hit");
// //  Utils.toastMessage("Api Hit");
//                                                await Future.delayed(const Duration(seconds: 1));
//                                                value.setLoading(false);
//                                              }
                                             }),
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