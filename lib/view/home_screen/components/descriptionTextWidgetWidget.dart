import 'package:demo_project/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';

class DescriptionTextWidgetWidget extends StatelessWidget {
  final String text;

  DescriptionTextWidgetWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: ExpandableText(
        text,style: TextStyle(fontSize: 13,),
        expandText: 'show more',
        collapseText: 'show less',
        maxLines: 2, // You can adjust this based on your requirements
        linkColor: Colors.blue, // Customize link color if needed
      ),
    );
  }
}






