import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  static const int mobileBreakpoint = 850;
  static const int tabletBreakpoint = 1100;

  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.desktop,
    required this.mobile,
    required this.tablet,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileBreakpoint &&
      MediaQuery.of(context).size.width < tabletBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletBreakpoint;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    if (width >= tabletBreakpoint) {
      return desktop;
    } else if (width >= mobileBreakpoint) {
      return tablet;
    } else {
      return mobile;
    }
  }
}