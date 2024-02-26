class User {
  final int? userId;
  final String userName;
  final String password;

  User({
    this.userId,
    required this.userName,
    required this.password,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        userId: json["userId"],
        userName: json["userName"],
        password: json["Password"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "userName": userName,
        "Password": password,
      };
}
