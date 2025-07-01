import 'package:flutter/material.dart';
import '../base/neumorphic_widget.dart';
import '../../theme/neumorphic_properties.dart';

/// A concrete implementation of NeumorphicWidget for radio buttons.
class _NeumorphicRadioBase extends NeumorphicWidget {
  const _NeumorphicRadioBase({
    required super.style,
    required super.isPressed,
    required super.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buildNeumorphicDecoration(context),
    );
  }
}

/// A radio button with Neumorphic styling.
class NeumorphicRadio<T> extends StatefulWidget {
  /// The value represented by this radio button.
  final T value;

  /// The currently selected value for the radio button group.
  final T? groupValue;

  /// Called when the radio button is selected.
  final ValueChanged<T>? onChanged;

  /// The padding around the radio button.
  final EdgeInsetsGeometry padding;

  /// The child widget to display inside the radio button.
  final Widget? child;

  /// The duration of the press animation.
  final Duration pressDuration;

  /// The style properties for this radio button.
  final NeumorphicProperties? style;

  /// Whether the radio button is enabled.
  final bool enabled;

  /// Creates a Neumorphic radio button.
  const NeumorphicRadio({
    super.key,
    required this.value,
    required this.groupValue,
    this.onChanged,
    this.padding = const EdgeInsets.all(12.0),
    this.pressDuration = const Duration(milliseconds: 100),
    this.style,
    this.enabled = true,
    this.child,
  });

  @override
  State<NeumorphicRadio<T>> createState() => _NeumorphicRadioState<T>();
}

class _NeumorphicRadioState<T> extends State<NeumorphicRadio<T>> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    if (!widget.enabled) return;
    setState(() {
      _isPressed = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.enabled) return;
    setState(() {
      _isPressed = false;
    });
    if (widget.value != widget.groupValue) {
      widget.onChanged?.call(widget.value);
    }
  }

  void _handleTapCancel() {
    if (!widget.enabled) return;
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSelected = widget.value == widget.groupValue;
    final defaultColor = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedContainer(
        duration: widget.pressDuration,
        padding: widget.padding,
        decoration: _NeumorphicRadioBase(
          style: widget.style,
          isPressed: _isPressed || isSelected,
          enabled: widget.enabled,
        ).buildNeumorphicDecoration(context),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isSelected)
              Positioned.fill(
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: widget.enabled ? defaultColor : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            if (widget.child != null)
              Padding(
                padding: const EdgeInsets.all(4),
                child: widget.child,
              ),
          ],
        ),
      ),
    );
  }
}

/// A group of radio buttons with Neumorphic styling.
class NeumorphicRadioGroup<T> extends StatelessWidget {
  /// The currently selected value.
  final T value;

  /// Called when a radio button is selected.
  final ValueChanged<T>? onChanged;

  /// The list of radio buttons in this group.
  final List<NeumorphicRadio<T>> children;

  /// The direction of the radio buttons.
  final Axis direction;

  /// The spacing between radio buttons.
  final double spacing;

  /// Creates a Neumorphic radio group.
  const NeumorphicRadioGroup({
    super.key,
    required this.value,
    required this.onChanged,
    required this.children,
    this.direction = Axis.horizontal,
    this.spacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> radioButtons = children.map((radio) {
      return NeumorphicRadio<T>(
        value: radio.value,
        groupValue: value,
        onChanged: onChanged,
        style: radio.style,
        child: radio.child,
        padding: radio.padding,
        enabled: radio.enabled && onChanged != null,
        pressDuration: radio.pressDuration,
      );
    }).toList();

    return direction == Axis.horizontal
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: radioButtons
                .separated(
                  (index) => SizedBox(width: spacing),
                )
                .toList(),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: radioButtons
                .separated(
                  (index) => SizedBox(height: spacing),
                )
                .toList(),
          );
  }
}

extension _ListSeparationExtension<T> on List<T> {
  Iterable<T> separated(T Function(int index) separator) sync* {
    for (var i = 0; i < length; i++) {
      yield this[i];
      if (i < length - 1) {
        yield separator(i);
      }
    }
  }
}
