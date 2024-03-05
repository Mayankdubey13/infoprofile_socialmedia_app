import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project/res/app_colors.dart';
import 'package:demo_project/utils/utils.dart';
import 'package:demo_project/view_model/home_screen_provider/myProfile_screen_provider/editProfileViewProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/app_text_form_field.dart';
import '../../../res/app_image_url.dart';
import '../../../res/app_string.dart';
import '../../../res/components/round_button.dart';
class EditProfileView extends StatefulWidget{
  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.homeScreenAppBar,
        centerTitle: true,
        title: const Text(AppString.editProfileHeader, style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: AppColor.white),),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new_sharp, color: AppColor.white,)),

      ),
      body:  SingleChildScrollView(
          child: Center(
            child: Consumer<EditProfileViewProvider>(
                builder: (context, provider, ch) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Form(
                      key: provider.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 20,),
                          InkWell(
                            onTap: () {
                              provider.fetchFromGallery();
                            },
                            child: (provider.isPicked) ? SizedBox(
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(provider.pickedImage!, fit: BoxFit.fill,),
                              ),
                            ) : CircleAvatar(
                              radius: 50,
                              //backgroundColor: Theme.of(context).primaryColor,
                            ),
                          ),
                         SizedBox(height: 10,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Expanded(
                                  flex: 2,
                                  child: Text("Name")),
                            SizedBox(height: 10,),
                              Expanded(
                                flex: 6,
                                child: AppTextFormField(
                                  obscureText: false,
                                  cont: provider.usernameController,
                                  isPrefixIconExist: false,
                                  contentPadding: 10,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              const Expanded(
                                  flex: 2,
                                  child: Text("Bio")),
                           SizedBox(height: 10,),
                              Expanded(
                                flex: 6,
                                child: TextFormField(
                                  controller: provider.bioController,
                                  maxLines: null,
                                  onFieldSubmitted: (value){
                                    // Utils.changeFocus(context, currentFocus, nextFocus);
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20),), borderSide: BorderSide(width: 2, color: AppColor.black),),
                                    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all( Radius.circular(20),), borderSide: BorderSide(width: 2, color: AppColor.black),),
                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20),), borderSide: BorderSide(width: 2, color: AppColor.black),),
                                  ),
                                ),
                              )
                            ],
                          ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: RoundButton(text: "Save",loading: provider.loading,focusNode: provider.buttonFocusNode,
                            width: 140.0,
                            onPress: () async {
                              Utils.hideKeyboard(context);
                              behavior: HitTestBehavior.translucent;
                                provider.setLoading(true);
                                //
                                // print(data);
                                 provider.ediProfile();
                                // debugPrint("Api Hit");
                                await Future.delayed(const Duration(seconds: 1));
                                provider.setLoading(false);
                              }

                            ),
                        ),
                        ],
                      ),
                    ),
                  );
                }
            ),
          ),
        )
    );
  }
}