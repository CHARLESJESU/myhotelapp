import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

/// Simple UI-only image picker that shows a preview and an "Upload" button.
///
/// This widget does not perform any real file picking; instead it exposes a
/// callback that the parent can use to simulate selecting an image. Keep as
/// UI-only per project constraints.
class ImagePickerUI extends StatelessWidget {
  final Widget? preview;
  final VoidCallback? onUpload;

  const ImagePickerUI({super.key, this.preview, this.onUpload});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // preview box
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.uploadPlaceholder,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.transparent),
          ),
          child:
              preview ??
              Icon(
                Icons.image_outlined,
                color: AppColors.uploadDashed,
                size: 36,
              ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: onUpload,
            child: DashedBox(
              color: AppColors.uploadDashed,
              borderRadius: 8,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.upload_file,
                      color: AppColors.uploadIcon,
                      size: 20,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Upload',
                      style: TextStyle(color: AppColors.uploadIcon),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DashedBox extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final Color color;

  const DashedBox({
    super.key,
    required this.child,
    this.borderRadius = 6,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(color: color, radius: borderRadius),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Center(child: child),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;

  _DashedBorderPainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final RRect rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    const dashWidth = 6.0;
    const dashSpace = 4.0;

    final Path path = Path()..addRRect(rrect);
    final Path dashed = Path();
    double distance = 0.0;
    for (final ui.PathMetric metric in path.computeMetrics()) {
      while (distance < metric.length) {
        final double next = (distance + dashWidth).clamp(0.0, metric.length);
        dashed.addPath(metric.extractPath(distance, next), Offset.zero);
        distance = next + dashSpace;
      }
      distance = 0.0;
    }

    canvas.drawPath(dashed, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
