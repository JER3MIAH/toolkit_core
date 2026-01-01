import 'package:flutter/material.dart';

/// Custom scroll behavior that removes the default scroll indicators.
///
/// This scroll behavior prevents the display of the default platform-specific
/// scroll indicators (thumb/scrollbar) and overscroll effects. Use this when you
/// want a cleaner scroll experience without visual indicators.
///
/// Example:
/// ```dart
/// ScrollConfiguration(
///   behavior: NoThumbScrollBehavior(),
///   child: ListView(...),
/// )
/// ```
class NoThumbScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
