import 'dart:io';

import 'package:demo_project/respository/profile_repo.dart';
import 'package:demo_project/utils/_app_helper/app_prefrences.dart';
import 'package:demo_project/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../aws/aws_upload.dart';
import '../../../models/fetchPostComment.dart';
import '../../../respository/auth_respository.dart';

class EditProfileViewProvider extends ChangeNotifier{
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  ProfileRepo profileRepo = ProfileRepo();
  final _myRepo = AuthRespository();


  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }
  FocusNode buttonFocusNode = FocusNode();

  bool isPicked = false;
  File? pickedImage;

  String? _imgUrl;
  String get imgUrl => _imgUrl!;

  fetchFromCamera() async {
    await requestPermission().then((value) async{
      await fetchImage(ImageSource.camera);
      notifyListeners();
    }).onError((error, stackTrace){
      debugPrint("Error while fetchFromCamera : $error");
    });
  }

  fetchFromGallery() async {
    await requestPermission().then((value) async {
      await fetchImage(ImageSource.gallery);
      notifyListeners();
    }).onError((error, stackTrace){
      debugPrint("Error while fetchFromGallery : $error");
    });
  }

  fetchImage(ImageSource source) async {
    try {
      XFile? pickImage = await ImagePicker().pickImage(
          source: source, maxHeight: 200, maxWidth: 300);
      if (pickImage == null) return;
      final tmpImage = File(pickImage.path);
      pickedImage = tmpImage;
      isPicked = true;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> requestPermission() async {
    PermissionStatus status = await Permission.camera.request();
  }

  Future<void> uploadImage() async {

    if (!isPicked) {
      return debugPrint("Image not Picked");
    } else {
      String? userid = await AppPreferences.getUserId();
      _imgUrl = await S3Services().upload(file: pickedImage!, userid: userid!);
    }
  }


  Future ediProfile() async {
    if(isPicked){
      await uploadImage();
    }
    dynamic data = {
      if(usernameController.text.trim().isNotEmpty) "name": usernameController.text.trim(),
      if(bioController.text.trim().isNotEmpty) "about": bioController.text.trim(),
      if(isPicked) "displayPicture": imgUrl,
    };
    await profileRepo.editProfileApi(data,).then((value) async {
      Utils.toastMessage("Your profile is edit");
      // debugPrint("Profile Updated Successfully in view model response is:$value");

      bioController.clear();
      usernameController.clear();
      pickedImage = null;
      isPicked = false;
    }).onError((error, stackTrace){
      // debugPrint("Profile Updated failed in view model error is:$error");
      pickedImage = null;
      isPicked = false;
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    bioController.dispose();
    pickedImage=null;
    isPicked = false;
    super.dispose();
  }
}