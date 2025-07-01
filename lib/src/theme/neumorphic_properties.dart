/// The source of light for the Neumorphic effect.
enum LightSource {
  /// Light source from top left corner
  topLeft,

  /// Light source from top
  top,

  /// Light source from top right corner
  topRight,

  /// Light source from right
  right,

  /// Light source from bottom right corner
  bottomRight,

  /// Light source from bottom
  bottom,

  /// Light source from bottom left corner
  bottomLeft,

  /// Light source from left
  left,

  /// Light source from center (no directional shadow)
  center,
}

/// Properties for Neumorphic styling.
class NeumorphicProperties {
  /// The depth of the shadow effect.
  final double depth;

  /// The intensity of the shadow effect.
  final double intensity;

  /// The intensity of the surface lighting effect.
  final double surfaceIntensity;

  /// The radius of the corners.
  final double cornerRadius;

  /// The source of the light.
  final LightSource lightSource;

  /// Whether to use opposite shadow for light source.
  final bool oppositeShadowLightSource;

  /// Creates a set of Neumorphic properties.
  const NeumorphicProperties({
    this.depth = 4.0,
    this.intensity = 0.5,
    this.surfaceIntensity = 0.25,
    this.cornerRadius = 12.0,
    this.lightSource = LightSource.topLeft,
    this.oppositeShadowLightSource = true,
  })  : assert(depth >= 0.0),
        assert(intensity >= 0.0 && intensity <= 1.0),
        assert(surfaceIntensity >= 0.0 && surfaceIntensity <= 1.0),
        assert(cornerRadius >= 0.0);

  /// Creates a copy of this NeumorphicProperties but with the given fields replaced with the new values.
  NeumorphicProperties copyWith({
    double? depth,
    double? intensity,
    double? surfaceIntensity,
    double? cornerRadius,
    LightSource? lightSource,
    bool? oppositeShadowLightSource,
  }) {
    return NeumorphicProperties(
      depth: depth ?? this.depth,
      intensity: intensity ?? this.intensity,
      surfaceIntensity: surfaceIntensity ?? this.surfaceIntensity,
      cornerRadius: cornerRadius ?? this.cornerRadius,
      lightSource: lightSource ?? this.lightSource,
      oppositeShadowLightSource:
          oppositeShadowLightSource ?? this.oppositeShadowLightSource,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NeumorphicProperties &&
        other.depth == depth &&
        other.intensity == intensity &&
        other.surfaceIntensity == surfaceIntensity &&
        other.cornerRadius == cornerRadius &&
        other.lightSource == lightSource &&
        other.oppositeShadowLightSource == oppositeShadowLightSource;
  }

  @override
  int get hashCode {
    return Object.hash(
      depth,
      intensity,
      surfaceIntensity,
      cornerRadius,
      lightSource,
      oppositeShadowLightSource,
    );
  }
}
