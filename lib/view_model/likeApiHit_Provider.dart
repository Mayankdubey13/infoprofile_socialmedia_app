import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../respository/auth_respository.dart';
import '../utils/utils.dart';
// class LikeApiHitProvider extends ChangeNotifier{
//   final _myRepo = AuthRespository();
//   bool isLike = false;
//
//   void setIsLike() {
//     isLike = !isLike;
//     notifyListeners();
//   }
//   Future<void> likePostApi (dynamic postId, BuildContext context) async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     String? token = sp.getString("token");
//
//     try {
//       await _myRepo.likePostApi(postId.toString(), token.toString());
//       // If the API call is successful, update the state
//       setIsLike();
//     } catch (error) {
//       // Handle the error, e.g., show a toast or log it
//       Utils.toastMessage(error.toString());
//       print(error.toString());
//     }
//   }
//
//   Future<void> unLikePostApi(dynamic postId, BuildContext context) async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     String? token = sp.getString("token");
//
//     try {
//       await _myRepo.unLikePostApi(postId.toString(), token.toString());
//       // If the API call is successful, update the state
//       setIsLike();
//     } catch (error) {
//       // Handle the error, e.g., show a toast or log it
//       Utils.toastMessage(error.toString());
//       print(error.toString());
//     }
//   }
// }