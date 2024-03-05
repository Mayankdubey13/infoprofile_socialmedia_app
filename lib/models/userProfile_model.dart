class UserProfile {
  int statusCode;
  String type;
  UserData data;

  UserProfile({required this.statusCode, required this.type, required this.data});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      statusCode: json['statusCode'],
      type: json['type'],
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  Profile profile;

  UserData({required this.profile});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      profile: Profile.fromJson(json['profile']),
    );
  }
}

class Profile {
  String userId;
  String name;
  String userName;
  String displayPicture;
  String about;
  int totalPosts;
  int followersCount;
  int followingCount;
  int isFollowing;
  List<Post> posts;

  Profile({
    required this.userId,
    required this.name,
    required this.userName,
    required this.displayPicture,
    required this.about,
    required this.totalPosts,
    required this.followersCount,
    required this.followingCount,
    required this.isFollowing,
    required this.posts,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    var postsList = json['posts'] as List;
    List<Post> posts =
    postsList.map((post) => Post.fromJson(post)).toList();

    return Profile(
      userId: json['userId'],
      name: json['name'],
      userName: json['userName'],
      displayPicture: json['displayPicture'],
      about: json['about'],
      totalPosts: json['totalPosts'],
      followersCount: json['followersCount'],
      followingCount: json['followingCount'],
      isFollowing: json['isFollowing'],
      posts: posts,
    );
  }
}

class Post {
  String id;
  String userId;
  String content;
  String caption;
  String createdAt;
  int liked;
  int numberOfLikes;
  int numberOfComments;

  Post({
    required this.id,
    required this.userId,
    required this.content,
    required this.caption,
    required this.createdAt,
    required this.liked,
    required this.numberOfLikes,
    required this.numberOfComments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      userId: json['userId'],
      content: json['content'],
      caption: json['caption'],
      createdAt: json['createdAt'],
      liked: json['liked'],
      numberOfLikes: json['numberOfLikes'],
      numberOfComments: json['numberOfComments'],
    );
  }
}
