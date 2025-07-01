import 'package:flutter/material.dart';
import '../base/neumorphic_widget.dart';
import '../../theme/neumorphic_properties.dart';
import '../icon/neumorphic_icon.dart';

/// An app bar widget with Neumorphic styling.
class NeumorphicAppBar extends StatefulWidget implements PreferredSizeWidget {
  /// The primary widget displayed in the app bar.
  final Widget? title;

  /// A widget to display before the title.
  final Widget? leading;

  /// Widgets to display after the title.
  final List<Widget>? actions;

  /// The height of the app bar.
  final double height;

  /// The style properties for this app bar.
  final NeumorphicProperties? style;

  /// The padding around the app bar content.
  final EdgeInsetsGeometry padding;

  /// Whether to show a back button if the page has a parent route.
  final bool automaticallyImplyLeading;

  /// The color of the app bar.
  final Color? backgroundColor;

  /// Creates a Neumorphic app bar.
  const NeumorphicAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.height = kToolbarHeight + 8.0,
    this.style,
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0),
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  State<NeumorphicAppBar> createState() => _NeumorphicAppBarState();
}

class _NeumorphicAppBarState extends State<NeumorphicAppBar> {
  late NeumorphicWidget _neumorphicWidget;

  @override
  void initState() {
    super.initState();
    _updateNeumorphicWidget();
  }

  @override
  void didUpdateWidget(NeumorphicAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateNeumorphicWidget();
  }

  void _updateNeumorphicWidget() {
    _neumorphicWidget = _NeumorphicAppBarWidget(
      style: widget.style?.copyWith(
        depth: (widget.style?.depth ?? 4) * 0.5,
        intensity: widget.style?.intensity ?? 0.5,
        surfaceIntensity: widget.style?.surfaceIntensity ?? 0.25,
      ),
      isPressed: false,
      enabled: true,
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (widget.leading != null) return widget.leading;

    if (widget.automaticallyImplyLeading) {
      final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
      if (parentRoute?.canPop ?? false) {
        return NeumorphicIcon(
          icon: Icons.arrow_back,
          onPressed: () => Navigator.of(context).maybePop(),
        );
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final leading = _buildLeading(context);
    final backgroundColor =
        widget.backgroundColor ?? Theme.of(context).colorScheme.surface;

    return Container(
      height: widget.preferredSize.height,
      decoration: _neumorphicWidget.buildNeumorphicDecoration(context).copyWith(
            color: backgroundColor,
          ),
      child: SafeArea(
        child: Padding(
          padding: widget.padding,
          child: Row(
            children: [
              if (leading != null) ...[
                leading,
                const SizedBox(width: 8),
              ],
              if (widget.title != null)
                Expanded(
                  child: DefaultTextStyle(
                    style: Theme.of(context).textTheme.titleLarge!,
                    child: widget.title!,
                  ),
                ),
              if (widget.actions != null) ...[
                ...widget.actions!.map((action) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: action,
                    )),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _NeumorphicAppBarWidget extends NeumorphicWidget {
  const _NeumorphicAppBarWidget({
    required super.style,
    required super.isPressed,
    required super.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
