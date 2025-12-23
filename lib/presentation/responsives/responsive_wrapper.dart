import 'package:bundlegram/presentation/responsives/responsive_provider.dart';
import 'package:flutter/material.dart';

/// Main responsive builder widget
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ResponsiveInfo info) builder;

  const ResponsiveBuilder({
    required this.builder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final info = ResponsiveInfo.fromContext(context);
        return builder(context, info);
      },
    );
  }
}

/// Responsive builder with breakpoint-specific widgets
class ResponsiveBreakpoint extends StatelessWidget {
  final Widget phone;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveBreakpoint({
    required this.phone,
    this.tablet,
    this.desktop,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, info) {
        return info.when(
          phone: phone,
          tablet: tablet,
          desktop: desktop,
        );
      },
    );
  }
}

/// Responsive scaffold with optional side panel for tablets/desktops
class ResponsiveScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? sidePanel;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final FloatingActionButton? floatingActionButton;
  final Color? backgroundColor;
  final double? sidePanelWidth;

  const ResponsiveScaffold({
    required this.body,
    this.appBar,
    this.sidePanel,
    this.drawer,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.sidePanelWidth,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, info) {
        // Show side panel on tablets and desktops
        if ((info.isTablet || info.isDesktop) && sidePanel != null) {
          final panelWidth = sidePanelWidth ??
              info.when(
                phone: 0.0,
                tablet: 300.0,
                desktop: 360.0,
              );

          return Scaffold(
            appBar: appBar,
            backgroundColor: backgroundColor,
            body: Row(
              children: [
                Container(
                  width: panelWidth,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 1,
                      ),
                    ),
                  ),
                  child: sidePanel,
                ),
                Expanded(child: body),
              ],
            ),
            floatingActionButton: floatingActionButton,
          );
        }

        // Standard scaffold for phones
        return Scaffold(
          appBar: appBar,
          drawer: drawer,
          body: body,
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
          backgroundColor: backgroundColor,
        );
      },
    );
  }
}

/// Responsive padding wrapper
class ResponsivePadding extends StatelessWidget {
  final Widget child;
  final double? all;
  final double? horizontal;
  final double? vertical;
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;

  const ResponsivePadding({
    required this.child,
    this.all,
    this.horizontal,
    this.vertical,
    this.left,
    this.right,
    this.top,
    this.bottom,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final info = ResponsiveInfo.fromContext(context);
    return Padding(
      padding: info.padding(
        all: all,
        horizontal: horizontal,
        vertical: vertical,
        left: left,
        right: right,
        top: top,
        bottom: bottom,
      ),
      child: child,
    );
  }
}

/// Responsive sized box
class ResponsiveSizedBox extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;

  const ResponsiveSizedBox({
    this.child,
    this.width,
    this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final info = ResponsiveInfo.fromContext(context);
    return SizedBox(
      width: width != null ? info.spacing(width!) : null,
      height: height != null ? info.spacing(height!) : null,
      child: child,
    );
  }
}

/// Responsive gap (spacing)
class ResponsiveGap extends StatelessWidget {
  final double size;
  final Axis direction;

  const ResponsiveGap(
    this.size, {
    this.direction = Axis.vertical,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final info = ResponsiveInfo.fromContext(context);
    final scaledSize = info.spacing(size);

    return SizedBox(
      width: direction == Axis.horizontal ? scaledSize : null,
      height: direction == Axis.vertical ? scaledSize : null,
    );
  }
}
