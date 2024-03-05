class PostResponse {
  int statusCode;
  String type;
  List<PostItem> posts;

  PostResponse({required this.statusCode, required this.type, required this.posts});

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
      statusCode: json['statusCode'],
      type: json['type'],
      posts: (json['data']['post'] as List)
          .map((item) => PostItem.fromJson(item))
          .toList(),
    );
  }
}

class PostItem {
  String id;
  String userId;
  String content;
  String caption;
  bool status;
  String createdAt;
  String updatedAt;
  User user;
  int commentCount;
  int likesCount;
  int liked;

  PostItem({
    required this.id,
    required this.userId,
    required this.content,
    required this.caption,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.commentCount,
    required this.likesCount,
    required this.liked,
  });

  factory PostItem.fromJson(Map<String, dynamic> json) {
    return PostItem(
      id: json['_id'],
      userId: json['userId'],
      content: json['content'],
      caption: json['caption'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      user: User.fromJson(json['user']),
      commentCount: json['commentCount'],
      likesCount: json['likesCount'],
      liked: json['liked'],
    );
  }
}

class User {
  String id;
  String name;
  String email;
  String userName;
  String displayPicture;
  String about;
  int v;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.userName,
    required this.displayPicture,
    required this.about,
    required this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      userName: json['userName'],
      displayPicture: json['displayPicture'],
      about: json['about'],
      v: json['__v'],
    );
  }
}
