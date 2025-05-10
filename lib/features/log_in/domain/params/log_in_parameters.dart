class LogInParameters {
  final String username;
  final String password;

  const LogInParameters({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
  };
}