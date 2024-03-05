import 'package:demo_project/view_model/home_screen_provider/mySearchScreenProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../res/app_colors.dart';
import '../../../utils/routes/routes_name.dart';

class MySearchScreen extends StatefulWidget{
  const MySearchScreen({super.key});

  @override
  State<MySearchScreen> createState() => _MySearchScreenState();
}

class _MySearchScreenState extends State<MySearchScreen> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar (
         backgroundColor: AppColor.homeScreenAppBar,
         title:Consumer<MySearchScreenprovider>(builder: ( context,  value, child) {
           return  SizedBox(
             height: 40,
             child: TextFormField(
               controller: value.controller,
               onChanged: value.onChanged,
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
                   contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                   filled: true,
                   fillColor: AppColor.white,
                   hintText: "Search",
                   hintStyle: TextStyle(color: AppColor.black),
                   prefixIcon: Icon(Icons.search,color: AppColor.black,)
               ),
             ),
           );
         },)
       ),
       body: Consumer<MySearchScreenprovider>(
         builder: (context, value, child) {
           return FutureBuilder(
             future:value.onChanged(value.controller.text.toString().trim()),
             builder: (context, snap){
               if(MySearchScreenprovider.res != null){
                 return ListView.builder(
                  itemCount: MySearchScreenprovider.res!.data.length,
                     itemBuilder: (context, index) {
                     Map<String, dynamic> ress = {};
                     ress['User_Name'] = MySearchScreenprovider.res!.data[index].name;
                     ress['UserId'] = MySearchScreenprovider.res!.data[index].id;
                     ress['FollowingId'] = MySearchScreenprovider.res!.data[index].id;
                     return
                         Column(
                           children: [
                             SizedBox(
                               height: 60,
                               width: double.infinity,
                               child: ListTile(
                                 onTap: (){

                                   Navigator.pushNamed(context, RoutesName.specificUserScreen, arguments: {"UserDetail":ress});
                                  value.controller.clear();
                                 },
                                 leading: CircleAvatar(
                                   backgroundColor: AppColor.homeScreenAppBar,
                                   radius: 25,
                                 ),
                                 title: Text(MySearchScreenprovider.res!.data[index].name ?? ""),

                     ),
                             ),
                             Padding(
                               padding: const EdgeInsets.symmetric(horizontal: 10),
                               child: Divider(
                                 height: 2,
                                 color: AppColor.fadeBlack,
                               ),
                             )
                           ],
                         );
                   }
                 );
               }
             return Container();
           },);
         }
       )
     );
  }

}