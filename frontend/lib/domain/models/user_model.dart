class User {
  final int id;
  final String email;
  final int phone;
  final String password;
  final String fullname;
  final String avatar;
  final String resume;
  final bool isRecruiter;

  User({
    required this.id,
    required this.email,
    required this.phone,
    required this.password,
    required this.fullname,
    required this.avatar,
    required this.isRecruiter,
    required this.resume,
  });

  // Factory constructor to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      fullname: json['fullname'],
      avatar: json['avatar'],
      resume: json['resume'] ?? '',
      isRecruiter: json['isrecruiter'] == 1, // Convert 0/1 to boolean
    );
  }

  // Method to convert a User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'password': password,
      'fullname': fullname,
      'avatar': avatar,
      'resume': resume,
      'isrecruiter': isRecruiter ? 1 : 0, // Convert boolean to 0/1
    };
  }
}
