import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String password;
    String name;
    String email;
    String phone;
    List<dynamic> playList;
    TimeLog timeLog;

    UserModel({
        this.password,
        this.name,
        this.email,
        this.phone,
        this.playList,
        this.timeLog,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        password: json["password"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        playList: List<dynamic>.from(json["playList"].map((x) => x)),
        timeLog: TimeLog.fromJson(json["timeLog"]),
    );

    Map<String, dynamic> toJson() => {
        "password": password,
        "name": name,
        "email": email,
        "phone": phone,
        "playList": List<dynamic>.from(playList.map((x) => x)),
        "timeLog": timeLog.toJson(),
    };
}

class TimeLog {
    TimeLog();

    factory TimeLog.fromJson(Map<String, dynamic> json) => TimeLog(
    );

    Map<String, dynamic> toJson() => {
    };
}