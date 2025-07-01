import 'package:flutter/material.dart';

/// Colors for Neumorphic elements.
class NeumorphicColors {
  /// The color of the light shadow.
  final Color shadowLightColor;

  /// The color of the dark shadow.
  final Color shadowDarkColor;

  /// The accent color for interactive elements.
  final Color accentColor;

  /// The text color.
  final Color textColor;

  /// The color for disabled elements.
  final Color disabledColor;

  /// Creates a set of colors for Neumorphic elements.
  const NeumorphicColors({
    required this.shadowLightColor,
    required this.shadowDarkColor,
    this.accentColor = const Color(0xFF2196F3), // Material Blue
    this.textColor = const Color(0xFF000000),
    this.disabledColor = const Color(0xFF9E9E9E),
  });

  /// Creates a copy of this NeumorphicColors but with the given fields replaced with the new values.
  NeumorphicColors copyWith({
    Color? shadowLightColor,
    Color? shadowDarkColor,
    Color? accentColor,
    Color? textColor,
    Color? disabledColor,
  }) {
    return NeumorphicColors(
      shadowLightColor: shadowLightColor ?? this.shadowLightColor,
      shadowDarkColor: shadowDarkColor ?? this.shadowDarkColor,
      accentColor: accentColor ?? this.accentColor,
      textColor: textColor ?? this.textColor,
      disabledColor: disabledColor ?? this.disabledColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NeumorphicColors &&
        other.shadowLightColor == shadowLightColor &&
        other.shadowDarkColor == shadowDarkColor &&
        other.accentColor == accentColor &&
        other.textColor == textColor &&
        other.disabledColor == disabledColor;
  }

  @override
  int get hashCode {
    return Object.hash(
      shadowLightColor,
      shadowDarkColor,
      accentColor,
      textColor,
      disabledColor,
    );
  }
}
