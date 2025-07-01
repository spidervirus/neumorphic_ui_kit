import 'package:flutter/material.dart';
import '../base/neumorphic_widget.dart';
import '../../theme/neumorphic_properties.dart';

/// A progress bar widget with Neumorphic styling.
class NeumorphicProgressBar extends StatefulWidget {
  /// The current progress value between 0.0 and 1.0.
  final double progress;

  /// The style properties for this progress bar.
  final NeumorphicProperties? style;

  /// The height of the progress bar.
  final double height;

  /// The width of the progress bar.
  final double? width;

  /// The color of the progress indicator.
  final Color? progressColor;

  /// The color of the background track.
  final Color? backgroundColor;

  /// The duration of the progress animation.
  final Duration animationDuration;

  /// Whether the progress bar is enabled.
  final bool enabled;

  /// Creates a Neumorphic progress bar.
  const NeumorphicProgressBar({
    super.key,
    required this.progress,
    this.style,
    this.height = 20.0,
    this.width,
    this.progressColor,
    this.backgroundColor,
    this.animationDuration = const Duration(milliseconds: 300),
    this.enabled = true,
  }) : assert(progress >= 0.0 && progress <= 1.0);

  @override
  State<NeumorphicProgressBar> createState() => _NeumorphicProgressBarState();
}

class _NeumorphicProgressBarState extends State<NeumorphicProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  late NeumorphicWidget _backgroundWidget;
  late NeumorphicWidget _progressWidget;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.progress,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));
    _updateNeumorphicWidgets();
    _progressController.forward();
  }

  @override
  void didUpdateWidget(NeumorphicProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _progressAnimation = Tween<double>(
        begin: oldWidget.progress,
        end: widget.progress,
      ).animate(CurvedAnimation(
        parent: _progressController,
        curve: Curves.easeInOut,
      ));
      _progressController.forward(from: 0.0);
    }
    _updateNeumorphicWidgets();
  }

  void _updateNeumorphicWidgets() {
    _backgroundWidget = _NeumorphicProgressWidget(
      style: widget.style,
      isPressed: false,
      enabled: widget.enabled,
    );
    _progressWidget = _NeumorphicProgressWidget(
      style: NeumorphicProperties(
        depth: widget.style?.depth ?? 4, // Use positive depth for progress
        intensity: widget.style?.intensity ?? 0.5,
        surfaceIntensity: widget.style?.surfaceIntensity ?? 0.25,
        cornerRadius: widget.height / 2,
        lightSource: widget.style?.lightSource ?? LightSource.topLeft,
        oppositeShadowLightSource:
            widget.style?.oppositeShadowLightSource ?? true,
      ),
      isPressed: true, // Use pressed state to create inset effect
      enabled: widget.enabled,
    );
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = widget.width ?? constraints.maxWidth;
        final defaultProgressColor = Theme.of(context).colorScheme.primary;
        final backgroundColor = widget.backgroundColor ??
            Theme.of(context).colorScheme.surfaceContainerHighest;

        return Container(
          width: width,
          height: widget.height,
          decoration: _backgroundWidget
              .buildNeumorphicDecoration(context)
              .copyWith(
                color: widget.enabled ? backgroundColor : Colors.grey.shade300,
              ),
          child: AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    width: _progressAnimation.value * width,
                    child: Container(
                      decoration: _progressWidget
                          .buildNeumorphicDecoration(context)
                          .copyWith(
                            color: widget.enabled
                                ? widget.progressColor ?? defaultProgressColor
                                : Colors.grey,
                          ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class _NeumorphicProgressWidget extends NeumorphicWidget {
  const _NeumorphicProgressWidget({
    required super.style,
    required super.isPressed,
    required super.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
