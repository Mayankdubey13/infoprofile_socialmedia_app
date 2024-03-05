import 'package:demo_project/res/app_colors.dart';
import 'package:demo_project/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/routes/routes_name.dart';
import '../../../view_model/home_screen_provider/home_screen_provider.dart';
import '../../../view_model/home_screen_provider/mySearchScreenProvider.dart';

class CostumBotttomNavigationBar extends StatefulWidget{
  const CostumBotttomNavigationBar({super.key,});

  @override
  State<CostumBotttomNavigationBar> createState() => _CostumBotttomNavigationBarState();
}

class _CostumBotttomNavigationBarState extends State<CostumBotttomNavigationBar> {
  //int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: SafeArea(
          child: Container(
              height: 50,
              decoration: BoxDecoration(
               // color:AppColor.bottomNavigationBar,
                color:  AppColor.homeScreenAppBar,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Consumer<HomeScreenProvider>(
                builder: (context,value,child){
                  return  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            enableFeedback: false,
                            onPressed: () {
                            MySearchScreenprovider.res = null;
                             value.setPageIndex(0);
                            },
                            icon: value.pageIndex == 0
                                ? const Icon(
                              Icons.home_filled,
                              color: Colors.white,
                              size: 30,
                            )
                                : const Icon(
                              Icons.home_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            enableFeedback: false,
                            onPressed: () {
                              value.setPageIndex(1);
                            },
                            icon: value.pageIndex == 1
                                ? const Icon(
                              Icons.saved_search_rounded,
                              color: Colors.white,
                              size: 30,
                            )
                                : const Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            enableFeedback: false,
                            onPressed: () {
                              MySearchScreenprovider.res = null;
                              Navigator.pushNamed(context, RoutesName.myAddPostScreen);
                            },
                            icon: value.pageIndex == 2
                                ? const Icon(
                              Icons.add_box,
                              color: Colors.white,
                              size: 30,
                            )
                                : const Icon(
                              Icons.add_box_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            enableFeedback: false,
                            onPressed: () {
                              MySearchScreenprovider.res = null;
                             value.setPageIndex(3);

                            },
                            icon: value.pageIndex == 3
                                ? const Icon(
                              Icons.work_rounded,
                              color: Colors.white,
                              size: 30,
                            )
                                : const Icon(
                              Icons.work_outline_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ]
                    ),

                  );
                },
              )
          ),
        ),
      ),
    );
  }
}