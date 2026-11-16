import 'package:flutter/material.dart';

/// BILLY dark-purple palette.
abstract final class BillyColors {
  // Brand
  static const primary = Color(0xFF8A2BFF);
  static const primaryDark = Color(0xFF5B0FD1);
  static const primaryLight = Color(0xFFB14DFF);
  static const deepPurple = Color(0xFF1A0638);

  // Backgrounds / surfaces
  static const background = Color(0xFF07030F);
  static const backgroundAlt = Color(0xFF12062B);
  static const surface = Color(0xFF150A2E);
  static const surfaceHigh = Color(0xFF1F1042);
  static const border = Color(0x59A855F7); // purple @ ~35%
  static const borderSoft = Color(0x33A855F7); // purple @ ~20%

  // Text
  static const textPrimary = Colors.white;
  static const textSecondary = Color(0xFFC4BDE0);
  static const textMuted = Color(0xFF8F84B8);

  // Status
  static const success = Color(0xFF4ADE80);
  static const error = Color(0xFFFF5C7A);
  static const warning = Color(0xFFFBBF24);

  // Gradients
  static const brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFB14DFF), Color(0xFF8A2BFF), Color(0xFF6A00FF)],
  );

  static const cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF7A1FF5), Color(0xFF5B0FD1), Color(0xFF2A0A66)],
  );

  static const glassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xBF28145A), Color(0xD90E0720)],
  );

  static List<BoxShadow> glow([double opacity = 0.35]) => [
        BoxShadow(
          color: primary.withOpacity(opacity),
          blurRadius: 24,
          spreadRadius: 0,
          offset: const Offset(0, 8),
        ),
      ];
}
