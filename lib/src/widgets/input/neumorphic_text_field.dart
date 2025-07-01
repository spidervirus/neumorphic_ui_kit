import 'package:flutter/material.dart';
import '../base/neumorphic_widget.dart';
import '../../theme/neumorphic_properties.dart';

/// A concrete implementation of NeumorphicWidget for text fields.
class _NeumorphicTextFieldBase extends NeumorphicWidget {
  const _NeumorphicTextFieldBase({
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

/// A text field with Neumorphic styling.
class NeumorphicTextField extends StatefulWidget {
  /// The controller for the text field.
  final TextEditingController? controller;

  /// The initial value of the text field.
  final String? initialValue;

  /// The style for the text.
  final TextStyle? textStyle;

  /// The hint text to display when the text field is empty.
  final String? hintText;

  /// The style for the hint text.
  final TextStyle? hintStyle;

  /// The style properties for this text field.
  final NeumorphicProperties? style;

  /// Whether the text field is enabled.
  final bool enabled;

  /// Called when the text field's value changes.
  final ValueChanged<String>? onChanged;

  /// Called when the text field is submitted.
  final ValueChanged<String>? onSubmitted;

  /// Creates a Neumorphic text field.
  const NeumorphicTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.textStyle,
    this.hintText,
    this.hintStyle,
    this.style,
    this.enabled = true,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  State<NeumorphicTextField> createState() => _NeumorphicTextFieldState();
}

class _NeumorphicTextFieldState extends State<NeumorphicTextField> {
  late final _focusNode = FocusNode()
    ..addListener(() {
      setState(() {});
    });

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = TextStyle(
      color: widget.enabled
          ? Theme.of(context).colorScheme.onSurface
          : Theme.of(context)
              .colorScheme
              .onSurface
              .withAlpha((255 * 0.38).round()),
    );

    final defaultHintStyle = defaultTextStyle.copyWith(
      color: Theme.of(context)
          .colorScheme
          .onSurface
          .withAlpha((255 * 0.38).round()),
    );

    return Container(
      decoration: _NeumorphicTextFieldBase(
        style: widget.style,
        isPressed: _focusNode.hasFocus,
        enabled: widget.enabled,
      ).buildNeumorphicDecoration(context),
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        style: widget.textStyle ?? defaultTextStyle,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(12),
          hintText: widget.hintText,
          hintStyle: widget.hintStyle ?? defaultHintStyle,
        ),
        enabled: widget.enabled,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
      ),
    );
  }
}
