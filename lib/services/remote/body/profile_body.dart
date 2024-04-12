class ProfileBody {
  String? name;
  String? email;
  String? password;
  String? avatar;
  int? age;

  ProfileBody();

  // factory ProfileBody.fromJson(Map<String, dynamic> json) => ProfileBody()
  //   ..name = json['name'] as String?
  //   ..email = json['email'] as String?
  //   ..avatar = json['avatar'] as String?
  //   ..age = json['age'] as int?;

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (avatar != null) 'avatar': avatar,
      if (age != null) 'age': age
    };
  }
}
