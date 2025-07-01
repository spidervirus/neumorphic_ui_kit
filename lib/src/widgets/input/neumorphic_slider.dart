import 'package:flutter/material.dart';
import '../base/neumorphic_widget.dart';
import '../../theme/neumorphic_properties.dart';

/// A slider widget with Neumorphic styling.
class NeumorphicSlider extends StatefulWidget {
  /// The current value of the slider.
  final double value;

  /// Called when the slider value changes.
  final ValueChanged<double>? onChanged;

  /// The minimum value the slider can have.
  final double min;

  /// The maximum value the slider can have.
  final double max;

  /// The number of discrete divisions the slider can move in.
  final int? divisions;

  /// The style properties for this slider.
  final NeumorphicProperties? style;

  /// The height of the slider track.
  final double height;

  /// The width of the slider track.
  final double? width;

  /// The color of the active portion of the track.
  final Color? activeTrackColor;

  /// The color of the inactive portion of the track.
  final Color? inactiveTrackColor;

  /// The color of the thumb.
  final Color? thumbColor;

  /// Whether the slider is enabled.
  final bool enabled;

  /// Creates a Neumorphic slider.
  const NeumorphicSlider({
    super.key,
    required this.value,
    this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.style,
    this.height = 20.0,
    this.width,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.thumbColor,
    this.enabled = true,
  })  : assert(min <= max),
        assert(value >= min && value <= max);

  @override
  State<NeumorphicSlider> createState() => _NeumorphicSliderState();
}

class _NeumorphicSliderState extends State<NeumorphicSlider> {
  bool _isPressed = false;
  late final _thumbWidget = _NeumorphicSliderThumbWidget(
    style: widget.style,
    isPressed: _isPressed,
    enabled: widget.enabled,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(NeumorphicSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  double _calculateValue(Offset localPosition, double width) {
    final double visualPosition = localPosition.dx.clamp(0.0, width);
    final double normalizedValue = visualPosition / width;
    final double value =
        widget.min + (widget.max - widget.min) * normalizedValue;

    if (widget.divisions != null) {
      final double step = (widget.max - widget.min) / widget.divisions!;
      return (value / step).round() * step;
    }
    return value;
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.enabled) return;
    setState(() => _isPressed = true);
  }

  void _handleDragStart(DragStartDetails details) {
    if (!widget.enabled) return;
    setState(() => _isPressed = true);
  }

  void _handleDragUpdate(
      DragUpdateDetails details, BoxConstraints constraints) {
    if (!widget.enabled) return;
    final RenderBox box = context.findRenderObject() as RenderBox;
    final double value = _calculateValue(
      box.globalToLocal(details.globalPosition),
      constraints.maxWidth,
    );
    widget.onChanged?.call(value);
  }

  void _handleDragEnd(DragEndDetails details) {
    if (!widget.enabled) return;
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = widget.width ?? constraints.maxWidth;
        final thumbSize = widget.height;
        final trackHeight = widget.height;
        final defaultActiveColor = Theme.of(context).colorScheme.primary;
        final trackColor =
            Theme.of(context).colorScheme.surfaceContainerHighest;
        final normalizedValue =
            (widget.value - widget.min) / (widget.max - widget.min);

        return GestureDetector(
          onTapDown: _handleTapDown,
          onHorizontalDragStart: _handleDragStart,
          onHorizontalDragUpdate: (details) =>
              _handleDragUpdate(details, constraints),
          onHorizontalDragEnd: _handleDragEnd,
          child: Container(
            width: width,
            height: trackHeight,
            decoration: BoxDecoration(
              color: widget.enabled ? trackColor : Colors.grey,
              borderRadius: BorderRadius.circular(trackHeight / 2),
            ),
            child: Stack(
              children: [
                // Active Track
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  width: normalizedValue * width,
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.enabled
                          ? widget.activeTrackColor ?? defaultActiveColor
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(trackHeight / 2),
                    ),
                  ),
                ),
                // Thumb
                Positioned(
                  left: (normalizedValue * (width - thumbSize)),
                  top: 0,
                  child: Container(
                    width: thumbSize,
                    height: thumbSize,
                    decoration: _thumbWidget
                        .buildNeumorphicDecoration(context)
                        .copyWith(
                          color: widget.enabled
                              ? widget.thumbColor ?? defaultActiveColor
                              : Colors.grey,
                        ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NeumorphicSliderThumbWidget extends NeumorphicWidget {
  const _NeumorphicSliderThumbWidget({
    required super.style,
    required super.isPressed,
    required super.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
