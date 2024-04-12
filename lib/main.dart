// http://206.189.150.98:3000/api-docs/
// https://jsonformatter.curiousconcept.com/#
// https://dartj.web.app/#/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_api_review/pages/splash/splash_page.dart';
import 'package:task_api_review/services/local/shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // shared preferences
  await SharedPrefs.initialise();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true),
      home: const SplashPage(),
    );
  }
}
