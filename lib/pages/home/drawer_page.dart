import 'package:flutter/material.dart';
import 'package:task_api_review/components/app_dialog.dart';
import 'package:task_api_review/gen/assets.gen.dart';
import 'package:task_api_review/models/app_user_model.dart';
import 'package:task_api_review/pages/auth/change_password_page.dart';
import 'package:task_api_review/pages/auth/login_page.dart';
import 'package:task_api_review/pages/profile/profile_page.dart';
import 'package:task_api_review/resources/app_color.dart';
import 'package:task_api_review/services/local/shared_prefs.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({
    super.key,
    required this.appUser,
    required this.pageIndex,
  });

  final AppUserModel appUser;
  final int pageIndex;

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    const iconSize = 18.0;
    const iconColor = AppColor.orange;
    const spacer = 6.0;
    const textStyle = TextStyle(color: AppColor.brown, fontSize: 16.0);

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Welcome',
              style: TextStyle(color: AppColor.red, fontSize: 20.0)),
          Text(
            widget.appUser.name ?? '-:-',
            style: const TextStyle(
                color: AppColor.brown,
                fontSize: 16.8,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 18.0),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProfilePage(
                  appUser: widget.appUser, pageIndex: widget.pageIndex),
            )),
            child: const Row(
              children: [
                Icon(Icons.person, size: iconSize, color: iconColor),
                SizedBox(width: spacer),
                Text('My Profile', style: textStyle),
              ],
            ),
          ),
          const SizedBox(height: 18.0),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ChangePasswordPage(email: widget.appUser.email ?? ''),
            )),
            child: const Row(
              children: [
                Icon(Icons.lock_outline, size: iconSize, color: iconColor),
                SizedBox(width: spacer),
                Text('Change Password', style: textStyle),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16.0, right: 20.0),
            height: 1.2,
            color: AppColor.grey,
          ),
          const Spacer(flex: 1),
          Row(
            children: [
              const SizedBox(width: 12.0),
              Expanded(child: Image.asset(Assets.images.todoIconTwo.path)),
            ],
          ),
          const Spacer(flex: 2),
          InkWell(
            onTap: () => AppDialog.dialog(
              context,
              title: '😍',
              content: 'Do you want to logout?',
              action: () async {
                await SharedPrefs.removeSeason();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                });
              },
            ),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: const Row(
              children: [
                Icon(Icons.logout, size: iconSize, color: iconColor),
                SizedBox(width: spacer),
                Text('Logout', style: textStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
