import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project/models/feedProfile.dart';
import 'package:demo_project/res/app_image_url.dart';
import 'package:demo_project/utils/_app_helper/app_prefrences.dart';
import 'package:demo_project/view_model/home_screen_provider/myHome_screen_provider/myHome_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_string.dart';
import '../../../utils/routes/routes_name.dart';
import '../../../utils/utils.dart';
import '../components/all_comment_show.dart';
import '../components/all_like_show.dart';
import '../components/descriptionTextWidgetWidget.dart';

class MyHomeView extends StatefulWidget{
  const MyHomeView({super.key});

  @override
  State<MyHomeView> createState() => _MyHomeViewState();
}

class _MyHomeViewState extends State<MyHomeView> with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    super.initState();
     setCurrentUser();
  }

  String? currentUser;
  setCurrentUser() async {
      currentUser = await AppPreferences.getUserId();
    }

  @override
  Widget build(BuildContext context) {
    final homeScreenProvider = Provider.of<MyHomeScreenProvider>(context,listen: false);
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          title:  SvgPicture.asset(AppImageUrl.logo),
          centerTitle: true,
          backgroundColor: AppColor.homeScreenAppBar,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: InkWell(
                  onTap: (){

                    Navigator.pushNamed(context, RoutesName.notificationScreen);

                  },
                  child: Icon(Icons.notifications,size: 27,color: AppColor.white,)),
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            MyHomeScreenProvider.user = null;
            setState(() {

            });
          },
          child: Column(
            children: [
              FutureBuilder<FeedProfile>(
                    future: homeScreenProvider.getParticularPostApi(),
                    builder: (context,snapshot){

                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                     else if(snapshot.hasData){
                        return Expanded(
                          child: ListView.builder(
                              cacheExtent: 2000,
                              key: const PageStorageKey<String>('postViewPath'),
                              itemCount: snapshot.data!.feed.length,
                              itemBuilder: (context,index){
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow:  const [
                                        BoxShadow(color: Colors.grey, blurRadius: 2,spreadRadius: 1),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            //   crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    height: 50,
                                                    width: 50,
                                                    child: ClipOval(
                                                      child: CachedNetworkImage(
                                                          imageUrl: snapshot.data!.feed[index].user.displayPicture,fit: BoxFit.fill,),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 8),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      //mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        InkWell(

                                                          onTap: (){
                                                            Map<String,dynamic> post ={
                                                              "User_Name":snapshot.data!.feed[index].user.name.toString(),
                                                              "UserId" :snapshot.data!.feed[index].followedPosts.userId.toString(),
                                                              "FollowingId":snapshot.data!.feed[index].followingId.toString(),
                                                            };
                                                            currentUser == snapshot.data!.feed[index].followedPosts.userId?Navigator.pushNamed(context, RoutesName.myProfileScreen):
                                                            Navigator.pushNamed(context, RoutesName.specificUserScreen,arguments:{
                                                            "UserDetail" :post
                                                            });
                                                          }
                                                          , child: Text(snapshot.data!.feed[index].user.name.toString(),style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color:AppColor.black,fontStyle: FontStyle.normal),)),
                                                        Text(Utils.formatDateTime(snapshot.data!.feed[index].followedPosts.createdAt),style: const TextStyle(fontSize: 10,color: Colors.black),)
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              PopupMenuButton(
                                                icon: const Icon(Icons.more_vert,color: AppColor.black,size: 22,),
                                                itemBuilder: (context)=>[

                                                  (currentUser == snapshot.data!.feed[index].user.id)
                                                      ? PopupMenuItem(
                                                    value: 1,
                                                    child: Column(
                                                      children: [
                                                        ListTile(
                                                          onTap: () async {
                                                            Navigator.pop(context);
                                                            showMyDialog(
                                                                AppString.deleteThePost,
                                                                snapshot.data!.feed[index].followedPosts.postId
                                                                    .toString(),
                                                                snapshot.data!.feed[index].user.id
                                                                    .toString());
                                                          },
                                                          title: const Text(AppString.delete,
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
                                                                snapshot.data!.feed[index].followedPosts.postId
                                                                    .toString(),
                                                                snapshot.data!.feed[index].user.id
                                                                    .toString(),editPostCaption: snapshot.data!.feed[index].followedPosts.caption);
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
                                                            snapshot.data!.feed[index].followedPosts.postId
                                                                .toString(),
                                                            snapshot.data!.feed[index].user.id
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

                                          const SizedBox(height: 5,),

                                          Container(
                                            width:MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context).size.width ,
                                            child: AspectRatio(
                                              aspectRatio: 1,
                                              child: CachedNetworkImage(
                                                imageUrl: snapshot.data!.feed[index].followedPosts.content.toString().trim().isNotEmpty || snapshot.data!.feed[index].followedPosts.content != null? snapshot.data!.feed[index].followedPosts.content.toString():"https://appinventiv.com/wp-content/themes/twentynineteen-child/images/img2019.webp",fit: BoxFit.cover,errorWidget: (q,w,e){
                                                  return Image.network("https://appinventiv.com/wp-content/themes/twentynineteen-child/images/img2019.webp",fit: BoxFit.fill,);
                                              },),
                                            ),
                                          ),

                                          const SizedBox(height: 3,),

                                          DescriptionTextWidgetWidget(text: snapshot.data!.feed[index].followedPosts.caption),

                                          const SizedBox(height: 3,),

                                          Padding(
                                            padding: const EdgeInsets.only(left: 5),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        if (snapshot.data!.feed[index].liked==1) {
                                                          await homeScreenProvider.unLikePostApi(snapshot.data!.feed[index].followedPosts.postId, context, index).then((value){
                                                          });
                                                          setState(() {

                                                          });
                                                        } else {
                                                          await homeScreenProvider.likePostApi(snapshot.data!.feed[index].followedPosts.postId, context,snapshot.data!.feed[index].user.id, index).then((value){
                                                          });
                                                          setState(() {

                                                          });
                                                        }
                                                      },
                                                      child: Icon(
                                                        snapshot.data!.feed[index].liked == 1
                                                            ? Icons.thumb_up
                                                            : Icons.thumb_up_alt_outlined,
                                                        color: snapshot.data!.feed[index].liked == 1
                                                            ? AppColor.blueAccent
                                                            : AppColor.fadeBlack,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 20,),
                                                    InkWell(
                                                        onTap: (){
                                                          showModalBottomSheet(
                                                            isScrollControlled: true,
                                                            context: context,
                                                            enableDrag: true,
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                                            showDragHandle: true,
                                                            builder: (context) {
                                                              return SizedBox(
                                                                height: 400+MediaQuery.of(context).viewInsets.bottom,
                                                                  child: AllCommentShow(postId: snapshot.data!.feed[index].followedPosts.postId.toString(),postedById:snapshot.data!.feed[index].user.id,));
                                                            },
                                                          );
                                                        },
                                                        child: const Icon(Icons.chat,color: AppColor.fadeBlack)),

                                                  ],
                                                ),
                                                Row (
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          showModalBottomSheet(
                                                            context: context,
                                                            enableDrag: true,
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                                            showDragHandle: true,
                                                            builder: (context) {
                                                              return AllLikeShow(postId:snapshot.data!.feed[index].followedPosts.postId.toString(),);
                                                            },
                                                          );
                                                        },
                                                        child: Text("${snapshot.data!.feed[index].numberOfLikes} likes",style: const TextStyle(color: AppColor.black,fontWeight: FontWeight.w600,fontSize: 12),)),
                                                    InkWell(

                                                          onTap: (){
                                                            showModalBottomSheet(
                                                                  isScrollControlled: true,
                                                              context: context,
                                                              enableDrag: true,
                                                              showDragHandle: true,
                                                              builder: (context) {

                                                                // Map<String ,dynamic> mp ={
                                                                //   "postId":snapshot.data!.feed[index].followedPosts.postId.toString(),
                                                                //   "commentPost"
                                                                //
                                                                // };
                                                                return SizedBox(
                                                                    height: 400+MediaQuery.of(context).viewInsets.bottom,
                                                                    child: AllCommentShow(postId:snapshot.data!.feed[index].followedPosts.postId.toString(), postedById: snapshot.data!.feed[index].user.id,));
                                                              },
                                                            );
                                                          }

                                                      ,  child: Text("${snapshot.data!.feed[index].numberOfComments} comments",style: const TextStyle(color: AppColor.black,fontWeight: FontWeight.w600,fontSize: 12),)),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),



                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                      }
                      else{
                        return  const Expanded(
                          child: Center(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              CircularProgressIndicator(),
                            ],
                          )),
                        );
                      }
                    }
                ),

            ],
          ),
        )
    );

  }
  Future<void> showMyDialog(String title, String postId, String postUserId,{String? editPostCaption}) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer<MyHomeScreenProvider>(
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
                        (currentUser == postUserId)
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}