import 'package:flutter/material.dart';
import '../theme/billy_colors.dart';

/// Deep purple page background with soft glows. Wrap a screen body with this.
class GlowBackground extends StatelessWidget {
  final Widget child;

  /// Blends the top edge into the (solid) scaffold colour so screens with an
  /// AppBar don't show a hard seam between the app bar and the glow.
  final bool fadeTop;
  const GlowBackground({super.key, required this.child, this.fadeTop = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF1A0638), Color(0xFF0B0418), Color(0xFF07030F)],
              stops: [0.0, 0.45, 1.0],
            ),
          ),
        ),
        Positioned(
          top: -120,
          right: -100,
          child: _blob(340, BillyColors.primary.withOpacity(0.38)),
        ),
        Positioned(
          top: 260,
          left: -160,
          child: _blob(320, BillyColors.primaryDark.withOpacity(0.30)),
        ),
        Positioned(
          bottom: -140,
          right: -120,
          child: _blob(340, BillyColors.primary.withOpacity(0.18)),
        ),
        if (fadeTop)
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 64,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [BillyColors.background, Color(0x0007030F)],
                  ),
                ),
              ),
            ),
          ),
        child,
      ],
    );
  }

  Widget _blob(double size, Color color) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color, color.withOpacity(0)]),
        ),
      ),
    );
  }
}

/// Dark glassy card with a purple edge.
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final VoidCallback? onTap;
  final Gradient? gradient;
  final Color? borderColor;
  final List<BoxShadow>? shadows;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radius = 20,
    this.onTap,
    this.gradient,
    this.borderColor,
    this.shadows,
  });

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(radius);
    return Container(
      decoration: BoxDecoration(
        gradient: gradient ?? BillyColors.glassGradient,
        borderRadius: r,
        border: Border.all(color: borderColor ?? BillyColors.border),
        boxShadow: shadows ??
            [
              BoxShadow(
                color: Colors.black.withOpacity(0.35),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: r,
          onTap: onTap,
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}

/// Pill button with the brand gradient.
class GradientButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final bool expand;

  const GradientButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    this.expand = false,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Container(
        width: expand ? double.infinity : null,
        decoration: BoxDecoration(
          gradient: BillyColors.brandGradient,
          borderRadius: BorderRadius.circular(40),
          boxShadow: enabled ? BillyColors.glow(0.45) : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: onPressed,
            child: Padding(
              padding: padding,
              child: Row(
                mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, size: 16, color: BillyColors.primaryDark),
                    ),
                    const SizedBox(width: 10),
                  ],
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Pill button with only a purple outline.
class OutlinePillButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;

  const OutlinePillButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.25),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: BillyColors.primaryLight.withOpacity(0.8), width: 1.2),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(40),
          onTap: onPressed,
          child: Padding(
            padding: padding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 20, color: Colors.white),
                  const SizedBox(width: 8),
                ],
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Section heading with a purple accent bar and optional trailing action.
class SectionTitle extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SectionTitle({super.key, required this.title, this.actionLabel, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 26,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFC77DFF), BillyColors.primary],
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        if (actionLabel != null)
          GestureDetector(
            onTap: onAction,
            child: Row(
              children: [
                Text(
                  actionLabel!,
                  style: const TextStyle(
                    color: BillyColors.primaryLight,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_forward, color: BillyColors.primaryLight, size: 18),
              ],
            ),
          ),
      ],
    );
  }
}
