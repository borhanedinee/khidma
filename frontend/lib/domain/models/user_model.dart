class User {
  final int id;
  final String email;
  final String password;
  final String fullname;
  final String avatar;
  final bool isRecruiter;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.fullname,
    required this.avatar,
    required this.isRecruiter,
  });

  // Factory constructor to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      fullname: json['fullname'],
      avatar: json['avatar'],
      isRecruiter: json['isrecruiter'] == 1, // Convert 0/1 to boolean
    );
  }

  // Method to convert a User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'fullname': fullname,
      'avatar': avatar,
      'isrecruiter': isRecruiter ? 1 : 0, // Convert boolean to 0/1
    };
  }
}
