import 'package:flutter/cupertino.dart';
import '../../models/search_response_model.dart';
import '../../respository/search_user_repo/search_user_repo.dart';
import '../../utils/de_bouncer/de_bouncer.dart';

class MySearchScreenprovider extends ChangeNotifier{
  TextEditingController controller = TextEditingController();

  DeBouncer deBouncer = DeBouncer(milliseconds: 200);
  final SearchUserRepository repository = SearchUserRepository();
  String searchText = "";

  static ApiResponseUserData? res;

  onChanged(String? value) {
    if(value.toString().isEmpty){
      res = null;
    }
    if(value == null || value.isEmpty) return;
    deBouncer.run(() {
      searchUser(value);
    });
  }

  Future searchUser(String value) async {
    await repository.searchUser(username: value).then((ApiResponseUserData? value){
      debugPrint("Response Received in provider ${value!.data.length}");
      res = value;
      notifyListeners();
    }).onError((error, stackTrace){
      debugPrint("Response error in provider---> $error");
      res = null;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.clear();
    res = null;
  }
}