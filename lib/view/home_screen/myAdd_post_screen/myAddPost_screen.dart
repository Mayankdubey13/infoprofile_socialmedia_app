import 'package:demo_project/res/components/round_button.dart';
import 'package:demo_project/view_model/home_screen_provider/myAddPost_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../res/app_colors.dart';
import '../../../utils/utils.dart';


class MyAddPostScreen extends StatefulWidget{
  const MyAddPostScreen({super.key});

  @override
  State<MyAddPostScreen> createState() => _MyAddPostScreenState();
}

class _MyAddPostScreenState extends State<MyAddPostScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.homeScreenAppBar,
        centerTitle: true,
        leading: Consumer<MyAddPostScreenProvider>(
          builder: (context, val, ch) {
            return InkWell(
              onTap: (){
                val.pickedImage = null;
                val.isPicked = false;
                Navigator.pop(context);
              },
                child: const Icon(Icons.arrow_back_ios_new_sharp, color: AppColor.white,));
          }
        ),
        title: Text("Add Post",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: AppColor.white),),
      ),
      body: SingleChildScrollView(
        child: Consumer<MyAddPostScreenProvider>(builder: (context,value, child) {
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
             // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: value.text,
                  maxLines: 4,
                  focusNode: value.textFocus,
                  onFieldSubmitted: (values){
                    Utils.fieldFocusNode(context, value.textFocus, value.buttonFocusNode);
                  },
                  style: const TextStyle(fontSize: 15),
                  decoration: const InputDecoration(
                    hintText: "What's on your mind?",
                    contentPadding: EdgeInsets.all(10),
                    isDense: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColor.fadeBlack
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColor.homeScreenAppBar
                        )
                    ),
                  ),
                ),
                const SizedBox(height: 4,),
                Stack(
                  children: [
                    Container(
               width: double.infinity,
                    //   height: 250,
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.5,
                        maxWidth: MediaQuery.of(context).size.width,
                      ),
                      child: value.isPicked? Image.file(value.pickedImage!,fit: BoxFit.fill,) : const SizedBox(),
                    ),
                    InkWell(
                      onTap:() {
                        value.pickedImage = null;
                        value.isPicked = false;
                        value.notifyListeners();
                      },
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Icon(Icons.cancel_outlined,color: Colors.grey.shade200,size: 30,)),
                    )
                  ],
                ),
              //  const SizedBox(height: 10,),
                Column(
                  children: [
                    InkWell(
                      onTap: () async{
                        // final SharedPreferences sp = await SharedPreferences.getInstance();
                        // String? token = sp.getString("token");
                        // print(token);
                        await value.fetchFromCamera();
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.camera_alt_rounded,color: AppColor.fadeBlack,size: 35,),
                          SizedBox(width:3,),
                          Text("Camera",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600 ,color: AppColor.black),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5,),
                    InkWell(
                      onTap: () async{
                          await value.fetchFromGallery();
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.photo_library,color: AppColor.fadeBlack,size: 35,),
                         SizedBox(width: 3,),
                          Text("Gallery",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600 ,color: AppColor.black),)

                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Center(
                  child: RoundButton(
                      text: "Post",
                      width: 130.0,
                      loading:  value.Loading,
                      focusNode: value.buttonFocusNode,
                      onPress: ()async{
                        value.setLoading(true);

                        value.addPostApi(context);
                       // value.text.clear();
                        // print("Api Hit");
                        debugPrint("Api Hit");
  //  Utils.toastMessage("Api Hit");
                       // await Future.delayed(const Duration(seconds: 1));
                        //value.setLoading(false);
                  }),
                )
              ],
            ),
          );
        },),
      ),
    );
  }

}