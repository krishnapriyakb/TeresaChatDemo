// To parse this JSON data, do
//
//     final UserModal = UserModalFromJson(jsonString);

import 'dart:convert';

UserModal UserModalFromJson(String str) => UserModal.fromJson(json.decode(str));

String UserModalToJson(UserModal data) => json.encode(data.toJson());

class UserModal {
  String image;
  String about;
  String name;
  String createdAt;
  bool? isOnline;
  String lastActive;
  String id;
  String pushToken;
  String email;

  UserModal({
    required this.image,
    required this.about,
    required this.name,
    required this.createdAt,
    required this.isOnline,
    required this.lastActive,
    required this.id,
    required this.pushToken,
    required this.email,
  });

  factory UserModal.fromJson(Map<String, dynamic> json) => UserModal(
        image: json["image"],
        about: json["about"],
        name: json["name"],
        createdAt: json["created_at"],
        isOnline: json["isOnline"],
        lastActive: json["last_active"],
        id: json["id"],
        pushToken: json["push_token"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "about": about,
        "name": name,
        "created_at": createdAt,
        "isOnline": isOnline,
        "last_active": lastActive,
        "id": id,
        "push_token": pushToken,
        "email": email,
      };
}
