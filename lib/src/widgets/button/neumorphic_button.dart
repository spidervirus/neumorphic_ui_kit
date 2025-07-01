import 'package:flutter/material.dart';
import '../base/neumorphic_widget.dart';
import '../../theme/neumorphic_properties.dart';

/// A button widget with Neumorphic styling that responds to press interactions.
class NeumorphicButton extends StatefulWidget {
  /// The child widget to be rendered inside the button.
  final Widget? child;

  /// The padding around the child widget.
  final EdgeInsetsGeometry? padding;

  /// The minimum size of the button.
  final Size? minSize;

  /// Called when the button is tapped or pressed.
  final VoidCallback? onPressed;

  /// Duration of the press animation.
  final Duration pressedAnimationDuration;

  /// The style properties for this button.
  final NeumorphicProperties? style;

  /// Whether the button is enabled.
  final bool enabled;

  /// Creates a Neumorphic button.
  const NeumorphicButton({
    super.key,
    this.child,
    this.padding,
    this.minSize,
    this.onPressed,
    this.pressedAnimationDuration = const Duration(milliseconds: 100),
    this.style,
    this.enabled = true,
  });

  @override
  State<NeumorphicButton> createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  late AnimationController _pressedController;
  late Animation<double> _pressedAnimation;
  late NeumorphicWidget _neumorphicWidget;

  @override
  void initState() {
    super.initState();
    _pressedController = AnimationController(
      vsync: this,
      duration: widget.pressedAnimationDuration,
    );
    _pressedAnimation = CurvedAnimation(
      parent: _pressedController,
      curve: Curves.easeInOut,
    );
    _updateNeumorphicWidget();
  }

  @override
  void didUpdateWidget(NeumorphicButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateNeumorphicWidget();
  }

  void _updateNeumorphicWidget() {
    _neumorphicWidget = _NeumorphicButtonWidget(
      style: widget.style,
      isPressed: _isPressed,
      enabled: widget.enabled,
    );
  }

  @override
  void dispose() {
    _pressedController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.enabled || widget.onPressed == null) return;
    setState(() {
      _isPressed = true;
      _updateNeumorphicWidget();
    });
    _pressedController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.enabled || widget.onPressed == null) return;
    setState(() {
      _isPressed = false;
      _updateNeumorphicWidget();
    });
    _pressedController.reverse();
  }

  void _handleTapCancel() {
    if (!widget.enabled || widget.onPressed == null) return;
    setState(() {
      _isPressed = false;
      _updateNeumorphicWidget();
    });
    _pressedController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPadding = EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 8.0,
    );

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.enabled ? widget.onPressed : null,
      child: AnimatedBuilder(
        animation: _pressedAnimation,
        builder: (context, child) {
          return Container(
            constraints: widget.minSize != null
                ? BoxConstraints(
                    minWidth: widget.minSize!.width,
                    minHeight: widget.minSize!.height,
                  )
                : null,
            decoration:
                _neumorphicWidget.buildNeumorphicDecoration(context).copyWith(
              boxShadow: [
                ...?_neumorphicWidget
                    .buildNeumorphicDecoration(context)
                    .boxShadow
                    ?.map(
                      (shadow) => BoxShadow(
                        color: shadow.color,
                        offset: Offset.lerp(
                          shadow.offset,
                          -shadow.offset,
                          _pressedAnimation.value,
                        )!,
                        blurRadius: shadow.blurRadius,
                        spreadRadius: shadow.spreadRadius,
                      ),
                    ),
              ],
            ),
            child: Padding(
              padding: widget.padding ?? defaultPadding,
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}

class _NeumorphicButtonWidget extends NeumorphicWidget {
  const _NeumorphicButtonWidget({
    required super.style,
    required super.isPressed,
    required super.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
