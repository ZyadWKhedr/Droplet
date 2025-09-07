import 'dart:async';
import 'dart:math';
import 'package:droplet/core/constatnts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sensors_plus/sensors_plus.dart';

class LiquidStorageWidget extends StatefulWidget {
  const LiquidStorageWidget({super.key, required this.storagePercent});

  final double storagePercent; // 0.0 - 1.0

  @override
  State<LiquidStorageWidget> createState() => _LiquidStorageWidgetState();
}

class _LiquidStorageWidgetState extends State<LiquidStorageWidget>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  double xTilt = 0;
  double yTilt = 0;

  late final AnimationController _waveController;
  late final StreamSubscription<GyroscopeEvent> _gyroSub;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Wave animation controller
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Gyroscope subscription
    _gyroSub = gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        xTilt = event.x.clamp(-1, 1);
        yTilt = event.y.clamp(-1, 1);
      });
    });
  }

  @override
  void dispose() {
    _waveController.dispose();
    _gyroSub.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Pause/resume wave animation on app lifecycle changes
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _waveController.stop();
    } else if (state == AppLifecycleState.resumed) {
      _waveController.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 328.w,
      height: 130.h,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..rotateX(yTilt * 0.3)
          ..rotateZ(-xTilt * 0.3),
        child: AnimatedBuilder(
          animation: _waveController,
          builder: (context, child) {
            return CustomPaint(
              painter: _LiquidPainter(
                percent: widget.storagePercent,
                wavePhase: _waveController.value * 2 * pi,
              ),
              child: Center(
                child: Text(
                  "${(widget.storagePercent * 100).toStringAsFixed(0)}% Used",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LiquidPainter extends CustomPainter {
  final double percent; // 0.0 - 1.0
  final double wavePhase;

  _LiquidPainter({required this.percent, required this.wavePhase});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.primary;

    // Minimum water offset to keep the wave visible inside container
    final double minOffset = 15.0.w;

    // Compute water height from bottom
    double waterHeight = size.height * (1 - percent);
    waterHeight = waterHeight.clamp(minOffset, size.height - minOffset);

    final path = Path();
    path.moveTo(0, size.height);
    for (double x = 0; x <= size.width; x++) {
      double y = waterHeight + 9 * sin((x / size.width * 2 * pi) + wavePhase);
      path.lineTo(x, y);
    }
    path.lineTo(size.width, size.height);
    path.close();

    // Draw container background
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(10.r)),
      Paint()..color = Color(0xffE9F2F8),
    );

    // Draw container border
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(8.r)),
      borderPaint,
    );

    // Draw water
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _LiquidPainter oldDelegate) => true;
}
