import 'package:flutter/material.dart';
import '../base/neumorphic_widget.dart';
import '../../theme/neumorphic_properties.dart';

/// A card widget with Neumorphic styling.
class NeumorphicCard extends StatefulWidget {
  /// The child widget to display inside the card.
  final Widget child;

  /// The style properties for this card.
  final NeumorphicProperties? style;

  /// The padding around the child widget.
  final EdgeInsetsGeometry padding;

  /// Called when the card is tapped.
  final VoidCallback? onTap;

  /// Whether the card is enabled.
  final bool enabled;

  /// The duration of the press animation.
  final Duration pressDuration;

  /// Creates a Neumorphic card.
  const NeumorphicCard({
    super.key,
    required this.child,
    this.style,
    this.padding = const EdgeInsets.all(16.0),
    this.onTap,
    this.enabled = true,
    this.pressDuration = const Duration(milliseconds: 100),
  });

  @override
  State<NeumorphicCard> createState() => _NeumorphicCardState();
}

class _NeumorphicCardState extends State<NeumorphicCard>
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
  void didUpdateWidget(NeumorphicCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateNeumorphicWidget();
  }

  void _updateNeumorphicWidget() {
    _neumorphicWidget = _NeumorphicCardWidget(
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
    if (!widget.enabled || widget.onTap == null) return;
    setState(() => _isPressed = true);
    _pressController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.enabled || widget.onTap == null) return;
    setState(() => _isPressed = false);
    _pressController.reverse();
  }

  void _handleTapCancel() {
    if (!widget.enabled || widget.onTap == null) return;
    setState(() => _isPressed = false);
    _pressController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.enabled ? widget.onTap : null,
      child: AnimatedBuilder(
        animation: _pressAnimation,
        builder: (context, child) {
          return Container(
            decoration: _neumorphicWidget.buildNeumorphicDecoration(context),
            child: Padding(
              padding: widget.padding,
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}

class _NeumorphicCardWidget extends NeumorphicWidget {
  const _NeumorphicCardWidget({
    required super.style,
    required super.isPressed,
    required super.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
