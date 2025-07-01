import 'package:flutter/material.dart';
import '../../theme/neumorphic_theme.dart';
import '../../theme/neumorphic_properties.dart';

/// Base class for all Neumorphic widgets.
/// Provides common functionality and styling for Neumorphic design.
abstract class NeumorphicWidget extends StatelessWidget {
  /// The style properties for this widget.
  final NeumorphicProperties? style;

  /// Whether the widget is currently pressed.
  final bool isPressed;

  /// Whether the widget is enabled.
  final bool enabled;

  /// Creates a Neumorphic widget.
  const NeumorphicWidget({
    super.key,
    this.style,
    this.isPressed = false,
    this.enabled = true,
  });

  /// Gets the theme data from the context.
  NeumorphicThemeData getThemeData(BuildContext context) {
    return NeumorphicTheme.of(context);
  }

  /// Gets the offset for a light source
  @protected
  Offset _getLightSourceOffset(LightSource source) {
    switch (source) {
      case LightSource.topLeft:
        return const Offset(-1, -1);
      case LightSource.top:
        return const Offset(0, -1);
      case LightSource.topRight:
        return const Offset(1, -1);
      case LightSource.right:
        return const Offset(1, 0);
      case LightSource.bottomRight:
        return const Offset(1, 1);
      case LightSource.bottom:
        return const Offset(0, 1);
      case LightSource.bottomLeft:
        return const Offset(-1, 1);
      case LightSource.left:
        return const Offset(-1, 0);
      case LightSource.center:
        return Offset.zero;
    }
  }

  /// Builds the Neumorphic decoration for this widget.
  BoxDecoration buildNeumorphicDecoration(BuildContext context) {
    const defaultProperties = NeumorphicProperties(
      depth: 4,
      intensity: 0.5,
      surfaceIntensity: 0.25,
      cornerRadius: 12,
      lightSource: LightSource.topLeft,
      oppositeShadowLightSource: true,
    );
    final properties = style ?? defaultProperties;
    final depth = properties.depth;
    final intensity = properties.intensity;
    final surfaceIntensity = properties.surfaceIntensity;
    final cornerRadius = properties.cornerRadius;
    final lightSource = properties.lightSource;
    final oppositeShadowLightSource = properties.oppositeShadowLightSource;

    // Calculate shadow offset based on light source
    final lightSourceOffset = _getLightSourceOffset(lightSource);
    final offsetX = lightSourceOffset.dx * depth;
    final offsetY = lightSourceOffset.dy * depth;

    // Calculate shadow properties
    final blurRadius = depth.abs() * 2.0;
    final spreadRadius = depth.abs() * 0.5;

    // Calculate shadow colors based on intensity
    final backgroundColor = Theme.of(context).colorScheme.surface;
    final shadowIntensity = isPressed ? intensity * 0.5 : intensity;
    final surfaceIntensityValue =
        isPressed ? surfaceIntensity * 0.5 : surfaceIntensity;

    // Calculate light and dark shadow colors
    final lightColor = Color.lerp(
      backgroundColor,
      Colors.white,
      shadowIntensity,
    )!;
    final darkColor = Color.lerp(
      backgroundColor,
      Colors.black,
      shadowIntensity,
    )!;

    // Calculate surface color
    final surfaceColor = enabled
        ? Color.lerp(
            backgroundColor,
            isPressed ? Colors.black : Colors.white,
            surfaceIntensityValue,
          )!
        : Colors.grey.shade300;

    // Create shadow list
    final List<BoxShadow> shadows = [];

    // Only add shadows if the widget is enabled
    if (enabled) {
      // Light shadow
      shadows.add(BoxShadow(
        color: lightColor,
        offset: isPressed
            ? Offset(-offsetX, -offsetY)
            : Offset(
                oppositeShadowLightSource ? -offsetX : offsetX,
                oppositeShadowLightSource ? -offsetY : offsetY,
              ),
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      ));

      // Dark shadow
      shadows.add(BoxShadow(
        color: darkColor,
        offset: isPressed
            ? Offset(offsetX, offsetY)
            : Offset(
                oppositeShadowLightSource ? offsetX : -offsetX,
                oppositeShadowLightSource ? offsetY : -offsetY,
              ),
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      ));
    }

    return BoxDecoration(
      color: surfaceColor,
      borderRadius: BorderRadius.circular(cornerRadius),
      boxShadow: shadows,
    );
  }
}
