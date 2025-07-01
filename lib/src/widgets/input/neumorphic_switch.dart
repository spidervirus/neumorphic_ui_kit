import 'package:flutter/material.dart';
import '../base/neumorphic_widget.dart';
import '../../theme/neumorphic_properties.dart';

/// A switch widget with Neumorphic styling.
class NeumorphicSwitch extends StatefulWidget {
  /// Whether the switch is currently on.
  final bool value;

  /// Called when the switch is toggled.
  final ValueChanged<bool>? onChanged;

  /// The style properties for this switch.
  final NeumorphicProperties? style;

  /// The width of the switch.
  final double width;

  /// The height of the switch.
  final double height;

  /// The duration of the toggle animation.
  final Duration toggleDuration;

  /// The color of the thumb when the switch is on.
  final Color? activeThumbColor;

  /// The color of the thumb when the switch is off.
  final Color? inactiveThumbColor;

  /// Whether the switch is enabled.
  final bool enabled;

  /// Creates a Neumorphic switch.
  const NeumorphicSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.style,
    this.width = 60.0,
    this.height = 32.0,
    this.toggleDuration = const Duration(milliseconds: 200),
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.enabled = true,
  });

  @override
  State<NeumorphicSwitch> createState() => _NeumorphicSwitchState();
}

class _NeumorphicSwitchState extends State<NeumorphicSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _toggleController;
  late Animation<double> _toggleAnimation;
  late NeumorphicWidget _neumorphicWidget;
  late NeumorphicWidget _thumbWidget;

  @override
  void initState() {
    super.initState();
    _toggleController = AnimationController(
      vsync: this,
      duration: widget.toggleDuration,
      value: widget.value ? 1.0 : 0.0,
    );
    _toggleAnimation = CurvedAnimation(
      parent: _toggleController,
      curve: Curves.easeInOut,
    );
    _updateNeumorphicWidgets();
  }

  @override
  void didUpdateWidget(NeumorphicSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _toggleController.forward();
      } else {
        _toggleController.reverse();
      }
    }
    _updateNeumorphicWidgets();
  }

  void _updateNeumorphicWidgets() {
    _neumorphicWidget = _NeumorphicSwitchWidget(
      style: widget.style,
      isPressed: false,
      enabled: widget.enabled,
    );
    _thumbWidget = _NeumorphicSwitchWidget(
      style: NeumorphicProperties(
        depth: (widget.style?.depth ?? 4) * 0.75,
        intensity: widget.style?.intensity ?? 0.5,
        surfaceIntensity: widget.style?.surfaceIntensity ?? 0.25,
        cornerRadius: widget.height / 2,
        lightSource: widget.style?.lightSource ?? LightSource.topLeft,
        oppositeShadowLightSource:
            widget.style?.oppositeShadowLightSource ?? true,
      ),
      isPressed: false,
      enabled: widget.enabled,
    );
  }

  @override
  void dispose() {
    _toggleController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (!widget.enabled) return;
    if (widget.onChanged != null) {
      widget.onChanged!(!widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final thumbSize = widget.height - 4;
    final trackWidth = widget.width;
    final trackHeight = widget.height;
    final defaultActiveColor = Theme.of(context).colorScheme.primary;
    final inactiveTrackColor = widget.enabled
        ? Theme.of(context).colorScheme.surfaceContainerHighest
        : Colors.grey;

    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _toggleAnimation,
        builder: (context, child) {
          return Container(
            width: trackWidth,
            height: trackHeight,
            decoration: _neumorphicWidget.buildNeumorphicDecoration(context),
            child: Stack(
              children: [
                // Thumb
                Positioned(
                  left: 2 +
                      (_toggleAnimation.value * (trackWidth - thumbSize - 4)),
                  top: 2,
                  child: Container(
                    width: thumbSize,
                    height: thumbSize,
                    decoration: _thumbWidget
                        .buildNeumorphicDecoration(context)
                        .copyWith(
                          color: widget.enabled
                              ? (_toggleAnimation.value > 0.5
                                  ? widget.activeThumbColor ??
                                      defaultActiveColor
                                  : widget.inactiveThumbColor ??
                                      inactiveTrackColor)
                              : Colors.grey,
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

class _NeumorphicSwitchWidget extends NeumorphicWidget {
  const _NeumorphicSwitchWidget({
    required super.style,
    required super.isPressed,
    required super.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
