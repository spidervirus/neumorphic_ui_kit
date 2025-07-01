import 'package:flutter/material.dart';
import '../base/neumorphic_widget.dart';
import '../../theme/neumorphic_properties.dart';

/// An icon widget with Neumorphic styling.
class NeumorphicIcon extends StatefulWidget {
  /// The icon to display.
  final IconData icon;

  /// The size of the icon.
  final double size;

  /// The color of the icon.
  final Color? color;

  /// The style properties for this icon.
  final NeumorphicProperties? style;

  /// Called when the icon is tapped.
  final VoidCallback? onPressed;

  /// Whether the icon is enabled.
  final bool enabled;

  /// The duration of the press animation.
  final Duration pressDuration;

  /// Creates a Neumorphic icon.
  const NeumorphicIcon({
    super.key,
    required this.icon,
    this.size = 24.0,
    this.color,
    this.style,
    this.onPressed,
    this.enabled = true,
    this.pressDuration = const Duration(milliseconds: 100),
  });

  @override
  State<NeumorphicIcon> createState() => _NeumorphicIconState();
}

class _NeumorphicIconState extends State<NeumorphicIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _pressAnimation;
  bool _isPressed = false;
  late NeumorphicWidget _neumorphicWidget;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: widget.pressDuration,
    );
    _pressAnimation = CurvedAnimation(
      parent: _pressController,
      curve: Curves.easeInOut,
    );
    _updateNeumorphicWidget();
  }

  @override
  void didUpdateWidget(NeumorphicIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateNeumorphicWidget();
  }

  void _updateNeumorphicWidget() {
    _neumorphicWidget = _NeumorphicIconWidget(
      style: widget.style,
      isPressed: _isPressed,
      enabled: widget.enabled,
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.enabled || widget.onPressed == null) return;
    setState(() => _isPressed = true);
    _pressController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.enabled || widget.onPressed == null) return;
    setState(() => _isPressed = false);
    _pressController.reverse();
    widget.onPressed?.call();
  }

  void _handleTapCancel() {
    if (!widget.enabled || widget.onPressed == null) return;
    setState(() => _isPressed = false);
    _pressController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final defaultColor = Theme.of(context).colorScheme.primary;
    final iconColor = widget.color ?? defaultColor;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _pressAnimation,
        builder: (context, child) {
          return Container(
            width: widget.size * 2,
            height: widget.size * 2,
            decoration: _neumorphicWidget.buildNeumorphicDecoration(context),
            child: Center(
              child: Icon(
                widget.icon,
                size: widget.size,
                color: widget.enabled ? iconColor : Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _NeumorphicIconWidget extends NeumorphicWidget {
  const _NeumorphicIconWidget({
    required super.style,
    required super.isPressed,
    required super.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
