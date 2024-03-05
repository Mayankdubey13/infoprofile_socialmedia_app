class UserModel {
  String userId;
  String token;
  String name ;
  String userName;
  String email;
  String displayPicture;

  UserModel({required this.userId, required this.token,required this.name,required this.userName,required this.email,required this.displayPicture});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId']??"",
      token: json['token']??"",
        name: json["name"]??"",
      userName: json["userName"]??"",
      email: json[" email"]??"",
      displayPicture :json["displayPicture"]??""

    );
  }
}
