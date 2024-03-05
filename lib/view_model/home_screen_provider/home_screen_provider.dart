import 'package:flutter/cupertino.dart';

class HomeScreenProvider extends ChangeNotifier{

   int pageIndex = 0;

   setPageIndex(value){
    pageIndex = value;
    notifyListeners();
  }
  bool iconClr = false;

   setIconClr (){
     iconClr = !iconClr;
     notifyListeners();
   }
}