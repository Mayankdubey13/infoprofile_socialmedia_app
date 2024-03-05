class FetchPostLike {
  int statusCode;
  String type;
  List<LikeData> data;

  FetchPostLike({required this.statusCode, required this.type, required this.data});

  factory FetchPostLike.fromJson(Map<String, dynamic> json) {
    return FetchPostLike(
      statusCode: json['statusCode'],
      type: json['type'],
      data: (json['data'] as List)
          .map((item) => LikeData.fromJson(item))
          .toList(),
    );
  }
}

class LikeData {
  String id;
  String createdAt;
  String userName;
  String displayPicture;
  String name;

  LikeData({
    required this.id,
    required this.createdAt,
    required this.userName,
    required this.displayPicture,
    required this.name,
  });

  factory LikeData.fromJson(Map<String, dynamic> json) {
    return LikeData(
      id: json['_id'],
      createdAt: json['createdAt'],
      userName: json['userName'],
      displayPicture: json['displayPicture'],
      name: json['name'],
    );
  }
}
