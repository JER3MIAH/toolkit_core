import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppNavigator {
  final BuildContext context;

  AppNavigator(this.context);

  /// Use to push to a new route
  void pushNamed(String name, {Object? args}) {
    Navigator.of(context).pushNamed(name, arguments: args);
  }

  /// Use to replace the current route with a new route
  void replaceNamed(String name, {Object? args}) {
    Navigator.of(context).pushReplacementNamed(name, arguments: args);
  }

  /// Use to replace all routes with a new route
  void replaceAllNamed(String name, {Object? args}) {
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(name, (route) => false, arguments: args);
  }

  /// Use to pop the current route
  void popRoute() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  /// Use to pop until the first route
  void popUntilFirst() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).popUntil((route) => false);
    }
  }

  /// Use to pop until a specific route name
  void popUntilRoute(String routeName) {
    Navigator.of(context).popUntil(ModalRoute.withName(routeName));
  }

  /// Use to pop dialog if shown
  void popDialog() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  //* Use to show modal bottom sheet
  Future<T?> showBottomSheet<T>({
    required Widget child,
    bool isScrollControlled = true,
    bool useRootNavigator = true,
    Color? backgroundColor,
    double? maxHeight,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final sheetHeight =
            maxHeight ?? MediaQuery.of(context).size.height * 0.9;

        return AnimatedPadding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: Container(
            constraints: BoxConstraints(maxHeight: sheetHeight),
            decoration: BoxDecoration(
              color: backgroundColor ?? Theme.of(context).colorScheme.surface,
            ),
            child: SingleChildScrollView(
              child: Padding(padding: const EdgeInsets.all(16.0), child: child),
            ),
          ),
        );
      },
    );
  }

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
