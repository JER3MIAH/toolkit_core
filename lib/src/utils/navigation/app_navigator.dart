import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Navigation utility for managing page and dialog navigation.
///
/// Provides simplified methods for common navigation patterns including
/// pushing routes, replacing routes, popping, showing dialogs, and bottom sheets.
/// All methods are context-aware and use the Navigator API internally.
///
/// Example:
/// ```dart
/// final navigator = KitNavigator(context);
/// navigator.pushNamed('/home');
/// navigator.popRoute();
/// ```
class KitNavigator {
  /// The build context used for navigation operations.
  final BuildContext context;

  /// Creates a KitNavigator with the given build context.
  KitNavigator(this.context);

  /// Push a named route onto the navigation stack.
  ///
  /// Parameters:
  ///   - [name]: The route name to navigate to
  ///   - [args]: Optional arguments to pass to the route
  void pushNamed(String name, {Object? args}) {
    Navigator.of(context).pushNamed(name, arguments: args);
  }

  /// Replace the current route with a new named route.
  ///
  /// Parameters:
  ///   - [name]: The route name to navigate to
  ///   - [args]: Optional arguments to pass to the route
  void replaceNamed(String name, {Object? args}) {
    Navigator.of(context).pushReplacementNamed(name, arguments: args);
  }

  /// Replace all routes in the navigation stack with a new named route.
  ///
  /// Removes all existing routes from the stack before pushing the new route.
  ///
  /// Parameters:
  ///   - [name]: The route name to navigate to
  ///   - [args]: Optional arguments to pass to the route
  void replaceAllNamed(String name, {Object? args}) {
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(name, (route) => false, arguments: args);
  }

  /// Pop the current route from the navigation stack.
  ///
  /// Does nothing if there's only one route in the stack.
  void popRoute() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  /// Pop all routes until reaching the first (root) route.
  ///
  /// Only works if there are routes to pop.
  void popUntilFirst() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).popUntil((route) => false);
    }
  }

  /// Pop routes until reaching a specific named route.
  ///
  /// Parameters:
  ///   - [routeName]: The name of the route to pop until
  void popUntilRoute(String routeName) {
    Navigator.of(context).popUntil(ModalRoute.withName(routeName));
  }

  /// Pop a dialog if one is currently shown.
  ///
  /// Does nothing if no dialog is open.
  void popDialog() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  /// Show a modal bottom sheet with the given child widget.
  ///
  /// The sheet animates in from the bottom with customizable height,
  /// background color, and scroll behavior.
  ///
  /// Parameters:
  ///   - [child]: The widget to display in the bottom sheet
  ///   - [isScrollControlled]: If true, the sheet can extend full height (default: true)
  ///   - [useRootNavigator]: If true, uses the root navigator (default: true)
  ///   - [backgroundColor]: The background color of the sheet
  ///   - [maxHeight]: The maximum height of the sheet (default: 90% of screen height)
  ///   - [showBackButton]: Whether to show a back button in the top right corner (default: false)
  ///   - [backButton]: Optional custom back button widget (overrides default if provided)
  ///
  /// Returns: A future that resolves when the sheet is dismissed
  Future<T?> showBottomSheet<T>({
    required Widget child,
    bool isScrollControlled = true,
    bool useRootNavigator = true,
    Color? backgroundColor,
    double? maxHeight,
    bool showBackButton = false,
    Widget? backButton,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        final colorScheme = Theme.of(context).colorScheme;
        final sheetHeight =
            maxHeight ?? MediaQuery.of(context).size.height * 0.8;

        return AnimatedPadding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: Container(
            constraints: BoxConstraints(maxHeight: sheetHeight),
            decoration: BoxDecoration(
              color: backgroundColor ?? colorScheme.surface,
            ),
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  // Main Content
                  Padding(padding: const EdgeInsets.all(16.0), child: child),

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
                          onPressed: () => Navigator.of(sheetContext).pop(),
                          style: IconButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Exit the application.
  ///
  /// On Android, uses the system navigator exit. On other platforms,
  /// exits the application process directly.
  ///
  /// Parameters:
  ///   - [animated]: Whether to animate the exit on Android (default: true)
  Future<void> exitApp({bool animated = true}) async {
    if (Theme.of(context).platform == TargetPlatform.windows ||
        Theme.of(context).platform == TargetPlatform.linux ||
        Theme.of(context).platform == TargetPlatform.macOS) {
      exit(0);
    } else {
      await SystemChannels.platform.invokeMethod<void>(
        'SystemNavigator.pop',
        animated,
      );
    }
  }
}
