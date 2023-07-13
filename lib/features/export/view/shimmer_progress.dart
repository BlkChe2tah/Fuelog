import 'package:flutter/material.dart';
import 'package:petrol_ledger/core/colors.dart';
import 'package:petrol_ledger/core/values.dart';

const _shimmerGradient = LinearGradient(
  colors: [
    kSurfaceColor,
    kSurfaceLightColor,
    kSurfaceColor,
  ],
  stops: [
    0.2,
    0.6,
    1.0,
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  tileMode: TileMode.clamp,
);

class ShimmerProgress extends StatefulWidget {
  final Widget child;
  const ShimmerProgress({
    super.key,
    required this.child,
  });

  @override
  State<ShimmerProgress> createState() => ShimmerProgressState();
}

class ShimmerProgressState extends State<ShimmerProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  void _setupAnimation() {
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(
        min: -0.5,
        max: 1.5,
        period: const Duration(milliseconds: 1000),
      );
    _shimmerController.addListener(() {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kBorderRadius),
      child: RepaintBoundary(
        child: ShaderMask(
          blendMode: BlendMode.lighten,
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: _shimmerGradient.colors,
              stops: _shimmerGradient.stops,
              begin: _shimmerGradient.begin,
              end: _shimmerGradient.end,
              transform:
                  _ShimmerTransform(slidePercent: _shimmerController.value),
            ).createShader(bounds);
          },
          child: widget.child,
        ),
      ),
    );
  }
}

// transform
class _ShimmerTransform extends GradientTransform {
  final double slidePercent;
  const _ShimmerTransform({required this.slidePercent});

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}
