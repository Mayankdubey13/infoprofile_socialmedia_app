// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../models/userParticularPostResponse.dart';
// import '../../../respository/auth_respository.dart';
// import '../../../utils/utils.dart';
// import '../../user_view_model.dart';
//
// class SpecificUserParticularPostScreenProvider extends ChangeNotifier{
//
//   final _myRepo = AuthRespository();
//   String? name;
//   bool _isLikingOrUnliking = false;
//
//   bool get isLikingOrUnliking => _isLikingOrUnliking;
//
//   void setLikingOrUnliking(bool value) {
//     _isLikingOrUnliking = value;
//     notifyListeners();
//   }
//
//   Future<String?> getUserName() async {
//     try {
//       name = await UserViewModel().getName();
//       return name;
//     } catch (error) {
//       print("Error fetching username: $error");
//       return null; // or return a default username
//     }
//   }
//
//
//   bool isLike = false;
//
//   void setIsLike() {
//     isLike = !isLike;
//     notifyListeners();
//   }
//   Future<void> likePostApi(dynamic postId, BuildContext context) async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     String? token = sp.getString("token");
//
//     try {
//       await _myRepo.likePostApi(postId.toString(), token.toString());
//       // If the API call is successful, update the state
//     //  setIsLike();
//     } catch (error) {
//       // Handle the error, e.g., show a toast or log it
//       Utils.toastMessage(error.toString());
//       print(error.toString());
//     }
//   }

//   Future<void> unLikePostApi(dynamic postId, BuildContext context) async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     String? token = sp.getString("token");
//
//     try {
//       await _myRepo.unLikePostApi(postId.toString(), token.toString());
//       // If the API call is successful, update the state
//   //    setIsLike();
//     } catch (error) {
//       // Handle the error, e.g., show a toast or log it
//       Utils.toastMessage(error.toString());
//       print(error.toString());
//     }
//   }
//
//
//   Future<PostResponse> getSpecificUserParticularPostApi(String postId) async {
//     PostResponse ? user;
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     String? token = sp.getString("token");
//     // String ?userId = sp.getString("userId");
//     print("$token      ----=----------,");
//     final response = await _myRepo.getSpecificUserParticularPostApi(postId.toString(),token.toString());
//     print("------------------------------------$response");
//    // debugPrint(response["data"]["post"][0]["name"]);
//     try {
//       user = PostResponse.fromJson(response!);
//       debugPrint("------------->${user.posts[0].user.name}");
//       // return response;
//     }
//     catch(e){
//       print("===========$e");
//     }
//     return user!;
//   }
//
// }
