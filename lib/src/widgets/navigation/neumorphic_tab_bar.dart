import 'package:flutter/material.dart';
import '../base/neumorphic_widget.dart';
import '../../theme/neumorphic_properties.dart';

/// A tab bar widget with Neumorphic styling.
class NeumorphicTabBar extends StatefulWidget {
  /// The list of tabs to display.
  final List<NeumorphicTab> tabs;

  /// The currently selected tab index.
  final int selectedIndex;

  /// Called when a tab is selected.
  final ValueChanged<int>? onTabSelected;

  /// The style properties for this tab bar.
  final NeumorphicProperties? style;

  /// The height of the tab bar.
  final double height;

  /// The padding around each tab.
  final EdgeInsetsGeometry padding;

  /// The spacing between tabs.
  final double spacing;

  /// The duration of the selection animation.
  final Duration animationDuration;

  /// Creates a Neumorphic tab bar.
  const NeumorphicTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    this.onTabSelected,
    this.style,
    this.height = 56.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.spacing = 4.0,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  State<NeumorphicTabBar> createState() => _NeumorphicTabBarState();
}

class _NeumorphicTabBarState extends State<NeumorphicTabBar> {
  late NeumorphicWidget _neumorphicWidget;
  late List<bool> _pressedStates;

  @override
  void initState() {
    super.initState();
    _pressedStates = List.filled(widget.tabs.length, false);
    _updateNeumorphicWidget();
  }

  @override
  void didUpdateWidget(NeumorphicTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tabs.length != widget.tabs.length) {
      _pressedStates = List.filled(widget.tabs.length, false);
    }
    _updateNeumorphicWidget();
  }

  void _updateNeumorphicWidget() {
    _neumorphicWidget = _NeumorphicTabBarWidget(
      style: widget.style?.copyWith(
        depth: (widget.style?.depth ?? 4) * 0.5,
        intensity: widget.style?.intensity ?? 0.5,
        surfaceIntensity: widget.style?.surfaceIntensity ?? 0.25,
      ),
      isPressed: false,
      enabled: true,
    );
  }

  void _handleTapDown(int index) {
    if (widget.onTabSelected == null) return;
    setState(() => _pressedStates[index] = true);
  }

  void _handleTapUp(int index) {
    if (widget.onTabSelected == null) return;
    setState(() => _pressedStates[index] = false);
    if (index != widget.selectedIndex) {
      widget.onTabSelected?.call(index);
    }
  }

  void _handleTapCancel(int index) {
    if (widget.onTabSelected == null) return;
    setState(() => _pressedStates[index] = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: _neumorphicWidget.buildNeumorphicDecoration(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(widget.tabs.length * 2 - 1, (index) {
          if (index.isOdd) {
            return SizedBox(width: widget.spacing);
          }

          final tabIndex = index ~/ 2;
          final tab = widget.tabs[tabIndex];
          final isSelected = tabIndex == widget.selectedIndex;
          final isPressed = _pressedStates[tabIndex];

          return Expanded(
            child: GestureDetector(
              onTapDown: (_) => _handleTapDown(tabIndex),
              onTapUp: (_) => _handleTapUp(tabIndex),
              onTapCancel: () => _handleTapCancel(tabIndex),
              child: AnimatedContainer(
                duration: widget.animationDuration,
                decoration: _NeumorphicTabWidget(
                  style: widget.style,
                  isPressed: isPressed || isSelected,
                  enabled: widget.onTabSelected != null,
                ).buildNeumorphicDecoration(context),
                padding: widget.padding,
                child: Center(
                  child: DefaultTextStyle(
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                    child: tab,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// A tab widget for use with [NeumorphicTabBar].
class NeumorphicTab extends StatelessWidget {
  /// The icon to display.
  final IconData? icon;

  /// The label to display.
  final String? label;

  /// Creates a Neumorphic tab.
  const NeumorphicTab({
    super.key,
    this.icon,
    this.label,
  }) : assert(icon != null || label != null);

  @override
  Widget build(BuildContext context) {
    if (icon != null && label != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24),
          const SizedBox(height: 4),
          Text(label!),
        ],
      );
    } else if (icon != null) {
      return Icon(icon, size: 24);
    } else {
      return Text(label!);
    }
  }
}

class _NeumorphicTabBarWidget extends NeumorphicWidget {
  const _NeumorphicTabBarWidget({
    required super.style,
    required super.isPressed,
    required super.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

class _NeumorphicTabWidget extends NeumorphicWidget {
  const _NeumorphicTabWidget({
    required super.style,
    required super.isPressed,
    required super.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
