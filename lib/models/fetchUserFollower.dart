class FetchUserFollower {
  int statusCode;
  String type;
  List<FollowerData> data;

  FetchUserFollower({required this.statusCode, required this.type, required this.data});

  factory FetchUserFollower.fromJson(Map<String, dynamic> json) {
    return FetchUserFollower(
      statusCode: json['statusCode'],
      type: json['type']??"",
      data: (json['data'] as List)
          .map((item) => FollowerData.fromJson(item))
          .toList(),
    );
  }
}

class FollowerData {
  String userId;
  String userName;
  String name;
  String displayPicture;

  FollowerData({
    required this.userId,
    required this.userName,
    required this.name,
    required this.displayPicture,
  });

  factory FollowerData.fromJson(Map<String, dynamic> json) {
    return FollowerData(
      userId: json['userId']??"",
      userName: json['userName']??"",
      name: json['name']??"",
      displayPicture: json['displayPicture']??"",
    );
  }
}
