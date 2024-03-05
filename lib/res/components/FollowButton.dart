import 'package:demo_project/models/userProfile_model.dart';
import 'package:flutter/material.dart';

import '../../view_model/home_screen_provider/myHome_screen_provider/specificUser_screen_provider.dart';
import '../../view_model/home_screen_provider/myProfile_screen_provider/myParticularPostView_provider.dart';
import '../app_colors.dart';

class FollowButton extends StatefulWidget {
  final UserProfile? snapshot;
  final SpecificUserScreenProvider value;
  const FollowButton({super.key, required this.snapshot, required this.value});

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  late int isFollow;
  @override
  void initState() {
    isFollow = widget.snapshot!.data.profile.isFollowing;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("buid call");
    return InkWell(
      onTap: () async {
        if (isFollow == 1) {
          setState(() {
            isFollow = 0;
          });

          await widget.value.unFollowUserApi(widget.snapshot!.data.profile.userId.toString(), context);
        } else {
          setState(() {
            isFollow = 1;
          });
          await widget.value.followUserApi(widget.snapshot!.data.profile.userId.toString(), context);
        }
      }
      ,child: Container(
      height: 35,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isFollow == 0 ?AppColor.homeScreenAppBar : Colors.grey.shade600
      ),
      child: Center(child: Text(isFollow==0?"Follow":"UnFollow",
        style: TextStyle(color: AppColor.white, fontWeight: FontWeight.bold),)),
    ),
    );
  }
}