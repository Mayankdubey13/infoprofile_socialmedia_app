import 'package:flutter/cupertino.dart';

class LikePostProvider extends ChangeNotifier {
  List<bool> likes = [];

  void initializeLikes(int numberOfPosts) {
    likes = List.generate(numberOfPosts, (index) => false);
  }
  void setLike(int index) {
    if (index >= 0 && index < likes.length) {
      likes[index] = !likes[index];
      notifyListeners();
    } else {
      debugPrint("Invalid index: $index");
    }
  }
}