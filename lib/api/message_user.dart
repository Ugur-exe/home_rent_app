class MessageUser {
  late final String image;
  late final String about;
  late final String name;
  late final String createdAt;
  late final String id;
  late final bool isOnline;
  late final String lastActive;
  late final String email;
  late final String pushToken;
  late final String lastName;

  MessageUser({
    required this.image,
    required this.about,
    required this.name,
    required this.createdAt,
    required this.id,
    required this.isOnline,
    required this.lastActive,
    required this.email,
    required this.pushToken,
    required this.lastName,
  });

  MessageUser.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? "";
    about = json['about'] ?? "";
    name = json['name']?? "";
    createdAt = json['created_at']?? "";
    id = json['id']?? "";
    isOnline = json['is_online'].toLowerCase() == 'true' ? true : false;
    lastActive = json['last_active']?? "";
    email = json['email']?? "";
    pushToken = json['push_token']?? "";
    lastName = json['last_name']?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['about'] = this.about;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['is_online'] = this.isOnline;
    data['last_active'] = this.lastActive;
    data['email'] = this.email;
    data['push_token'] = this.pushToken;
    data['lastName'] = this.pushToken;
    return data;
  }
}
