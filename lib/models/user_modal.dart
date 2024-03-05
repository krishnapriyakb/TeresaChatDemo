class UserModal {
  String? image;
  String? name;
  String? about;
  String? createdAt;
  String? lastActive;
  bool? isOnline;
  String? pushToken;

  UserModal(
      {this.image,
      this.name,
      this.about,
      this.createdAt,
      this.lastActive,
      this.isOnline,
      this.pushToken});

  UserModal.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    about = json['about'];
    createdAt = json['created_at'];
    lastActive = json['last_active'];
    isOnline = json['is_online'];
    pushToken = json['push_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = image;
    data['name'] = name;
    data['about'] = about;
    data['created_at'] = createdAt;
    data['last_active'] = lastActive;
    data['is_online'] = isOnline;
    data['push_token'] = pushToken;
    return data;
  }
}
