import 'package:flutter/material.dart';

/// Utility class for displaying styled dialogs.
///
/// Provides static methods to show Material 3 compliant dialogs with
/// consistent styling and optional customization.
///
/// Example:
/// ```dart
/// await KitDialog.dialog(
///   context,
///   MyDialogContent(),
///   dismissible: true,
/// );
/// ```
class KitDialog {
  KitDialog._(); // Private constructor to prevent instantiation

  /// Show a styled dialog with custom content.
  ///
  /// Parameters:
  ///   - [context]: The build context
  ///   - [content]: The widget to display in the dialog
  ///   - [bgColor]: Optional background color (uses theme default if null)
  ///   - [dismissible]: Whether tapping outside closes the dialog (default: true)
  ///
  /// Returns: A future that resolves with the dialog result when closed
  static Future<T?> dialog<T>(
    BuildContext context,
    Widget content, {
    Color? bgColor,
    bool dismissible = true,
    double maxWidth = 540,
    double? maxHeight,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return showDialog<T>(
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: colorScheme.inversePrimary),
                borderRadius: BorderRadius.circular(12),
              ),
              insetPadding: const EdgeInsets.symmetric(horizontal: 16),
              backgroundColor: bgColor ?? colorScheme.surfaceContainerHigh,
              shadowColor: bgColor ?? colorScheme.surfaceContainerHigh,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxWidth,
                  maxHeight: maxHeight ?? double.infinity,
                ),
                child: content,
              ),
            );
          },
        );
      },
    );
  }
}
