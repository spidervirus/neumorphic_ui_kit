import 'package:flutter/material.dart';
import 'neumorphic_colors.dart';
import 'neumorphic_properties.dart';

/// Data class for Neumorphic theme.
class NeumorphicThemeData {
  /// The base color for Neumorphic elements.
  final Color baseColor;

  /// The colors for Neumorphic elements.
  final NeumorphicColors colors;

  /// The properties for Neumorphic elements.
  final NeumorphicProperties properties;

  /// Creates a Neumorphic theme data.
  const NeumorphicThemeData({
    required this.baseColor,
    required this.colors,
    required this.properties,
  });

  /// Creates a light theme.
  factory NeumorphicThemeData.light() {
    return const NeumorphicThemeData(
      baseColor: Color(0xFFE0E0E0),
      colors: NeumorphicColors(
        shadowLightColor: Color.fromARGB(204, 255, 255, 255),
        shadowDarkColor: Color.fromARGB(51, 0, 0, 0),
      ),
      properties: NeumorphicProperties(),
    );
  }

  /// Creates a dark theme.
  factory NeumorphicThemeData.dark() {
    return const NeumorphicThemeData(
      baseColor: Color(0xFF303030),
      colors: NeumorphicColors(
        shadowLightColor: Color.fromARGB(26, 255, 255, 255),
        shadowDarkColor: Color.fromARGB(102, 0, 0, 0),
      ),
      properties: NeumorphicProperties(),
    );
  }

  /// Creates a copy of this theme data with the given fields replaced with new values.
  NeumorphicThemeData copyWith({
    Color? baseColor,
    NeumorphicColors? colors,
    NeumorphicProperties? properties,
  }) {
    return NeumorphicThemeData(
      baseColor: baseColor ?? this.baseColor,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
    );
  }
}

/// A widget that provides Neumorphic theme to its descendants.
class NeumorphicTheme extends InheritedWidget {
  /// The theme data for Neumorphic elements.
  final NeumorphicThemeData theme;

  /// Creates a Neumorphic theme.
  const NeumorphicTheme({
    super.key,
    required this.theme,
    required super.child,
  });

  /// Gets the current theme from the closest ancestor [NeumorphicTheme].
  static NeumorphicThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<NeumorphicTheme>();
    return theme?.theme ?? NeumorphicThemeData.light();
  }

  @override
  bool updateShouldNotify(NeumorphicTheme oldWidget) {
    return theme != oldWidget.theme;
  }
}
