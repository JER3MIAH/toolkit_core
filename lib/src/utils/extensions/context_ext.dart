import 'package:flutter/material.dart';
import 'package:flutter_toolkit/flutter_toolkit.dart';

extension ContextExtensions on BuildContext {
  // Device type checks
  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1200;
  bool get isPad => screenWidth >= 900 && screenWidth < 1200;
  bool get isDesktop => screenWidth >= 1200;

  // MediaQuery shortcuts
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  // Padding shortcuts
  EdgeInsets get paddingAllSmall => const EdgeInsets.all(8);
  EdgeInsets get paddingAllMedium => const EdgeInsets.all(16);
  EdgeInsets get paddingAllLarge => const EdgeInsets.all(24);

  // Theme shortcuts
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;

  // Navigation shortcuts
  AppNavigator get navigator => AppNavigator(this);

  void push(Widget page) {
    Navigator.of(this).push(MaterialPageRoute(builder: (_) => page));
  }

  void pop([dynamic result]) {
    Navigator.of(this).pop(result);
  }

  void pushReplacement(Widget page) {
    Navigator.of(this).pushReplacement(MaterialPageRoute(builder: (_) => page));
  }

  void pushNamed(String routeName, {Object? arguments}) {
    navigator.pushNamed(routeName, args: arguments);
  }

  void replaceNamed(String routeName, {Object? arguments}) {
    navigator.replaceNamed(routeName, args: arguments);
  }

  void replaceAllNamed(String routeName, {Object? arguments}) {
    navigator.replaceAllNamed(routeName, args: arguments);
  }

  void popRoute() {
    navigator.popRoute();
  }

  void popUntilFirst() {
    navigator.popUntilFirst();
  }

  void popUntilRoute(String routeName) {
    navigator.popUntilRoute(routeName);
  }

  Future<T?> showDialog<T>(
    Widget content, {
    Color? bgColor,
    bool dismissible = true,
  }) {
    return AppDialog.dialog(
      this,
      content,
      bgColor: bgColor,
      dismissible: dismissible,
    );
  }

  Future<T?> showBottomSheet<T>(
    Widget content, {
    bool isScrollControlled = true,
    bool useRootNavigator = true,
    Color? backgroundColor,
    double? maxHeight,
  }) {
    return AppNavigator(this).showBottomSheet<T>(
      child: content,
      backgroundColor: backgroundColor,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      maxHeight: maxHeight,
    );
  }

  void showErrorSnackBar(String message) {
    AppSnackbar.show(this, title: message, isWarning: true);
  }

  void showSuccessSnackBar(String message) {
    AppSnackbar.show(this, title: message, isWarning: false);
  }

  // Keyboard shortcut
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }
}
