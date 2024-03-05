import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project/res/components/FollowButton.dart';
import 'package:demo_project/view_model/home_screen_provider/myHome_screen_provider/specificUser_screen_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/userProfile_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_image_url.dart';
import '../../../res/app_string.dart';
import '../../../utils/routes/routes_name.dart';
import '../components/all_followers_show.dart';
import '../components/all_followingShow.dart';

class SpecificUserScreen extends StatefulWidget{

  dynamic userDeatils;
   SpecificUserScreen({super.key,required this.userDeatils });

  @override
  State<SpecificUserScreen> createState() => _SpecificUserScreenState();
}

class _SpecificUserScreenState extends State<SpecificUserScreen> {
  var img =AppImageUrl.postImaGE;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.homeScreenAppBar,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          }
            ,child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
        centerTitle: true,
        title:  Text(
          widget.userDeatils["User_Name"],
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade400,
          ),
        ),

      ),
          body: RefreshIndicator(
            onRefresh: ()async{
              setState(() {

              });
            },
            child: Column(
              children: [
                Consumer<SpecificUserScreenProvider>(
                  builder: (context, value, child) {
                    return FutureBuilder<UserProfile?>(
                      future: value.userProfile(widget.userDeatils["UserId"].toString()),
                      builder: (context, snapshot) {
                        //  print(snapshot.data!.data.profile.name);
                        print(snapshot.hasData);
                        // Check if the future is still in progress (not completed)
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(color: AppColor.blueAccent),
                            ],
                          ));
                        } else if (snapshot.hasError) {
                          // Handle error state
                          print('Error: ${snapshot.error}');
                          return  const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Error loading data'),
                              ],
                            ),
                          );
                        } else if (snapshot.data == null) {
                          // Data is null, return a placeholder or loading state
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                              ],
                            ),
                          );
                        }
                        else {
                          return Expanded(
                            child: Padding(
                              padding:  const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10,bottom: 5),
                                    child: Row(

                                      children: [
                                        SizedBox(
                                            height:100,
                                            width:100,
                                            child: ClipOval(child: CachedNetworkImage(imageUrl: snapshot.data!.data.profile.displayPicture.toString(),fit: BoxFit.fill,))),
                                        const SizedBox(width: 40,),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                                            children: [
                                              Column(
                                                children: [
                                                  // Text(snapshot.data!.data.profile.totalPosts.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600 ,color: AppColor.black),),
                                                  Text(value.user!.data.profile.totalPosts.toString() ?? "",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600 ,color: AppColor.black),),
                                                  const Text(AppString.post,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600 ,color: AppColor.black),),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  InkWell(
                                                      onTap: (){
                                                        print(widget.userDeatils["FollowingId"].toString());
                                                        print(snapshot.data!.data.profile.userId.toString());

                                                        showModalBottomSheet(
                                                          context: context,
                                                          enableDrag: true,
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                                          showDragHandle: true,
                                                          builder: (context) {
                                                            return AllFollowersShow(userId: snapshot.data!.data.profile.userId.toString());
                                                          },
                                                        );
                                                      }
                                                      ,child: Text(snapshot.data!.data.profile.followersCount.toString(),style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600 ,color: AppColor.black),)),
                                                  const Text(AppString.following,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600 ,color: AppColor.black),),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  InkWell(
                                                      onTap: (){
                                                        showModalBottomSheet(
                                                          context: context,
                                                          enableDrag: true,
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                                          showDragHandle: true,
                                                          builder: (context) {
                                                            return AllFollowingShow(userId: snapshot.data!.data.profile.userId.toString());
                                                          },
                                                        );
                                                      }
                                                     , child: Text(snapshot.data!.data.profile.followingCount.toString(),style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600 ,color: AppColor.black),)),
                                                  const Text(AppString.following,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600 ,color: AppColor.black),),
                                                ],
                                              )
                                            ],
                                          ),

                                        )
                                      ],
                                    ),

                                  ),
                                  Text(snapshot.data!.data.profile.name.toString(),style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600 ,color: AppColor.black),),
                                  Container(
                                    constraints: const BoxConstraints(
                                        maxWidth: 169
                                    ),
                                    child: Text(snapshot.data!.data.profile.about.toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      children: [

                                        Expanded(
                                             child: FollowButton(
                                               snapshot: snapshot.data,
                                               value: value,
                                             )),
                                        const SizedBox(width: 5,),
                                        Expanded(child:Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.grey.shade600
                                          ),
                                          child: const Center(child: Text(AppString.shareProfile,
                                            style: TextStyle(color: AppColor.white, fontWeight: FontWeight.bold),)),
                                        )),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: GridView.builder(
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3, // Number of columns in the grid
                                          crossAxisSpacing: 2.0, // Spacing between columns
                                        mainAxisSpacing: 2.0, // Spacing between rows
                                      ),
                                      itemCount: snapshot.data!.data.profile.posts.length, // Number of items in the grid
                                      itemBuilder: (BuildContext context, int index) {
                                        // Function that returns a widget for a given index
                                        return InkWell(
                                            onTap: (){
                                              Map<String,dynamic> post ={
                                                "User_Name":snapshot.data!.data.profile.name,
                                                "userId":snapshot.data!.data.profile.userId,
                                                "Post_Id":snapshot.data!.data.profile.posts[index].id.toString(),
                                              };
                                              Navigator.pushNamed(context, RoutesName.myParticularPostView,arguments:{
                                                "post":post
                                              } );
                                            },
                                            child: postContainer(snapshot.data!.data.profile.posts[index].content.toString()));
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },)


              ],
            ),
          ),
    );
  }
  Widget myContainer(String text) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: text == AppString.follow ?AppColor.homeScreenAppBar :Colors.grey.shade600
      ),
      child: Center(child: Text(text,
        style: const TextStyle(color: AppColor.white, fontWeight: FontWeight.bold),)),
    );
  }
  Widget postContainer(var img){
    return Container(
      height:270 ,
      decoration: BoxDecoration(
          border: Border.all(width: 0.5,color: Colors.grey),
        borderRadius: BorderRadius.circular(5)
      ),
      child: CachedNetworkImage(
        imageUrl: img.isNotEmpty || img != null? img :"https://appinventiv.com/wp-content/themes/twentynineteen-child/images/img2019.webp",fit: BoxFit.fill,errorWidget: (q,w,e){
        return Image.network("https://appinventiv.com/wp-content/themes/twentynineteen-child/images/img2019.webp",fit: BoxFit.fill,);
      },),
    );
  }
}