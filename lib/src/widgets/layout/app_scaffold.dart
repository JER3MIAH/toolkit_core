import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.backgroundColor,
    this.isLoading = false,
    this.appBar,
    this.floatingActionButton,
    this.isUnavailableFeatureScreen = false,
    this.bottomsheet,
    this.bottomAppBar,
  });

  final Widget body;
  final Color? backgroundColor;
  final bool isLoading;
  final PreferredSizeWidget? appBar;
  final Widget? bottomsheet;
  final Widget? floatingActionButton, bottomAppBar;
  final bool isUnavailableFeatureScreen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        floatingActionButton: floatingActionButton,
        bottomSheet: bottomsheet,
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: bottomAppBar,
        appBar: appBar,
        body: Stack(
          fit: StackFit.expand,
          children: [
            body,
            if (isLoading)
              Container(
                color: Colors.black.withValues(alpha: .2),
                child: const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              )
            else
              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

