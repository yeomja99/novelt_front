class UserInfo{
  final String name, email, password;

  UserInfo({
    required this.name,
    required this.email,
    required this.password
  });

  // json 형식으로 넘겨받을 경우
  UserInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        password=json['password'];
}