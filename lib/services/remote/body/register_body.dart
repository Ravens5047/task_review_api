class RegisterBody {
  String? name;
  String? email;
  String? password;
  int? age;
  String? code; // code la otp;
  String? avatar;

  RegisterBody();

  // factory RegisterBody.fromJson(Map<String, dynamic> json) => RegisterBody()
  //   ..name = json['name'] as String?
  //   ..email = json['email'] as String?
  //   ..password = json['password'] as String?
  //   ..avatar = json['avatar'] as String?
  //   ..age = json['age'] as int?
  //   ..code = json['code'] as String?;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      if (avatar != null) 'avatar': avatar,
      if (age != null) 'age': age,
      'code': code
    };
  }
}
