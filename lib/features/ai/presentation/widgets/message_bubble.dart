import 'package:droplet/core/constatnts/app_colors.dart';
import 'package:droplet/core/text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/chat_message_entity.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == ChatRole.user;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: !isUser ? 16.h : 0,
        ).copyWith(right: !isUser ? 56.w : 24.w, left: !isUser ? 24.w : 56.w),
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 14.h),
        constraints: BoxConstraints(maxWidth: 295.w),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.accent),
          color: isUser ? AppColors.accent : Color(0xffFBFDFE),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          message.text,
          style: AppText.body.copyWith(
            fontSize: 14.sp,
            color: isUser ? Colors.white : AppColors.primary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
