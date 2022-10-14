class User {
  String username;
  String email;
  String password;

  User({required this.password, required this.email, required this.username});

  @override
  String toString() {
    return "User{username:$username,email:$email}";
  }
}
