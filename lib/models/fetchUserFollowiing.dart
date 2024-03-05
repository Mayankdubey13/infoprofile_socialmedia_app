class FetchUserFollowing {
  int statusCode;
  String type;
  List<UserData> data;

  FetchUserFollowing({required this.statusCode, required this.type, required this.data});

  factory FetchUserFollowing.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      // Handle the case where the input JSON is null
      return FetchUserFollowing(statusCode: 0, type: '', data: []);
    }

    var dataList = json['data'] as List?;
    List<UserData> data = (dataList != null)
        ? dataList.map((userData) => UserData.fromJson(userData as Map<String, dynamic>)).toList()
        : [];

    return FetchUserFollowing(
      statusCode: json['statusCode'] ?? 0,
      type: json['type'] ?? '',
      data: data,
    );
  }
}

class UserData {
  String userId;
  String userName;
  String name;
  String displayPicture;

  UserData({
    required this.userId,
    required this.userName,
    required this.name,
    required this.displayPicture,
  });

  factory UserData.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      // Handle the case where the input JSON is null
      return UserData(userId: '', userName: '', name: '', displayPicture: '');
    }

    return UserData(
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      name: json['name'] ?? '',
      displayPicture: json['displayPicture'] ?? '',
    );
  }
}
