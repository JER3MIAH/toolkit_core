import 'package:flutter/widgets.dart';

/// A flexible spacer widget that adapts its size based on the parent [Flex] direction.
///
/// [Box] creates a [SizedBox] with a specified [size] that automatically adjusts
/// its width or height depending on whether it's placed inside a [Row] (horizontal)
/// or [Column] (vertical) widget.
///
/// - When used in a [Row], the width is set to [size] and height is 0.
/// - When used in a [Column], the width is 0 and height is set to [size].
///
/// This widget must be used as a descendant of a [Row] or [Column] widget.
/// An assertion error will be thrown if used outside of a [Flex] widget.
///
/// Example usage:
/// ```dart
/// Row(
///   children: [
///     Text('Left'),
///     Box(16),  // Adds 16 pixels of horizontal spacing
///     Text('Right'),
///   ],
/// )
/// ```

class Box extends StatelessWidget {
  final double size;

  const Box(this.size, {super.key});
  @override
  Widget build(BuildContext context) {
    final flex = context.findAncestorWidgetOfExactType<Flex>();
    assert(flex != null, 'Box must be used inside a Row or Column');

    final isHorizontal = flex?.direction == Axis.horizontal;

    return SizedBox(
      width: isHorizontal ? size : 0,
      height: isHorizontal ? 0 : size,
    );
  }
}
