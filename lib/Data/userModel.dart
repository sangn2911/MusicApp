import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String password;
    String name;
    String email;
    String phone;
    List<dynamic> playList;

    UserModel({
        this.password,
        this.name,
        this.email,
        this.phone,
        this.playList,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        password: json["password"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        playList: List<dynamic>.from(json["playList"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "password": password,
        "name": name,
        "email": email,
        "phone": phone,
        "playList": List<dynamic>.from(playList.map((x) => x)),
    };
}
