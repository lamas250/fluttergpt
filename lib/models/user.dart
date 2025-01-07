class UserModel {
  final String id;
  final String name;
  final String email;
  final String platform;
  final String token;
  final String createdAt;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.platform,
    required this.token,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      platform: json['platform'],
      token: json['token'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'platform': platform,
      'token': token,
      'createdAt': createdAt,
    };
  }
}
