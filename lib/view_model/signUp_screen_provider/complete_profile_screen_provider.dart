import 'package:flutter/cupertino.dart';

class CompleteProfileScreenProvider extends ChangeNotifier{
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullNameController.dispose();
    userNameController.dispose();
    dateOfBirthController.dispose();
  }
  FocusNode fullNameFocus = FocusNode();
  FocusNode userNameFocus = FocusNode();
  FocusNode dateOfBirthFocus = FocusNode();
  FocusNode buttonFocusNode = FocusNode();
  bool _Loading = false;
  bool get Loading =>_Loading;
  void setLoading (bool element){
    _Loading=element;
    notifyListeners();
  }
}