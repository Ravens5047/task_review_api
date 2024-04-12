class OtpBody {
  String? email;

  OtpBody.huy();

  OtpBody(this.email);

  factory OtpBody.fromJson(Map<String, dynamic> json) =>
      OtpBody.huy()..email = json['email'];

  Map<String, dynamic> toJson() {
    return {'email': email};
  }
}
