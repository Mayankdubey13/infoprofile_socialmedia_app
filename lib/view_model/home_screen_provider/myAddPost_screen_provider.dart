import 'dart:io';
import 'package:demo_project/aws/aws_upload.dart';
import 'package:demo_project/respository/post_repo.dart';
import 'package:demo_project/utils/_app_helper/app_prefrences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../respository/auth_respository.dart';
import '../../utils/utils.dart';

class MyAddPostScreenProvider extends ChangeNotifier{
  final _myRepo = AuthRespository();
  PostRepo postRepo = PostRepo();
  TextEditingController text = TextEditingController();
  FocusNode textFocus = FocusNode();
  FocusNode buttonFocusNode = FocusNode();

  bool _Loading = false;
  bool get Loading =>_Loading;

  void setLoading (bool element){
    _Loading=element;
    notifyListeners();
  }

  bool isPicked = false;
  File? pickedImage;

  String? _imgUrl = "https://lh3.googleusercontent.com/p/AF1QipOc4D_FziIEFMON03VmBkBcIbZJCVhRNgdbwuoJ=s1360-w1360-h1020";
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
          source: source);
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


  Future<void> addPostApi(BuildContext context) async{

    String id = await AppPreferences.getUserId();
    if(!isPicked) return;
    String? url = await S3Services().upload(file: pickedImage!, userid: id);
    //setSignUpLoading(true);
    Map<String, dynamic> data = {
      "content" : url,
      "caption" : text.text.toString().trim()
    };

    debugPrint("Data is $data");

    final SharedPreferences sp = await SharedPreferences.getInstance();
     String? token = sp.getString("token");
     debugPrint(token);

    postRepo.addPostApi(data, token!).then((value){
      pickedImage = null;
      isPicked = false;
      text.clear();
      setLoading(false);

      debugPrint("addPost Successfull $value");

      Utils.toastMessage("SucessFull Upload Post");

     // Navigator.pushNamed( context, RoutesName.otpAuthenticationScreen, arguments: {'email': emailController.text.toString().trim()});

    }).onError((error, stackTrace){
      setLoading(false);
      if(kDebugMode) {
        Utils.toastMessage(error.toString());
        print( "Error for addPost$error");
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    pickedImage = null;
    isPicked = false;
  }
}