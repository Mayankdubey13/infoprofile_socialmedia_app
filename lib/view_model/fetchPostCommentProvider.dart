import 'package:demo_project/models/fetchPostComment.dart';
import 'package:demo_project/utils/_app_helper/app_prefrences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/fetchPostLike.dart';
import '../respository/auth_respository.dart';
import '../respository/comment_repo.dart';
import '../utils/utils.dart';

class FetchPostCommentProvider extends ChangeNotifier{
  TextEditingController controller = TextEditingController();
  TextEditingController editController = TextEditingController();
  final _myRepo = CommentRepo();

  static String userId = "";

  FetchPostComment ? user;
  Future<FetchPostComment> getCommentApi(String postId) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");
    // String ?userId = sp.getString("userId");
    debugPrint("$token      ----=----------,");
    final response = await _myRepo.getCommentApi(postId.toString(),token.toString());
    debugPrint("------------------------------------$response");
    //   debugPrint(response["data"]["post"][0]["name"]);
    try {
      user = FetchPostComment.fromJson(response);
      // debugPrint("------------->${user.data.posts[0].user.name}");
      // return response;
    }
    catch(e){
      debugPrint("===========$e");
    }
    notifyListeners();
    return user!;
  }
  Future<void> addPostCommentApi(String postId,dynamic data,BuildContext context, String postedById) async{

    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");
    debugPrint(token);

    _myRepo.addPostCommentApi(postId,data, token!, postedById).then((value){
     // setLoading(false);
      debugPrint("addPost Successfull $value");
      Utils.hideKeyboard(context);
      Utils.toastMessage("SucessFull Comment Post");
      // Navigator.pushNamed( context, RoutesName.otpAuthenticationScreen, arguments: {'email': emailController.text.toString().trim()});
    }).onError((error, stackTrace) {
      // setLoading(false);
      if (kDebugMode)
        Utils.toastMessage(error.toString());
    });
    }

  Future<void> deleteCommentApi(dynamic commentId, BuildContext context) async {


    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      String? token = sp.getString("token");
      await _myRepo.deleteCommentApi( commentId.toString(), token.toString());
      //     .then((value) {
      //   // If the API call is successful, update the state
      //   Utils.toastMessage("This Comment is delete Sucessful");
      //   Navigator.of(context).popUntil((route) => route.isFirst);
      // });

      // setIsLike();
    } catch (error) {
      // Handle the error, e.g., show a toast or log it
      Utils.toastMessage(error.toString());
      debugPrint(error.toString());
    }
  }
  Future<void> editCommentApi(String commentId,BuildContext context) async{
    //setSignUpLoading(true);
   // debugPrint("Data is $data");
    Map<String,dynamic> data =
      {
        "comment": editController.text.trim().toString()
      }
    ;
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");
    _myRepo.editCommentApi(data,commentId,token.toString()).then((value) {
      //setLoading(false);
      editController.clear();
      debugPrint("This Comment is Edit Successful");
     // Navigator.of(context).popUntil((route) => route.isFirst);
    }).onError((error, stackTrace){
     // setLoading(false);
      if(kDebugMode) {
        Utils.toastMessage(error.toString());
        //  print( "Error occur in api call in SignUpScreen Provider$error");
      }
    });
  }
}