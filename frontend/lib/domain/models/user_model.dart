class User {
  final int id;
  final String email;
  final String password;
  final String fullname;
  final String avatar;
  final int isRecruiter;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.fullname,
    required this.avatar,
    required this.isRecruiter,
  });

  // fromJson method to map JSON to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      fullname: json['fullname'],
      avatar: json['avatar'],
      isRecruiter: json['isrecruiter'],
    );
  }

  // toJson method to convert User object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'fullname': fullname,
      'avatar': avatar,
      'isrecruiter': isRecruiter,
    };
  }
}
