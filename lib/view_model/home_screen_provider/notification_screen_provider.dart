

import 'package:demo_project/models/fetchNotification.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../respository/notification_repo.dart';
import '../../utils/utils.dart';

class NotificationScreenProvider extends ChangeNotifier{
  final _myRepo = NotificationRepo();
  ApiResponseNotificationsModel ? user;
  Future<ApiResponseNotificationsModel?> getNotificationApi() async {
    await _myRepo.getAllNotification().then((value){
      user = ApiResponseNotificationsModel.fromJson(value!);
    }).onError((error, stackTrace){
    //  debugPrint("------------------------------------$error");
    });
    notifyListeners();
    return user!;

  }

  Future<void> deleteNotificationApi(dynamic notificationId, BuildContext context) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");

    try {
      await _myRepo.deleteNotificationApi( notificationId.toString(), token.toString());
      // If the API call is successful, update the state
      Utils.toastMessage("This notification is delete Sucessful");
      // Navigator.of(context).popUntil((route) => route.isFirst);
      // setIsLike();
    } catch (error) {
      // Handle the error, e.g., show a toast or log it
      Utils.toastMessage(error.toString());
      print(error.toString());
    }
  }
}