<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Neumorphic UI Kit

A modern, customizable Flutter package for creating beautiful Neumorphic (soft UI) designs. This package provides a collection of widgets that implement the Neumorphic design style with smooth shadows and depth effects.

## Features

- 🎨 Customizable Neumorphic containers and buttons
- 🌓 Light and dark theme support
- 🎯 Highly customizable properties (depth, intensity, colors)
- 📱 Responsive and adaptive design
- ♿ Accessibility support
- 🚀 Optimized performance with cached shadows
- 📦 Easy to use and integrate

## Getting Started

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  neumorphic_ui_kit: ^0.0.1
```

## Usage

Here's a simple example of how to use the NeumorphicContainer:

```dart
import 'package:flutter/material.dart';
import 'package:neumorphic_ui_kit/neumorphic_ui_kit.dart';

void main() {
  runApp(
    NeumorphicTheme(
      theme: NeumorphicThemeData.light(),
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: NeumorphicContainer(
              width: 200,
              height: 200,
              child: Center(
                child: Text('Hello Neumorphic!'),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
```

## Customization

You can customize the appearance of Neumorphic widgets using `NeumorphicProperties`:

```dart
NeumorphicContainer(
  style: NeumorphicProperties(
    depth: 8,
    intensity: 0.7,
    surfaceIntensity: 0.3,
    cornerRadius: 20,
    lightSource: LightSource.topLeft,
    oppositeShadowLightSource: true,
  ),
  child: YourWidget(),
)
```

## Available Widgets

- `NeumorphicContainer` - Basic container with Neumorphic styling
- More widgets coming soon!

## Theme Support

The package includes a built-in theme system:

```dart
NeumorphicTheme(
  theme: NeumorphicThemeData.light(), // or .dark()
  child: YourApp(),
)
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
