

import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project/models/userParticularPostResponse.dart';
import 'package:demo_project/res/app_colors.dart';
import 'package:demo_project/utils/_app_helper/app_prefrences.dart';
import 'package:demo_project/view/home_screen/components/descriptionTextWidgetWidget.dart';
import 'package:demo_project/view_model/home_screen_provider/myProfile_screen_provider/myParticularPostView_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../res/app_image_url.dart';
import '../../../res/app_string.dart';
import '../../../res/components/like_button.dart';
import '../../../utils/utils.dart';
import '../components/all_comment_show.dart';
import '../components/all_like_show.dart';

class MyParticularPostView extends StatefulWidget {
  final dynamic post;

  const MyParticularPostView({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  _MyParticularPostViewState createState() => _MyParticularPostViewState();
}

class _MyParticularPostViewState extends State<MyParticularPostView> {
  var img = AppImageUrl.postImaGE;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  String? userId;

  loadData() async {
    userId = await AppPreferences.getUserId();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build call main");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.homeScreenAppBar,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
        ),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              widget.post["User_Name"],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            const Text(
              "Posts",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.white,
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {}
          );
        },
        child: Consumer<MyParticularPostViewProvider>(
          builder: (context, value, child) {
            return FutureBuilder<PostResponse?>(
              future:
                  value.getParticularPostApi(widget.post["Post_Id"].toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(color: AppColor.homeScreenAppBar));
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading data'));
                } else if (snapshot.data == null) {
                  return const CircularProgressIndicator();
                } else {
                  return SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height-100,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot.data!.posts[0].user.displayPicture,fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data!.posts[0].user.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: AppColor.black,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                          Text(
                                            Utils.formatDateTime(snapshot.data!.posts[0].createdAt),
                                            style: const TextStyle(
                                                fontSize: 12, color: Colors.black),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                PopupMenuButton(
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: AppColor.black,
                                    size: 22,
                                  ),
                                  itemBuilder: (context) => [
                                    (userId == snapshot.data!.posts[0].userId)
                                        ? PopupMenuItem(
                                            value: 1,
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  onTap: () async {
                                                    Navigator.pop(context);
                                                    showMyDialog(
                                                        AppString.deleteThePost,
                                                        snapshot.data!.posts[0].id
                                                            .toString(),
                                                        snapshot
                                                            .data!.posts[0].userId
                                                            .toString());
                                                  },
                                                  title:  const Text(AppString.delete,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14)),
                                                  trailing: const Icon(
                                                    Icons.delete_forever,
                                                    color: AppColor.black,
                                                    size: 21,
                                                  ),
                                                ),
                                                ListTile(
                                                  onTap: () async {
                                                    Navigator.pop(context);
                                                    showMyDialog(
                                                        AppString.editThePost,
                                                        snapshot.data!.posts[0].id
                                                            .toString(),
                                                        snapshot.data!.posts[0].userId
                                                            .toString(),editPostCaption: snapshot.data!.posts[0].caption);
                                                  },
                                                  title: const Text(AppString.edit,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14)),
                                                  trailing: const Icon(
                                                    Icons.edit,
                                                    color: AppColor.black,
                                                    size: 21,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : PopupMenuItem(
                                            value: 1,
                                            child: ListTile(
                                              onTap: () async {
                                                Navigator.pop(context);
                                                showMyDialog(
                                                   AppString.reportThePost,
                                                    snapshot.data!.posts[0].id
                                                        .toString(),
                                                    snapshot.data!.posts[0].userId
                                                        .toString());
                                              },
                                              title: const Text(AppString.report,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 14)),
                                              trailing: const Icon(
                                                Icons.delete_forever,
                                                color: AppColor.black,
                                                size: 21,
                                              ),
                                            ),
                                          ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: double.infinity,
                                  //   height: MediaQuery.of(context).size.height * 0.5,
                                  constraints: BoxConstraints(
                                    maxHeight:
                                        MediaQuery.of(context).size.height * 0.5,
                                    maxWidth: MediaQuery.of(context).size.width,
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data!.posts[0].content
                                                .trim()
                                                .isNotEmpty ||
                                            snapshot.data!.posts[0].content != null
                                        ? snapshot.data!.posts[0].content.toString()
                                        : "https://appinventiv.com/wp-content/themes/twentynineteen-child/images/img2019.webp",
                                    fit: BoxFit.fill,
                                    errorWidget: (q, w, e) {
                                      return Image.network(
                                          "https://appinventiv.com/wp-content/themes/twentynineteen-child/images/img2019.webp");
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                            ),
                            child: DescriptionTextWidgetWidget(
                                text: snapshot.data!.posts[0].caption.toString()),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      enableDrag: true,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30)),
                                      showDragHandle: true,
                                      builder: (context) {
                                        return AllLikeShow(
                                          postId: widget.post["Post_Id"].toString(),
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    "${snapshot.data!.posts[0].likesCount} likes",
                                    style: const TextStyle(
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      enableDrag: true,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30)),
                                      showDragHandle: true,
                                      builder: (context) {
                                        return SizedBox(
                                          height: 400+MediaQuery.of(context).viewInsets.bottom,
                                          child: AllCommentShow(
                                              postId: widget.post["Post_Id"].toString(),
                                              postedById: snapshot.data!.posts[0].userId,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    "${snapshot.data!.posts[0].commentCount} comments",
                                    style: const TextStyle(
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                ),
                                const Text(
                                  "0" " share",
                                  style: TextStyle(
                                      color: AppColor.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Divider(height: 2, color: Colors.black),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, top: 5, right: 10, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: LikeButton(
                                    snapshot: snapshot.data!,
                                    value: value,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        enableDrag: true,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        showDragHandle: true,
                                        builder: (context) {
                                          return SizedBox(
                                            height: 400+MediaQuery.of(context).viewInsets.bottom,
                                            child: AllCommentShow(
                                                postId: widget.post["Post_Id"]
                                                    .toString(),
                                                postedById: snapshot.data!.posts[0].userId,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child:
                                        const Icon(Icons.chat, color: AppColor.fadeBlack),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: InkWell(
                                      onTap: () {
                                        // print(widget.post["numberOfLikes"]);
                                      },
                                      child: const Icon(Icons.share,
                                          color: AppColor.fadeBlack),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> showMyDialog(
      String title, String postId, String postUserId,{String? editPostCaption}) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer<MyParticularPostViewProvider>(
            builder: ( context, value,  child) {
              value.editingController.text=editPostCaption??"";
            return AlertDialog(
              title: title == AppString.editThePost ?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  const SizedBox(height: 15,),
                  TextFormField(
                    controller:  value.editingController,
                    //    onChanged: value.onChanged,
                    style: const TextStyle(color: AppColor.black),
                    decoration:  InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            color: AppColor.fadeBlack
                        ),
                      ),
                      focusedBorder:OutlineInputBorder(

                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            color: AppColor.homeScreenAppBar
                        ),
                      ) ,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                      filled: true,
                      fillColor: Colors.white38,
                      //   hintText: "Search",
                      // hintStyle: TextStyle(color: AppColor.black),
                      // prefixIcon: Icon(Icons.search,color: AppColor.black,)
                    ),
                  ),
                ],
              ):Text(title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              actions: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "No",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey.shade700),
                    )),
                const SizedBox(
                  width: 20,
                ),
                title == "Edit the Post"
                        ? InkWell(
                        onTap: () {
                          value.editPostApi(postId, context);
                        },
                        child: const Text(
                          "Yes",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black),
                        ))
                        : InkWell(
                        onTap: () {
                          (userId == postUserId)
                              ? value.deletePostApi(postId, context)
                              : value.reportPostApi(postId, context);
                        },
                        child: const Text(
                          "Yes",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black),
                        ))

              ],
            );
          },);
        });
  }
}
