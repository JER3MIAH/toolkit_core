import 'package:flutter/material.dart';
import 'package:toolkit_core/src/themes/themes.dart';
import 'package:toolkit_core/src/utils/extensions/context_ext.dart';
import 'package:toolkit_core/src/widgets/layout/gap.dart';

/// Utility class for displaying styled snackbars.
///
/// Provides static methods to show toast-like notifications with
/// status icons and consistent styling.
///
/// Example:
/// ```dart
/// KitSnackbar.show(
///   context,
///   title: 'Operation completed successfully!',
/// );
///
/// KitSnackbar.show(
///   context,
///   title: 'An error occurred',
///   isWarning: true,
/// );
/// ```
class KitSnackbar {
  KitSnackbar._(); // Private constructor to prevent instantiation

  /// Show a snackbar notification with optional warning styling.
  ///
  /// Displays a snackbar at the bottom of the screen with an icon and message.
  /// Only one snackbar is shown at a time (replaces previous if any).
  ///
  /// Parameters:
  ///   - [context]: The build context
  ///   - [title]: The message text to display
  ///   - [duration]: How long to display the snackbar (default: 4 seconds)
  ///   - [isWarning]: If true, shows error icon and color; success otherwise
  static void show(
    BuildContext context, {
    required String title,
    Duration duration = const Duration(seconds: 4),
    bool isWarning = false,
    SnackBarAction? action,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    final snackBar = SnackBar(
      width: context.isMobile ? null : 440,
      backgroundColor: colorScheme.surfaceContainerHigh,
      behavior: SnackBarBehavior.floating,
      padding: EdgeInsets.all(8),
      margin: context.isMobile ? EdgeInsets.symmetric(horizontal: 10) : null,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isWarning ? KitColors.red500 : colorScheme.inversePrimary,
        ),
      ),
      action: action,
      content: Row(
        children: [
          Icon(
            isWarning ? Icons.info : Icons.check_circle,
            color: isWarning ? KitColors.red500 : KitColors.green500,
          ),
          XGap(12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          InkWell(
            onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            child: Icon(
              Icons.clear,
              color: isWarning
                  ? KitColors.red500
                  : colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      duration: duration,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar() // Ensures only one snack bar is shown at a time
      ..showSnackBar(snackBar);
  }
}
