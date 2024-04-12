class ChangePasswordBody {
  String? password;
  String? oldPassword;

  ChangePasswordBody();

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'old_password': oldPassword,
    };
  }
}
