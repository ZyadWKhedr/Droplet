import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OauthContainerWidget extends StatelessWidget {
  final String type;

  const OauthContainerWidget({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 105.w,
      height: 56.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xffE8ECF4)),
      ),
      child: Center(
        child: FaIcon(_getIcon(), size: 24.sp, color: _getColor()),
      ),
    );
  }

  IconData _getIcon() {
    switch (type.toLowerCase()) {
      case "facebook":
        return FontAwesomeIcons.facebook;
      case "apple":
        return FontAwesomeIcons.apple;
      case "google":
      default:
        return FontAwesomeIcons.google;
    }
  }

  Color _getColor() {
    switch (type.toLowerCase()) {
      case "facebook":
        return const Color(0xFF1877F2);
      case "apple":
        return Colors.black;
      case "google":
      default:
        return const Color(0xFFDB4437);
    }
  }
}
