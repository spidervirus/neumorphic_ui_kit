import 'package:flutter/material.dart';
import '../base/neumorphic_widget.dart';
import '../../theme/neumorphic_properties.dart';
import '../badge/neumorphic_badge.dart';

/// A bottom navigation item for use with [NeumorphicBottomNavigationBar].
class NeumorphicBottomNavigationBarItem {
  /// The icon to display.
  final IconData icon;

  /// The label to display.
  final String? label;

  /// The badge to display.
  final NeumorphicBadge? badge;

  /// Creates a bottom navigation item.
  const NeumorphicBottomNavigationBarItem({
    required this.icon,
    this.label,
    this.badge,
  });
}

/// A bottom navigation bar with Neumorphic styling.
class NeumorphicBottomNavigationBar extends StatefulWidget {
  /// The list of navigation items.
  final List<NeumorphicBottomNavigationBarItem> items;

  /// The currently selected item index.
  final int selectedIndex;

  /// Called when an item is selected.
  final ValueChanged<int>? onItemSelected;

  /// The style properties for this navigation bar.
  final NeumorphicProperties? style;

  /// The height of the navigation bar.
  final double height;

  /// Whether to show labels.
  final bool showLabels;

  /// The duration of the selection animation.
  final Duration animationDuration;

  /// Creates a Neumorphic bottom navigation bar.
  const NeumorphicBottomNavigationBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    this.onItemSelected,
    this.style,
    this.height = 64.0,
    this.showLabels = true,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  State<NeumorphicBottomNavigationBar> createState() =>
      _NeumorphicBottomNavigationBarState();
}

class _NeumorphicBottomNavigationBarState
    extends State<NeumorphicBottomNavigationBar> {
  late NeumorphicWidget _neumorphicWidget;
  late List<bool> _pressedStates;

  @override
  void initState() {
    super.initState();
    _pressedStates = List.filled(widget.items.length, false);
    _updateNeumorphicWidget();
  }

  @override
  void didUpdateWidget(NeumorphicBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items.length != widget.items.length) {
      _pressedStates = List.filled(widget.items.length, false);
    }
    _updateNeumorphicWidget();
  }

  void _updateNeumorphicWidget() {
    _neumorphicWidget = _NeumorphicBottomNavBarWidget(
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
    if (widget.onItemSelected == null) return;
    setState(() => _pressedStates[index] = true);
  }

  void _handleTapUp(int index) {
    if (widget.onItemSelected == null) return;
    setState(() => _pressedStates[index] = false);
    if (index != widget.selectedIndex) {
      widget.onItemSelected?.call(index);
    }
  }

  void _handleTapCancel(int index) {
    if (widget.onItemSelected == null) return;
    setState(() => _pressedStates[index] = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: _neumorphicWidget.buildNeumorphicDecoration(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          widget.items.length,
          (index) => _buildNavigationItem(context, index),
        ),
      ),
    );
  }

  Widget _buildNavigationItem(BuildContext context, int index) {
    final item = widget.items[index];
    final isSelected = index == widget.selectedIndex;
    final isPressed = _pressedStates[index];

    Widget itemWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          item.icon,
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface,
        ),
        if (widget.showLabels && item.label != null) ...[
          const SizedBox(height: 4),
          Text(
            item.label!,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ],
      ],
    );

    if (item.badge != null) {
      itemWidget = NeumorphicBadgePositioned(
        child: itemWidget,
        badge: item.badge!,
      );
    }

    return Expanded(
      child: GestureDetector(
        onTapDown: (_) => _handleTapDown(index),
        onTapUp: (_) => _handleTapUp(index),
        onTapCancel: () => _handleTapCancel(index),
        child: AnimatedContainer(
          duration: widget.animationDuration,
          margin: const EdgeInsets.all(8),
          decoration: _NeumorphicNavItemWidget(
            style: widget.style,
            isPressed: isPressed || isSelected,
            enabled: widget.onItemSelected != null,
          ).buildNeumorphicDecoration(context),
          child: itemWidget,
        ),
      ),
    );
  }
}

class _NeumorphicBottomNavBarWidget extends NeumorphicWidget {
  const _NeumorphicBottomNavBarWidget({
    required super.style,
    required super.isPressed,
    required super.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

class _NeumorphicNavItemWidget extends NeumorphicWidget {
  const _NeumorphicNavItemWidget({
    required super.style,
    required super.isPressed,
    required super.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
