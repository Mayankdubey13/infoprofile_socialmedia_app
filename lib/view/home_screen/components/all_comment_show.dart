import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project/view_model/fetchPostCommentProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../res/app_colors.dart';
import '../../../utils/_app_helper/app_prefrences.dart';
import '../../../utils/utils.dart';

class AllCommentShow extends StatefulWidget {
  final String postId;
  final String postedById;
  const AllCommentShow({super.key,required this.postId, required this.postedById});
  @override
  State<AllCommentShow> createState() => _AllCommentShowState();
}

class _AllCommentShowState extends State<AllCommentShow> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  String? userId;

  loadData() async {
    userId =  await AppPreferences.getUserId();
  }

  @override

  Widget build(BuildContext context) {
    return Consumer<FetchPostCommentProvider>(
      builder: (context, value , ch) {
        return Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: value.getCommentApi(widget.postId.toString()),
                  builder: (context,snapshot)
                  {
                    if(snapshot.hasData){
                      return ListView.builder(
                        itemCount: snapshot.data!.data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 15, right: 5,top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: ClipOval(
                                              child: CachedNetworkImage(
                                                imageUrl: snapshot.data!.data[index].user.displayPicture,fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    snapshot.data!.data[index].user.name,
                                                    style: TextStyle(
                                                      color: AppColor.black,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  SizedBox(width:4),
                                                  Text(
                                                    "${snapshot.data!.data[index].createdAt.substring(0,10)} At ${snapshot.data!.data[index].createdAt.substring(12,16)}",
                                                    style: TextStyle(
                                                      color: AppColor.fadeBlack,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            Text(snapshot.data!.data[index].comment)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    (userId == snapshot.data!.data[index].userId)?
                                    PopupMenuButton(
                                      icon: Icon(Icons.more_vert, color: AppColor.black, size: 22,),
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: 1,
                                          child: ListTile(
                                            onTap: () {
                                              print(snapshot.data!.data[index].commentId);
                                              Navigator.pop(context);
                                              showMyDialog(context,"Delete the Post" ,snapshot.data!.data[index].commentId);
                                            },
                                            title: Text("Delete", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                            trailing: Icon(Icons.delete_forever, color: AppColor.black, size: 21,),
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: 2,
                                          child: ListTile(
                                            onTap: () {
                                              Navigator.pop(context);
                                              showMyDialog(context,"Edit the Post",snapshot.data!.data[index].commentId,previousComment: snapshot.data!.data[index].comment);
                                            },
                                            title: Text("Edit", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                            trailing: Icon(Icons.edit, color: AppColor.black, size: 21,),
                                          ),
                                        ),
                                      ],
                                    ):Container()
                                  ],
                                ),

                                SizedBox(height: 10,),
                                Divider(height: 2,color: AppColor.fadeBlack,)
                              ],
                            ),
                          );
                        },
                      );
                    }
                    else{
                      return  const Center(child: CircularProgressIndicator());
                    }
                  }



              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20,right: 8,left: 8),
                    child: TextFormField(
                      controller: value.controller,
                      //   focusNode: value.textFocus,
                      //    onFieldSubmitted: (values){
                      //      Utils.fieldFocusNode(context, value.textFocus, value.buttonFocusNode);
                      //    },
                      style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        hintText: "What's on your mind?",
                        contentPadding: EdgeInsets.all(10),
                        isDense: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)
                            ,borderSide: BorderSide(
                            color: AppColor.fadeBlack
                        )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: AppColor.homeScreenAppBar
                            )
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0,bottom: 20),
                  child: InkWell(
                    onTap: ()async{
                      Map<String, dynamic> data = {
                        "comment" : value.controller.text.toString(),
                      };
                      value.addPostCommentApi(widget.postId.toString(), data, context, widget.postedById);
                      value.controller.clear();
                      // print("Api Hit");
                      debugPrint("Api Hit");
                      //  Utils.toastMessage("Api Hit");
                      await Future.delayed(const Duration(seconds: 1));

                    },
                    child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColor.homeScreenAppBar,
                        child: Icon(Icons.send,color: AppColor.white,size: 30,)),
                  ),
                )
              ],
            ),
            SizedBox( height: MediaQuery.of(context).viewInsets.bottom,)
          ],
        );
      }
    );
  }

   showMyDialog  ( BuildContext context,String title, String commentID,{String? previousComment})async{
    return showDialog(context: context, builder:(BuildContext context){
      return Consumer<FetchPostCommentProvider>(builder: (context, value, child) {
        value.editController.text = previousComment ?? "";
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 7),
                child: Text("$title",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
              ),
              title == "Edit the Post"?
              Column(
                children: [
                 SizedBox(height: 15,),
                  TextFormField(
                    controller: value.editController,
                    //    onChanged: value.onChanged,
                    style: TextStyle(color: AppColor.black),
                    decoration:  InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                              color: AppColor.fadeBlack
                          ),
                        ),
                        focusedBorder:OutlineInputBorder(

                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                              color: AppColor.homeScreenAppBar
                          ),
                        ) ,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                        filled: true,
                        fillColor: Colors.white38,
                     //   hintText: "Search",
                       // hintStyle: TextStyle(color: AppColor.black),
                       // prefixIcon: Icon(Icons.search,color: AppColor.black,)
                    ),
                  ),
                ],
              ):Container(),
            ],
          ),

          actions: [
            InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Text("No",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.grey.shade700),)),
            SizedBox(width: 20,),
            title == "Edit the Post"?
            InkWell(
                onTap: ()async{
                  value.editCommentApi( commentID, context).then((value) {

                    Utils.toastMessage("Comment Edit SucessFully");
                    Navigator.pop(context);
                   // Navigator.of(context).popUntil((route) => route.isFirst);
                 //   Navigator.of(context).popUntil((route) => route.isFirst);
                  });
                },
                child: Text("Yes",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),))
                :
            InkWell(
                onTap: ()async{
                value.deleteCommentApi(commentID, context).then((value) {

                  Utils.toastMessage("Comment Delete SucessFully");

                  Navigator.pop(context);
                 // Navigator.of(context).popUntil((route) => route.isFirst);
                });
                },
                child: Text("Yes",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),))

          ],
        );
      },);

    }
    );
  }
}



// function.then((value){
// // If the API call is successful, update the state
// //  Utils.toastMessage("This Comment is delete Sucessful");
//  Utils.toastMessage("Sucess");
//  Navigator.of(context).popUntil((route) => route.isFirst);
// }