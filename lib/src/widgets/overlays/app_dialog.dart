import 'package:flutter/material.dart';

/// Utility class for displaying styled dialogs.
///
/// Provides static methods to show Material 3 compliant dialogs with
/// consistent styling and optional customization.
///
/// Example:
/// ```dart
/// await AppDialog.dialog(
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
  ///   - [maxWidth]: Maximum width of the dialog (default: 540)
  ///   - [maxHeight]: Optional maximum height of the dialog (default: no limit)
  ///   - [showBackButton]: Whether to show a back button in the top right corner (default: false)
  ///   - [backButton]: Optional custom back button widget (overrides default if provided)
  /// Returns: A future that resolves with the dialog result when closed
  static Future<T?> dialog<T>(
    BuildContext context,
    Widget content, {
    Color? bgColor,
    bool dismissible = true,
    double maxWidth = 540,
    double? maxHeight,
    bool showBackButton = false,
    Widget? backButton,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return showDialog<T>(
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: colorScheme.inversePrimary),
            borderRadius: BorderRadius.circular(12),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          backgroundColor: bgColor ?? colorScheme.surfaceContainerHigh,
          shadowColor: Colors.transparent,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth,
              maxHeight: maxHeight ?? double.infinity,
            ),
            child: Stack(
              children: [
                // Main Content
                content,

                // Top Right Back Button
                if (backButton != null)
                  Positioned(top: 8, right: 8, child: backButton),
                if (showBackButton && backButton == null)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Card(
                      elevation: 2,
                      child: IconButton(
                        icon: Icon(Icons.close, color: colorScheme.onSurface),
                        visualDensity: VisualDensity.compact,
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        style: IconButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
