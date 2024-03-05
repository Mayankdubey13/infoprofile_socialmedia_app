import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project/models/fetchNotification.dart';
import 'package:demo_project/utils/routes/routes_name.dart';
import 'package:demo_project/view_model/home_screen_provider/notification_screen_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../res/app_colors.dart';
import '../../res/app_image_url.dart';
import '../../res/app_string.dart';
import '../../utils/utils.dart';

class NotificationScreen extends StatefulWidget{
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
  return   Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: const Text(AppString.notificationHeader,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: AppColor.white),),
      backgroundColor: AppColor.homeScreenAppBar,
    leading: InkWell(
    onTap: () {
    Navigator.pop(context);
    },
    child: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
    ),
    ),
        body:RefreshIndicator(
          onRefresh: ()async{
            setState(() {

            });
          },
          child: Consumer<NotificationScreenProvider>(builder: (context, value, child) {
            return FutureBuilder<ApiResponseNotificationsModel?>(
                key: const PageStorageKey<String>('postViewPath'),
                future: value.getNotificationApi(),
                builder: (context,snapshot){
               if(snapshot.hasData){
                 return ListView.builder(
                     itemExtent:50,
                     itemCount:snapshot.data!.data!.length,
                     // itemCount: 20,
                     itemBuilder: (context,index){
                       final notificationList = snapshot.data!.data!;
                   return Padding(
                     padding: const EdgeInsets.only(left: 15),
                     child: InkWell(
                       // onTap: (){
                       //   String actionId = notificationList[index].actionId!.toString();
                       //   if(notificationList[index].type == "like" || notificationList[index].type == "comment"){
                       //     Navigator.pushNamed(context, RoutesName.myParticularPostView, arguments: {
                       //       "post":actionId
                       //     });
                       //   }
                       //   else  if(notificationList[index].type == "startedFollowing"){
                       //     Navigator.pushNamed(context, RoutesName.specificUserScreen, arguments: {
                       //       "UserDetail":actionId
                       //     });
                       //   }
                       //
                       // },
                       onLongPress: (){
                         showMyDialog(context,"Delete this Notification" ,notificationList[index].id!,);
                       },
                       child: Row(
                         children: [
                           SizedBox(
                             height: 40,
                             width: 40,
                             child: ClipOval(
                               child: CachedNetworkImage(
                                 imageUrl: notificationList[index].notificationData!.displayPicture.toString(),
                               ),
                             ),
                           ),
                           const SizedBox(width: 8),
                           Text("${notificationList[index].notificationData!.name} ",style: const TextStyle(fontWeight:FontWeight.w500,fontSize: 15,color: AppColor.black),),
                         //  const SizedBox(width: 5,),
                           Text("${notificationList[index].message}",style: const TextStyle(fontSize: 15,color: AppColor.fadeBlack),)
                         ],
                       ),
                     ),
                   )   ;


                 });
               }
               else{
                 return Center(
                 child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       CircularProgressIndicator(color: AppColor.blueAccent,),
                     ],
                   ),
               );
               }
                });
          },

          ),
        )
    );
  }
  Future<void> showMyDialog(BuildContext context,String title,String notificationId)async{
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
          Consumer<NotificationScreenProvider>(builder: (context, value,  child) {
            return  InkWell(
                onTap: ()async{
    value.deleteNotificationApi (notificationId, context).then((value) {

    Utils.toastMessage("Notification Delete SucessFully");
    Navigator.pop(context);
    // Navigator.of(context).popUntil((route) => route.isFirst);
    //   Navigator.of(context).popUntil((route) => route.isFirst);
    });
    },

    child: const Text("Yes",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),)

    );

          },)

        ],
      );

    }
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}


