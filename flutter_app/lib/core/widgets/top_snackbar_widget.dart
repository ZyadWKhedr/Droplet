import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.of(context);

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 100.h,
        left: 0,
        right: 0,
        child: SafeArea(
          child: Material(
            color: Colors.transparent,
            child: AnimatedSlide(
              offset: const Offset(0, -1),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              child: _TopSnackBarWidget(
                message: message,
                backgroundColor: backgroundColor,
                textColor: textColor,
                icon: icon,
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Animate in
    Future.delayed(const Duration(milliseconds: 50), () {
      overlayEntry.markNeedsBuild();
    });

    // Remove after duration
    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }
}

class _TopSnackBarWidget extends StatefulWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;

  const _TopSnackBarWidget({
    required this.message,
    required this.backgroundColor,
    required this.textColor,
    this.icon,
  });

  @override
  State<_TopSnackBarWidget> createState() => _TopSnackBarWidgetState();
}

class _TopSnackBarWidgetState extends State<_TopSnackBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6.r,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon != null)
              Icon(widget.icon, color: widget.textColor, size: 20.sp),
            if (widget.icon != null) SizedBox(width: 8.w),
            Expanded(
              child: Text(
                widget.message,
                style: TextStyle(color: widget.textColor, fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
