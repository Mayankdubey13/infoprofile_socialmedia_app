import 'package:demo_project/res/app_colors.dart';
import 'package:demo_project/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget{
  final text;
   bool  loading ;
  final  onPress;
  final width;
  FocusNode? focusNode;
  RoundButton({
    required this.text ,
    this.loading = false,
    this.focusNode,
    required this.width,
    required this.onPress
});
  @override
  Widget build(BuildContext context) {
   return InkWell(
     onTap: onPress,
     child: Container(
       height: 40,
       width: width,
       decoration: BoxDecoration(
        // color: AppColor.buttonColor
        //  color: AppColor.buttonColor,
         gradient: Utils.myGradient(),
             borderRadius: BorderRadius.circular(30),
       ),
       child: Center(
           child: loading? CircularProgressIndicator(color: Colors.white,) : Text(text,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.white),)),
     ),
   );

  }

}