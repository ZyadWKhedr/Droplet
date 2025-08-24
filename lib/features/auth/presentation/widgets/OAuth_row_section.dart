import 'package:droplet/features/auth/presentation/widgets/OAuth_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OauthRowSection extends StatelessWidget {
  const OauthRowSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OauthContainerWidget(type: "facebook"),
        SizedBox(width: 8.w),
        OauthContainerWidget(type: "google"),
        SizedBox(width: 8.w),
        OauthContainerWidget(type: "apple"),
      ],
    );
  }
}
