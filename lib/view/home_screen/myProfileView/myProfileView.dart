import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project/models/userProfile_model.dart';
import 'package:demo_project/res/app_colors.dart';
import 'package:demo_project/res/app_image_url.dart';
import 'package:demo_project/res/app_string.dart';
import 'package:demo_project/view_model/home_screen_provider/home_screen_provider.dart';
import 'package:demo_project/view_model/home_screen_provider/myHome_screen_provider/myHome_screen_provider.dart';
import 'package:demo_project/view_model/home_screen_provider/myProfile_screen_provider/myProfile_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/routes/routes_name.dart';
import '../../../view_model/user_view_model.dart';
import '../components/all_followers_show.dart';
import '../components/all_followingShow.dart';

class
MyProfileView extends StatefulWidget{
  const MyProfileView({super.key});

  @override
  State<MyProfileView> createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> with AutomaticKeepAliveClientMixin{
  var img =AppImageUrl.postImaGE;
  @override

  Widget build(BuildContext context) {
    return  Theme(
        data: Theme.of(context).copyWith(
      canvasColor: Colors.white, // Set the canvas color of the Drawer
    ),
    child :Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppString.profileHeader,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: AppColor.white),),
        backgroundColor: AppColor.homeScreenAppBar,
        actions: [
         Consumer<HomeScreenProvider>(builder: (context, value,  child) {
           return  Padding(
             padding: const EdgeInsets.only(right: 8.0),
             child: InkWell(
                 onTap: () async{
                 //  Navigator.pop(context);
                   showMyDialog(AppString.logoutHistry);

                 },
                 child: const Icon(Icons.logout,color: AppColor.white,)),
           );
         },)
        ],
      ),
       body: RefreshIndicator(
         onRefresh: ()async{
           MyProfileScreenProvider.user = null;
           setState(() {

           });
         },
         child: Column(
           children: [
             Consumer<MyProfileScreenProvider>(
                 builder: (context, value, child) {
                   return FutureBuilder<UserProfile?>(
                     future: value.userProfile(),
                     builder: (context, snapshot) {
                     //  print(snapshot.data!.data.profile.name);
                       // Check if the future is still in progress (not completed)
                       if (snapshot.connectionState == ConnectionState.waiting) {
                         return const Expanded(
                           child: Center(child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               CircularProgressIndicator(color: Colors.black),
                             ],
                           )),
                         );
                       } else if (snapshot.hasError) {
                         // Handle error state
                         return const Center(child: Text('Error loading data'));
                       } else if (snapshot.data == null) {
                         // Data is null, return a placeholder or loading state
                         return const Expanded(
                           child: Center(
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 CircularProgressIndicator(),
                               ],
                             ),
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
                                         height: 100,
                                         width: 100,
                                         child:
                                             SizedBox(
                                                 height:100,
                                                 width:100,
                                                 child: ClipOval(child: CachedNetworkImage(imageUrl: snapshot.data!.data.profile.displayPicture.toString(),fit: BoxFit.fill,)))

                                       ),
                                       const SizedBox(width: 40,),
                                        Expanded(
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                                           children: [
                                             Column(
                                               children: [
                                                 Text(snapshot.data!.data.profile.totalPosts.toString(),style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600 ,color: AppColor.black),),
                                                 const Text(AppString.post,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600 ,color: AppColor.black),),
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
                                                           return AllFollowersShow(userId: snapshot.data!.data.profile.userId.toString());
                                                         },
                                                       );
                                                     }
                                                     ,child: Text(snapshot.data!.data.profile.followersCount.toString(),style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600 ,color: AppColor.black),)),
                                                 const Text(AppString.follower,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600 ,color: AppColor.black),),
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
                                                     ,child: Text(snapshot.data!.data.profile.followingCount.toString(),style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600 ,color: AppColor.black),)),
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
                                       Expanded(child: myContainer(AppString.editProfile)),
                                       const SizedBox(width: 5,),
                                       Expanded(child: myContainer(AppString.shareProfile)),
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

      ),
    );
  }
  Widget myContainer(String text){
    return InkWell(
      onTap: (){
        text== "Edit profile"? Navigator.pushNamed(context, RoutesName.editProfileScreen): "";
      },
      child: Container(
        height:  35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade600
        ),
        child: Center(child: Text(text,style: const TextStyle(color: AppColor.white,fontWeight: FontWeight.bold),)),
      ),
    );
  }
  Widget postContainer(var img){
    return Container(
      height: 270 ,
      decoration: BoxDecoration(
        border: Border.all(width: 0.5,color: Colors.grey),
        borderRadius: BorderRadius.circular(5)
      ),
      child:  CachedNetworkImage(
        imageUrl: img.isNotEmpty || img != null? img : "https://appinventiv.com/wp-content/themes/twentynineteen-child/images/img2019.webp",fit: BoxFit.fill,errorWidget: (q,w,e){
        return Image.network("https://appinventiv.com/wp-content/themes/twentynineteen-child/images/img2019.webp",fit: BoxFit.fill,);
      },)
    );
  }

  Future<void> showMyDialog(String title)async{
    return showDialog(context: context, builder:(BuildContext context){
      return AlertDialog(
        title: Text(title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
        actions: [
          InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Text("No",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.grey.shade700),)),
          const SizedBox(width: 20,),
          Consumer<HomeScreenProvider>(builder: (context, value,  child) {
            return  InkWell(
                onTap: ()async {
                  bool isLogout = await UserViewModel().removeUser();
                  MyHomeScreenProvider.user = null;
                  MyProfileScreenProvider.user=null;
                  if (isLogout) {
                    value.setPageIndex(0);
                    Navigator.pushNamedAndRemoveUntil(
                        context, RoutesName.signInScreen, (_) => false);
                  }
                },
                child: const Text("Yes",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),));
          },)

        ],
      );

    }
    );
  }

  @override
  bool get wantKeepAlive => true;
}






