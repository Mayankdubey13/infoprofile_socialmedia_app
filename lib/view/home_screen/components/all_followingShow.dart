import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project/models/fetchUserFollowiing.dart';
import 'package:demo_project/view_model/fetchUserFollowingProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../res/app_colors.dart';

class AllFollowingShow extends StatefulWidget{
  String userId;

  AllFollowingShow({super.key,required this.userId});
  @override
  State<AllFollowingShow> createState() => _AllFollowingShowState();
}

class _AllFollowingShowState extends State<AllFollowingShow> {
  @override
  Widget build(BuildContext context) {
    return  Container(
        child: Consumer<FetchUserFollowingProvider>(
            builder: (context, value, child) {
              return FutureBuilder<FetchUserFollowing>(
                  future: value.getFollowingApi(widget.userId.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: Colors.black));
                    } else if (snapshot.hasError) {
                      print('Error: ${snapshot.error}');
                      return Center(child: Text('Error loading data'));
                    } else if (snapshot.data == null) {
                      return CircularProgressIndicator();
                    }
                    else {
                      return ListView.builder(
                          key: const PageStorageKey<String>('postViewPath'),
                          itemExtent: 62, itemCount:snapshot.data!.data.length , itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            //  mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl:snapshot.data!.data[index].displayPicture,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(top:5),
                                    child: Row(
                                      children: [
                                        Text(snapshot.data!.data[index].name.toString(), style: TextStyle(color: AppColor.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15)),
                                        SizedBox(width: 4,),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Divider(height: 2, color: AppColor.fadeBlack,)
                            ],
                          ),
                        );
                      });
                    }
                  }
              );
            }
        )
    );
  }
}