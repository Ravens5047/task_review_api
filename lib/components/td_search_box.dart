import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_api_review/gen/assets.gen.dart';
import 'package:task_api_review/resources/app_color.dart';

class TdSearchBox extends StatelessWidget {
  const TdSearchBox({super.key, this.controller, this.onChanged});

  final TextEditingController? controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(
            color: AppColor.shadow,
            offset: Offset(0.0, 3.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(color: AppColor.red),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: const TextStyle(color: AppColor.grey),
          prefixIcon: SvgPicture.asset(
            Assets.icons.search,
            width: 18.0,
            height: 18.0,
            // ignore: deprecated_member_use
            color: Colors.orange,
            fit: BoxFit.scaleDown,
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 36.0),
        ),
      ),
    );
  }
}
