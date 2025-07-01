import 'package:flutter/material.dart';
import '../base/neumorphic_widget.dart';

/// A container with Neumorphic styling.
/// This widget provides a basic building block for creating Neumorphic UI elements.
class NeumorphicContainer extends NeumorphicWidget {
  /// The child widget to display inside the container.
  final Widget child;

  /// The width of the container.
  final double? width;

  /// The height of the container.
  final double? height;

  /// The padding around the child widget.
  final EdgeInsetsGeometry padding;

  /// Creates a Neumorphic container.
  const NeumorphicContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding = EdgeInsets.zero,
    super.style,
    super.isPressed = false,
    super.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: buildNeumorphicDecoration(context),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
