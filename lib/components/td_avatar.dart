import 'package:flutter/material.dart';
import 'package:task_api_review/resources/app_color.dart';

class TdAvatar extends StatelessWidget {
  const TdAvatar({
    super.key,
    this.avatar,
    this.radius = 26.0,
    this.isActive = false,
  });

  final String? avatar;
  final double radius;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(1.0),
          decoration: const BoxDecoration(
              color: AppColor.orange, shape: BoxShape.circle),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Image.network(
              avatar ?? '',
              fit: BoxFit.cover,
              width: radius * 2,
              height: radius * 2,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: radius * 2,
                  height: radius * 2,
                  color: AppColor.orange,
                  child: const Center(
                    child: Icon(Icons.error_rounded, color: AppColor.white),
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox.square(
                  dimension: radius * 2,
                  child: const Center(
                    child: SizedBox.square(
                      dimension: 24.6,
                      child: CircularProgressIndicator(
                        color: AppColor.pink,
                        strokeWidth: 2.0,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          right: 0.0,
          bottom: 0.0,
          child: CircleAvatar(
            backgroundColor: AppColor.white,
            radius: radius / 4.6 + 1.8,
            child: CircleAvatar(
              backgroundColor: isActive ? AppColor.green : AppColor.yellow,
              radius: radius / 4.6,
            ),
          ),
        ),
      ],
    );
  }
}
