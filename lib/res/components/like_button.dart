import 'package:flutter/material.dart';

import '../../models/userParticularPostResponse.dart';
import '../../view_model/home_screen_provider/myProfile_screen_provider/myParticularPostView_provider.dart';
import '../app_colors.dart';

class LikeButton extends StatefulWidget {
  final PostResponse snapshot;
  final MyParticularPostViewProvider value;
  const LikeButton({super.key, required this.snapshot, required this.value});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late int isLiked;
  @override
  void initState() {
    isLiked = widget.snapshot.posts[0].liked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("buid call");
    return InkWell(
      onTap: () async {
        if (isLiked == 1) {
          setState(() {
            isLiked = 0;
          });
          await widget.value.unLikePostApi(
              widget.snapshot.posts[0].id.toString(), context);
        } else {
          setState(() {
            isLiked = 1;
          });
          await widget.value.likePostApi(
              widget.snapshot.posts[0].id.toString(), context,widget.snapshot.posts[0].userId);
        }
      },
      child: Icon(
        isLiked == 1 ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
        color: isLiked == 1 ? AppColor.blueAccent : AppColor.fadeBlack,
      ),
    );
  }
}
