class FetchPostComment {
  int statusCode;
  String type;
  List<CommentData> data;

  FetchPostComment({required this.statusCode, required this.type, required this.data});

  factory FetchPostComment.fromJson(Map<String, dynamic> json) {
    return FetchPostComment(
      statusCode: json['statusCode'],
      type: json['type'],
      data: (json['data'] as List)
          .map((item) => CommentData.fromJson(item))
          .toList(),
    );
  }
}

class CommentData {
  String userId;
  String postId;
  String comment;
  String createdAt;
  UserData user;
  String commentId;

  CommentData({
    required this.userId,
    required this.postId,
    required this.comment,
    required this.createdAt,
    required this.user,
    required this.commentId,
  });

  factory CommentData.fromJson(Map<String, dynamic> json) {
    return CommentData(
      userId: json['userId'],
      postId: json['postId'],
      comment: json['comment'],
      createdAt: json['createdAt'],
      user: UserData.fromJson(json['user']),
      commentId: json['commentId'],
    );
  }
}

class UserData {
  String name;
  String userName;
  String displayPicture;

  UserData({
    required this.name,
    required this.userName,
    required this.displayPicture,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'],
      userName: json['userName'],
      displayPicture: json['displayPicture'],
    );
  }
}
