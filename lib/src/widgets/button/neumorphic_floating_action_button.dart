import 'package:flutter/material.dart';
import '../base/neumorphic_widget.dart';
import '../../theme/neumorphic_properties.dart';

/// A floating action button with Neumorphic styling.
class NeumorphicFloatingActionButton extends StatefulWidget {
  /// The child widget to display inside the button.
  final Widget child;

  /// Called when the button is tapped.
  final VoidCallback? onPressed;

  /// The style properties for this button.
  final NeumorphicProperties? style;

  /// The size of the button.
  final double size;

  /// Whether the button is enabled.
  final bool enabled;

  /// The duration of the press animation.
  final Duration pressDuration;

  /// The color of the button.
  final Color? backgroundColor;

  /// Creates a Neumorphic floating action button.
  const NeumorphicFloatingActionButton({
    super.key,
    required this.child,
    this.onPressed,
    this.style,
    this.size = 56.0,
    this.enabled = true,
    this.pressDuration = const Duration(milliseconds: 100),
    this.backgroundColor,
  });

  @override
  State<NeumorphicFloatingActionButton> createState() =>
      _NeumorphicFloatingActionButtonState();
}

class _NeumorphicFloatingActionButtonState
    extends State<NeumorphicFloatingActionButton>
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
  void didUpdateWidget(NeumorphicFloatingActionButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateNeumorphicWidget();
  }

  void _updateNeumorphicWidget() {
    _neumorphicWidget = _NeumorphicFABWidget(
      style: widget.style?.copyWith(
        depth: (widget.style?.depth ?? 4) * 1.5,
        intensity: widget.style?.intensity ?? 0.7,
        surfaceIntensity: widget.style?.surfaceIntensity ?? 0.5,
      ),
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
    final backgroundColor =
        widget.backgroundColor ?? Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _pressAnimation,
        builder: (context, child) {
          return Container(
            width: widget.size,
            height: widget.size,
            decoration:
                _neumorphicWidget.buildNeumorphicDecoration(context).copyWith(
                      color: widget.enabled ? backgroundColor : Colors.grey,
                      shape: BoxShape.circle,
                    ),
            child: Center(
              child: IconTheme(
                data: IconThemeData(
                  color: widget.enabled ? Colors.white : Colors.white54,
                  size: widget.size * 0.5,
                ),
                child: widget.child,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _NeumorphicFABWidget extends NeumorphicWidget {
  const _NeumorphicFABWidget({
    required super.style,
    required super.isPressed,
    required super.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
