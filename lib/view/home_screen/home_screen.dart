import 'package:demo_project/res/app_colors.dart';
import 'package:demo_project/view/home_screen/components/bottomNavigationBar.dart';
import 'package:demo_project/view/home_screen/myAdd_post_screen/myAddPost_screen.dart';
import 'package:demo_project/view/home_screen/myHomeView/myHomeView.dart';
import 'package:demo_project/view/home_screen/myProfileView/myProfileView.dart';
import 'package:demo_project/view/home_screen/mySearch_screen/mySearch_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/routes/routes_name.dart';
import '../../view_model/home_screen_provider/home_screen_provider.dart';
import '../../view_model/user_view_model.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {

  final pages = [
    MyHomeView(),
    MySearchScreen(),
    const MyAddPostScreen(),
    const MyProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Consumer<HomeScreenProvider>(builder: (context, value, child) {
        return pages[value.pageIndex];
      },
      ),
      bottomNavigationBar: const CostumBotttomNavigationBar(),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}