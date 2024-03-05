class ApiResponseUserData {
  final int statusCode;
  final String type;
  final List<SearchUser> data;

  ApiResponseUserData({
    required this.statusCode,
    required this.type,
    required this.data,
  });

  factory ApiResponseUserData.fromJson(Map<String, dynamic> json) {
    List<SearchUser> users = List<SearchUser>.from(
        json['data'].map((userData) => SearchUser.fromJson(userData)));

    return ApiResponseUserData(
      statusCode: json['statusCode'],
      type: json['type'],
      data: users,
    );
  }
}

class ApiResponseUser {
  final String id;
  final String name;
  final String userName;
  final String displayPicture;
  final String about;

  ApiResponseUser({
    required this.id,
    required this.name,
    required this.userName,
    required this.displayPicture,
    required this.about,
  });

  factory ApiResponseUser.fromJson(Map<String, dynamic> json) {
    return ApiResponseUser(
      id: json['_id'],
      name: json['name'],
      userName: json['userName'],
      displayPicture: json['displayPicture'],
      about: json['about'],
    );
  }
}

class SearchUser {
  final String id;
  final String name;
  final String userName;
  final String displayPicture;
  final String about;

  SearchUser({
    required this.id,
    required this.name,
    required this.userName,
    required this.displayPicture,
    required this.about,
  });

  factory SearchUser.fromJson(Map<String, dynamic> json) {
    return SearchUser(
      id: json['_id'],
      name: json['name'],
      userName: json['userName'],
      displayPicture: json['displayPicture'],
      about: json['about'],
    );
  }
}
