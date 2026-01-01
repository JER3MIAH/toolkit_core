import 'package:flutter/material.dart';

/// A widget that conditionally wraps its child in an [Expanded] widget.
///
/// [ExpandIf] provides a convenient way to conditionally make a widget expand
/// to fill available space in a [Row], [Column], or [Flex]. When [expand] is true,
/// the [child] is wrapped in an [Expanded] widget. When false, the [child] is
/// returned as-is.
///
/// This is particularly useful when you need to conditionally control widget
/// expansion based on dynamic conditions without restructuring your widget tree.
///
/// Example:
/// ```dart
/// Row(
///   children: [
///     ExpandIf(
///       expand: shouldExpand,
///       child: Container(
///         color: Colors.blue,
///         child: Text('I might expand'),
///       ),
///     ),
///     Text('Fixed size'),
///   ],
/// )
/// ```
class ExpandIf extends StatelessWidget {
  /// Whether to wrap the child in an [Expanded] widget.
  final bool expand;

  /// The widget to conditionally expand.
  final Widget child;

  const ExpandIf({required this.expand, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return expand ? Expanded(child: child) : child;
  }
}
