import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:task_api_review/constants/app_constant.dart';
import 'package:task_api_review/services/local/shared_prefs.dart';
import 'package:task_api_review/services/remote/body/profile_body.dart';

abstract class ImplAccountServices {
  Future<http.Response> getProfile();
  Future<http.Response> updateProfile(ProfileBody body);
}

class AccountServices implements ImplAccountServices {
  static final httpLog = HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);

  @override
  Future<http.Response> getProfile() async {
    const url = AppConstant.endPointGetProfile;
    return await httpLog.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPrefs.token}',
      },
    );
  }

  @override
  Future<http.Response> updateProfile(ProfileBody body) async {
    const url = AppConstant.endPointUpdateProfile;

    http.Response response = await httpLog.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPrefs.token}',
      },
      body: jsonEncode(body.toJson()),
    );
    return response;
  }
}
