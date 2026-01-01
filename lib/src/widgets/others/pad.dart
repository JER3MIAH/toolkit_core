import 'package:flutter/material.dart';

/// A widget that applies padding to its child.
///
/// The [Pad] widget provides convenient constructors for common padding scenarios:
/// - [Pad] - applies uniform padding on all sides
/// - [Pad.vertical] - applies padding to top and bottom
/// - [Pad.horizontal] - applies padding to left and right
/// - [Pad.l] - applies padding to the left side only
/// - [Pad.r] - applies padding to the right side only
/// - [Pad.t] - applies padding to the top side only
/// - [Pad.b] - applies padding to the bottom side only
///
/// Example:
/// ```dart
/// // Uniform padding
/// Pad(16, child: Text('Hello'))
///
/// // Vertical padding
/// Pad.vertical(20, child: Text('Hello'))
///
/// // Left padding
/// Pad.l(12, child: Text('Hello'))
/// ```
class Pad extends StatelessWidget {
  final Widget child;
  final double all;
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;

  /// Creates a widget that applies uniform padding on all sides.
  ///
  /// The [all] parameter specifies the padding value for all sides.
  const Pad(this.all, {required this.child, super.key})
    : left = null,
      right = null,
      top = null,
      bottom = null;

  /// Creates a widget that applies padding to the top and bottom.
  ///
  /// The [value] parameter specifies the padding for both top and bottom.
  const Pad.vertical(double value, {required this.child, super.key})
    : all = 0,
      left = null,
      right = null,
      top = value,
      bottom = value;

  /// Creates a widget that applies padding to the left and right.
  ///
  /// The [value] parameter specifies the padding for both left and right.
  const Pad.horizontal(double value, {required this.child, super.key})
    : all = 0,
      left = value,
      right = value,
      top = null,
      bottom = null;

  /// Creates a widget that applies padding to the left side only.
  ///
  /// The [value] parameter specifies the left padding.
  const Pad.l(double value, {required this.child, super.key})
    : all = 0,
      left = value,
      right = null,
      top = null,
      bottom = null;

  /// Creates a widget that applies padding to the right side only.
  ///
  /// The [value] parameter specifies the right padding.
  const Pad.r(double value, {required this.child, super.key})
    : all = 0,
      left = null,
      right = value,
      top = null,
      bottom = null;

  /// Creates a widget that applies padding to the top side only.
  ///
  /// The [value] parameter specifies the top padding.
  const Pad.t(double value, {required this.child, super.key})
    : all = 0,
      left = null,
      right = null,
      top = value,
      bottom = null;

  /// Creates a widget that applies padding to the bottom side only.
  ///
  /// The [value] parameter specifies the bottom padding.
  const Pad.b(double value, {required this.child, super.key})
    : all = 0,
      left = null,
      right = null,
      top = null,
      bottom = value;

  @override
  Widget build(BuildContext context) {
    if (left != null || right != null || top != null || bottom != null) {
      return Padding(
        padding: EdgeInsets.only(
          left: left ?? 0,
          right: right ?? 0,
          top: top ?? 0,
          bottom: bottom ?? 0,
        ),
        child: child,
      );
    }
    return Padding(padding: EdgeInsets.all(all), child: child);
  }
}
