import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_api_review/gen/assets.gen.dart';
import 'package:task_api_review/pages/auth/login_page.dart';
import 'package:task_api_review/pages/main_page.dart';
import 'package:task_api_review/pages/onboading/onboading_page.dart';
import 'package:task_api_review/resources/app_color.dart';
import 'package:task_api_review/services/local/shared_prefs.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  void _checkToken() {
    Timer(const Duration(milliseconds: 2600), () {
      if (SharedPrefs.isAccessed == true) {
        if ((SharedPrefs.token != null) && (SharedPrefs.token!.isNotEmpty)) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const MainPage(title: 'Tasks'),
            ),
            (Route<dynamic> route) => false,
          );
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
            (Route<dynamic> route) => false,
          );
        }
      }

      if (SharedPrefs.isAccessed == false) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const OnboardingPage(),
          ),
          (Route<dynamic> route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              Assets.images.todoIcon.path,
              width: 112.0,
              fit: BoxFit.cover,
            ),
            Shimmer.fromColors(
              baseColor: Colors.red,
              highlightColor: Colors.yellow,
              child: const Text(
                'Flutter Todos',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
