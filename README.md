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

A modern, customizable Flutter package for creating beautiful Neumorphic (soft UI) designs. This package provides a comprehensive collection of widgets that implement the Neumorphic design style with smooth shadows, depth effects, and interactive animations.

## Features

- 🎨 Rich set of Neumorphic widgets for common UI elements
- 🌓 Built-in light and dark theme support
- 🎯 Highly customizable properties (depth, intensity, colors, light source)
- 📱 Responsive and adaptive design
- ♿ Accessibility support
- 🚀 Optimized performance with cached shadows
- 💫 Smooth press animations
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
      theme: NeumorphicThemeData.light(), // or .dark() for dark theme
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: NeumorphicContainer(
              width: 200,
              height: 200,
              style: NeumorphicProperties(
                depth: 8,
                intensity: 0.7,
                surfaceIntensity: 0.3,
                cornerRadius: 20,
                lightSource: LightSource.topLeft,
              ),
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

## Available Widgets

### Basic Elements
- `NeumorphicContainer` - Basic container with Neumorphic styling
- `NeumorphicCard` - Card widget with optional tap interaction
- `NeumorphicIcon` - Icon with Neumorphic effect

### Buttons
- `NeumorphicButton` - Standard button with press animation
- `NeumorphicFloatingActionButton` - Floating action button with Neumorphic style

### Input Elements
- `NeumorphicTextField` - Text input field
- `NeumorphicCheckbox` - Checkbox with Neumorphic styling
- `NeumorphicRadio` - Radio button
- `NeumorphicSlider` - Slider control
- `NeumorphicSwitch` - Toggle switch

### Navigation
- `NeumorphicAppBar` - Application bar with Neumorphic styling
- `NeumorphicBottomNavigationBar` - Bottom navigation with Neumorphic items
- `NeumorphicTabBar` - Tab bar with Neumorphic tabs

### Progress & Status
- `NeumorphicProgressBar` - Progress indicator
- `NeumorphicBadge` - Badge for showing notifications or status

## Customization

You can customize the appearance of any Neumorphic widget using `NeumorphicProperties`:

```dart
NeumorphicProperties(
  depth: 8.0,               // Shadow depth
  intensity: 0.5,           // Shadow intensity
  surfaceIntensity: 0.25,   // Surface lighting intensity
  cornerRadius: 12.0,       // Corner radius
  lightSource: LightSource.topLeft,  // Light source direction
  oppositeShadowLightSource: true,   // Use opposite shadow for light source
)
```

## Theme Support

The package includes a built-in theme system with support for both light and dark modes:

```dart
NeumorphicTheme(
  theme: NeumorphicThemeData.light(), // For light theme
  // or
  theme: NeumorphicThemeData.dark(),  // For dark theme
  child: YourApp(),
)
```

You can also customize the theme colors:

```dart
NeumorphicThemeData(
  baseColor: Color(0xFFE0E0E0),
  colors: NeumorphicColors(
    shadowLightColor: Color.fromARGB(204, 255, 255, 255),
    shadowDarkColor: Color.fromARGB(51, 0, 0, 0),
    accentColor: Colors.blue,
    textColor: Colors.black,
    disabledColor: Colors.grey,
  ),
  properties: NeumorphicProperties(...),
)
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

[![pub package](https://img.shields.io/pub/v/neumorphic_ui_kit.svg)](https://pub.dev/packages/neumorphic_ui_kit)
[![likes](https://img.shields.io/pub/likes/neumorphic_ui_kit)](https://pub.dev/packages/neumorphic_ui_kit/score)
[![popularity](https://img.shields.io/pub/popularity/neumorphic_ui_kit)](https://pub.dev/packages/neumorphic_ui_kit/score)
[![pub points](https://img.shields.io/pub/points/neumorphic_ui_kit)](https://pub.dev/packages/neumorphic_ui_kit/score)
