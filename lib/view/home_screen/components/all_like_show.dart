
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project/models/fetchPostLike.dart';
import 'package:demo_project/res/app_image_url.dart';
import 'package:demo_project/view_model/fetchPostLikeProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../res/app_colors.dart';
import '../../../utils/utils.dart';

class AllLikeShow extends StatefulWidget{

  String postId;
   AllLikeShow({super.key,required this.postId});

  @override
  State<AllLikeShow> createState() => _AllLikeShowState();
}

class _AllLikeShowState extends State<AllLikeShow> {
  @override
  Widget build(BuildContext context) {
     return  Container(
       child: Consumer<FetchPostLikeProvider>(
         builder: (context, value, child) {
       return FutureBuilder<FetchPostLike>(
           future: value.getlikeApi(widget.postId.toString()),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator(color: Colors.black));
      } else if (snapshot.hasError) {
        print('Error: ${snapshot.error}');
        return const Center(child: Text('Error loading data'));
      } else if (snapshot.data == null) {
        return const CircularProgressIndicator();
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
                  const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(top:5),
                      child: Row(
                        children: [
                          Text(snapshot.data!.data[index].name.toString(), style: const TextStyle(color: AppColor.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 15)),
                          const SizedBox(width: 4,),
                          Text("${Utils.formatDateTime(snapshot.data!.data[index].createdAt)}", style: const TextStyle(
                              color: AppColor.fadeBlack,
                              fontWeight: FontWeight.w600,
                              fontSize: 12))
                        ],
                      ),
                    ),


                  ],
                ),
                const SizedBox(height: 10,),
                const Divider(height: 2, color: AppColor.fadeBlack,)
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




