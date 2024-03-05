class FeedProfile {
  int statusCode;
  String type;
  List<FeedItem> feed;

  FeedProfile({required this.statusCode, required this.type, required this.feed});

  factory FeedProfile.fromJson(Map<String, dynamic> json) {
    return FeedProfile(
      statusCode: json['statusCode'],
      type: json['type']??"",
      feed: (json['data']['feed'] as List<dynamic>?)
          ?.map((item) => FeedItem.fromJson(item as Map<String, dynamic>))
          .toList() ?? [],
    );
  }
}

class FeedItem {
  String id;
  String userId;
  String followingId;
  FollowedPosts followedPosts;
  User user;
  int liked;
  int numberOfLikes;
  int numberOfComments;

  FeedItem({
    required this.id,
    required this.userId,
    required this.followingId,
    required this.followedPosts,
    required this.user,
    required this.liked,
    required this.numberOfLikes,
    required this.numberOfComments,
  });

  factory FeedItem.fromJson(Map<String, dynamic> json) {
    return FeedItem(
      id: json['_id']??"",
      userId: json['userId']??"",
      followingId: json['followingId']??"",
      followedPosts: FollowedPosts.fromJson(json['followedPosts']),
      user: User.fromJson(json['user']),
      liked: json['liked'],
      numberOfLikes: json['numberOfLikes'],
      numberOfComments: json['numberOfComments'],
    );
  }
}

class FollowedPosts {
  String userId;
  String content;
  String caption;
  String createdAt;
  String postId;

  FollowedPosts({
    required this.userId,
    required this.content,
    required this.caption,
    required this.createdAt,
    required this.postId,
  });

  factory FollowedPosts.fromJson(Map<String, dynamic> json) {
    return FollowedPosts(
      userId: json['userId']??"",
      content: json['content']??"",
      caption: json['caption']??"",
      createdAt: json['createdAt']??"",
      postId: json['postId']??"",
    );
  }
}

class User {
  String id;
  String name;
  String userName;
  String displayPicture;

  User({
    required this.id,
    required this.name,
    required this.userName,
    required this.displayPicture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id']??"",
      name: json['name']??"",
      userName: json['userName']??"",
      displayPicture: json['displayPicture']??"",
    );
  }
}
