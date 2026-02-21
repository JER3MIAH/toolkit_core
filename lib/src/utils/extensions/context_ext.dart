import 'package:flutter/material.dart';
import 'package:toolkit_core/toolkit_core.dart';

/// Extension methods on [BuildContext] for convenient UI and navigation utilities.
///
/// Provides shortcuts for:
/// - Device type detection (mobile, tablet, desktop)
/// - MediaQuery shortcuts (screen size, padding)
/// - Theme shortcuts (colors, text styles)
/// - Navigation shortcuts (push, pop, navigation management)
/// - Dialog and snackbar display
///
/// Example:
/// ```dart
/// if (context.isMobile) {
///   // Mobile-specific UI
/// }
/// context.navigator.pushNamed('/home');
/// context.showSuccessSnackBar('Operation completed!');
/// ```
extension ContextExtensions on BuildContext {
  // ============ Device Type Checks ============

  /// Returns true if the device is in mobile size range (< 600dp width).
  bool get isMobile => screenWidth < 600;

  /// Returns true if the device is in tablet size range (600dp - 1200dp width).
  bool get isTablet => screenWidth >= 600 && screenWidth < 1200;

  /// Returns true if the device is in iPad size range (900dp - 1200dp width).
  bool get isPad => screenWidth >= 900 && screenWidth < 1200;

  /// Returns true if the device is in desktop size range (>= 1200dp width).
  bool get isDesktop => screenWidth >= 1200;

  // ============ MediaQuery Shortcuts ============

  /// Get the screen size as a [Size] object.
  Size get screenSize => MediaQuery.of(this).size;

  /// Get the screen width in device-independent pixels (dp).
  double get screenWidth => screenSize.width;

  /// Get the screen height in device-independent pixels (dp).
  double get screenHeight => screenSize.height;

  // ============ Padding Shortcuts ============

  /// Small padding of 8dp on all sides.
  EdgeInsets get paddingAllSmall => const EdgeInsets.all(8);

  /// Medium padding of 16dp on all sides.
  EdgeInsets get paddingAllMedium => const EdgeInsets.all(16);

  /// Large padding of 24dp on all sides.
  EdgeInsets get paddingAllLarge => const EdgeInsets.all(24);

  // ============ Theme Shortcuts ============

  /// Get the current [ThemeData].
  ThemeData get theme => Theme.of(this);

  /// Get the current [ColorScheme] from the theme.
  ColorScheme get colors => theme.colorScheme;

  /// Get the current [TextTheme] from the theme.
  TextTheme get textTheme => theme.textTheme;

  // ============ Navigation Shortcuts ============

  /// Get a [KitNavigator] instance for this context.
  KitNavigator get navigator => KitNavigator(this);

  /// Push a new page onto the navigation stack.
  ///
  /// Parameters:
  ///   - [page]: The widget to display as the new page
  void push(Widget page) {
    Navigator.of(this).push(MaterialPageRoute(builder: (_) => page));
  }

  /// Pop the current page from the navigation stack.
  ///
  /// Parameters:
  ///   - [result]: Optional value to return to the previous page
  void pop([dynamic result]) {
    Navigator.of(this).pop(result);
  }

  /// Replace the current page with a new page.
  ///
  /// Parameters:
  ///   - [page]: The widget to display as the new page
  void pushReplacement(Widget page) {
    Navigator.of(this).pushReplacement(MaterialPageRoute(builder: (_) => page));
  }

  /// Push a named route onto the navigation stack.
  ///
  /// Parameters:
  ///   - [routeName]: The name of the route
  ///   - [arguments]: Optional arguments to pass to the route
  void pushNamed(String routeName, {Object? arguments}) {
    navigator.pushNamed(routeName, args: arguments);
  }

  /// Replace the current route with a named route.
  ///
  /// Parameters:
  ///   - [routeName]: The name of the route
  ///   - [arguments]: Optional arguments to pass to the route
  void replaceNamed(String routeName, {Object? arguments}) {
    navigator.replaceNamed(routeName, args: arguments);
  }

  /// Replace all routes in the stack with a named route.
  ///
  /// Parameters:
  ///   - [routeName]: The name of the route
  ///   - [arguments]: Optional arguments to pass to the route
  void replaceAllNamed(String routeName, {Object? arguments}) {
    navigator.replaceAllNamed(routeName, args: arguments);
  }

  /// Pop the current route from the navigation stack.
  void popRoute() {
    navigator.popRoute();
  }

  /// Pop all routes until reaching the root route.
  void popUntilFirst() {
    navigator.popUntilFirst();
  }

  /// Pop routes until reaching a specific named route.
  ///
  /// Parameters:
  ///   - [routeName]: The name of the route to pop until
  void popUntilRoute(String routeName) {
    navigator.popUntilRoute(routeName);
  }

  // ============ Dialog and Overlay Shortcuts ============

  /// Show a dialog with custom content.
  ///
  /// Parameters:
  ///   - [content]: The widget to display in the dialog
  ///   - [bgColor]: Optional background color for the dialog
  ///   - [dismissible]: Whether tapping outside closes the dialog (default: true)
  ///
  /// Returns: A future that resolves when the dialog is dismissed
  Future<T?> showDialog<T>(
    Widget content, {
    Color? bgColor,
    bool dismissible = true,
    double maxWidth = 540,
    double? maxHeight,
  }) {
    return KitDialog.dialog(
      this,
      content,
      bgColor: bgColor,
      dismissible: dismissible,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
    );
  }

  /// Show a modal bottom sheet.
  ///
  /// Parameters:
  ///   - [content]: The widget to display in the sheet
  ///   - [isScrollControlled]: Whether the sheet can be full height
  ///   - [useRootNavigator]: Whether to use the root navigator
  ///   - [backgroundColor]: The background color
  ///   - [maxHeight]: The maximum height of the sheet
  ///
  /// Returns: A future that resolves when the sheet is dismissed
  Future<T?> showBottomSheet<T>(
    Widget content, {
    bool isScrollControlled = true,
    bool useRootNavigator = true,
    Color? backgroundColor,
    double? maxHeight,
  }) {
    return KitNavigator(this).showBottomSheet<T>(
      child: content,
      backgroundColor: backgroundColor,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      maxHeight: maxHeight,
    );
  }

  /// Show an error snackbar with a warning icon.
  ///
  /// Parameters:
  ///   - [message]: The error message to display
  void showErrorSnackBar(String message) {
    KitSnackbar.show(this, title: message, isWarning: true);
  }

  /// Show a success snackbar with a checkmark icon.
  ///
  /// Parameters:
  ///   - [message]: The success message to display
  void showSuccessSnackBar(String message) {
    KitSnackbar.show(this, title: message, isWarning: false);
  }

  // Keyboard shortcut
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }
}
