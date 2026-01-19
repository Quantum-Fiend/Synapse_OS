import 'package:flutter/material.dart';

class SynapseColors {
  static const primary = Color(0xFF6200EE);
  static const secondary = Color(0xFFBB86FC);
  static const background = Color(0xFF0F0F12);
  static const surface = Color(0xFF1E1E24);
  static const glass = Color(0x1AFFFFFF);
  static const accent = Color(0xFF03DAC6);
  
  static const gradientPrimary = LinearGradient(
    colors: [Color(0xFF6200EE), Color(0xFFBB86FC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientBackground = LinearGradient(
    colors: [Color(0xFF0F0F12), Color(0xFF1E1E24)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class SynapseGradients {
  static BoxShadow glassShadow = BoxShadow(
    color: Colors.black.withOpacity(0.2),
    blurRadius: 10,
    spreadRadius: 2,
  );
}

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius = 16.0,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: SynapseColors.glass,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [SynapseGradients.glassShadow],
      ),
      child: child,
    );
  }
}
