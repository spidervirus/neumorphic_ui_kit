import 'package:flutter/material.dart';
import '../base/neumorphic_widget.dart';
import '../../theme/neumorphic_properties.dart';

/// A checkbox widget with Neumorphic styling.
class NeumorphicCheckbox extends StatefulWidget {
  /// Whether the checkbox is checked.
  final bool value;

  /// Called when the checkbox is tapped.
  final ValueChanged<bool>? onChanged;

  /// The style properties for this checkbox.
  final NeumorphicProperties? style;

  /// The size of the checkbox.
  final double size;

  /// The color of the check mark when checked.
  final Color? checkColor;

  /// Whether the checkbox is enabled.
  final bool enabled;

  /// The duration of the press and check animations.
  final Duration animationDuration;

  /// Creates a Neumorphic checkbox.
  const NeumorphicCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.style,
    this.size = 24.0,
    this.checkColor,
    this.enabled = true,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  State<NeumorphicCheckbox> createState() => _NeumorphicCheckboxState();
}

class _NeumorphicCheckboxState extends State<NeumorphicCheckbox>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pressAnimation;
  bool _isPressed = false;
  late NeumorphicWidget _neumorphicWidget;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
      value: widget.value ? 1.0 : 0.0,
    );
    _pressAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _updateNeumorphicWidget();
  }

  @override
  void didUpdateWidget(NeumorphicCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (widget.value) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
    _updateNeumorphicWidget();
  }

  void _updateNeumorphicWidget() {
    _neumorphicWidget = _NeumorphicCheckboxWidget(
      style: widget.style,
      isPressed: _isPressed,
      enabled: widget.enabled,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.enabled || widget.onChanged == null) return;
    setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.enabled || widget.onChanged == null) return;
    setState(() => _isPressed = false);
    widget.onChanged?.call(!widget.value);
  }

  void _handleTapCancel() {
    if (!widget.enabled || widget.onChanged == null) return;
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final defaultColor = Theme.of(context).colorScheme.primary;
    final checkColor = widget.checkColor ?? Colors.white;

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
            decoration: _neumorphicWidget.buildNeumorphicDecoration(context),
            child: Stack(
              children: [
                if (widget.value)
                  Positioned.fill(
                    child: Center(
                      child: AnimatedContainer(
                        duration: widget.animationDuration,
                        decoration: BoxDecoration(
                          color: widget.enabled ? defaultColor : Colors.grey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        width: widget.size * 0.8,
                        height: widget.size * 0.8,
                        child: Icon(
                          Icons.check,
                          color: checkColor,
                          size: widget.size * 0.6,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _NeumorphicCheckboxWidget extends NeumorphicWidget {
  const _NeumorphicCheckboxWidget({
    required super.style,
    required super.isPressed,
    required super.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
