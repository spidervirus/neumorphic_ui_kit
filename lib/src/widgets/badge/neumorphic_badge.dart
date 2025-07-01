import 'package:flutter/material.dart';
import '../base/neumorphic_widget.dart';
import '../../theme/neumorphic_properties.dart';

/// A badge widget with Neumorphic styling.
class NeumorphicBadge extends StatelessWidget {
  /// The child widget to display inside the badge.
  final Widget child;

  /// The style properties for this badge.
  final NeumorphicProperties? style;

  /// The color of the badge.
  final Color? color;

  /// The size of the badge.
  final double size;

  /// The padding around the child widget.
  final EdgeInsetsGeometry padding;

  /// Whether to show the badge.
  final bool show;

  /// The position of the badge relative to its parent.
  final Alignment alignment;

  /// Creates a Neumorphic badge.
  const NeumorphicBadge({
    super.key,
    required this.child,
    this.style,
    this.color,
    this.size = 20.0,
    this.padding = const EdgeInsets.all(4.0),
    this.show = true,
    this.alignment = Alignment.topRight,
  });

  /// Creates a Neumorphic badge with a counter.
  factory NeumorphicBadge.counter({
    Key? key,
    required int count,
    NeumorphicProperties? style,
    Color? color,
    double size = 20.0,
    EdgeInsetsGeometry padding = const EdgeInsets.all(4.0),
    bool show = true,
    Alignment alignment = Alignment.topRight,
    int maxCount = 99,
  }) {
    final displayCount = count > maxCount ? '$maxCount+' : count.toString();
    return NeumorphicBadge(
      key: key,
      style: style,
      color: color,
      size: size,
      padding: padding,
      show: show && count > 0,
      alignment: alignment,
      child: Text(
        displayCount,
        style: TextStyle(
          color: Colors.white,
          fontSize: size * 0.5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!show) return const SizedBox.shrink();

    final backgroundColor = color ?? Theme.of(context).colorScheme.error;
    final neumorphicWidget = _NeumorphicBadgeWidget(
      style: style?.copyWith(
        depth: (style?.depth ?? 2) * 0.5,
        intensity: style?.intensity ?? 0.3,
        surfaceIntensity: style?.surfaceIntensity ?? 0.2,
      ),
      isPressed: false,
      enabled: true,
    );

    return Container(
      width: size,
      height: size,
      decoration: neumorphicWidget.buildNeumorphicDecoration(context).copyWith(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
      child: Center(
        child: Padding(
          padding: padding,
          child: DefaultTextStyle(
            style: TextStyle(
              color: Colors.white,
              fontSize: size * 0.5,
              fontWeight: FontWeight.bold,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _NeumorphicBadgeWidget extends NeumorphicWidget {
  const _NeumorphicBadgeWidget({
    required super.style,
    required super.isPressed,
    required super.enabled,
  });

  @override
  Widget build(BuildContext context) {
    // This widget is only used for its decoration building capabilities
    return const SizedBox();
  }
}

/// A widget that positions a badge relative to its child.
class NeumorphicBadgePositioned extends StatelessWidget {
  /// The main widget to display.
  final Widget child;

  /// The badge to display.
  final NeumorphicBadge badge;

  /// The alignment of the badge relative to its child.
  final Alignment alignment;

  /// The offset of the badge from its alignment position.
  final Offset offset;

  /// Creates a widget that positions a badge relative to its child.
  const NeumorphicBadgePositioned({
    super.key,
    required this.child,
    required this.badge,
    this.alignment = Alignment.topRight,
    this.offset = const Offset(-8, -8),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        if (badge.show)
          Positioned(
            right: alignment.x > 0 ? offset.dx : null,
            left: alignment.x < 0 ? offset.dx : null,
            top: alignment.y < 0 ? offset.dy : null,
            bottom: alignment.y > 0 ? offset.dy : null,
            child: badge,
          ),
      ],
    );
  }
}
