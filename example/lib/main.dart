import 'package:flutter/material.dart';
import 'package:flutter_toolkit/flutter_toolkit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Toolkit Demo',
      theme: BlueTheme.light,
      darkTheme: BlueTheme.dark,
      themeMode: ThemeMode.system,
      builder: (context, child) =>
          ScrollConfiguration(behavior: NoThumbScrollBehavior(), child: child!),
      home: const DemoScreen(),
    );
  }
}

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    // Simulate loading
    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isLoading = false);

        AppSnackbar.show(context, title: 'Form submitted successfully!');

        AppLogger.debug(
          'Form submitted with name: ${_nameController.text}, email: ${_emailController.text}',
        );
      }
    });
  }

  void _showDialog() {
    AppDialog.dialog(
      context,
      Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StyledText(
              'Confirm Action',
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            const YGap(12),
            const StyledText('Are you sure you want to proceed?', fontSize: 14),
            const YGap(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PrimaryButton(
                  title: 'Cancel',
                  color: AppColors.neutral300,
                  textColor: AppColors.black,
                  onTap: () => Navigator.pop(context),
                ),
                const XGap(12),
                PrimaryButton(
                  title: 'Confirm',
                  icon: Icons.check,
                  onTap: () {
                    Navigator.pop(context);
                    AppSnackbar.show(context, title: 'Action confirmed');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text('Flutter Toolkit Demo'),
        centerTitle: true,
      ),
      isLoading: _isLoading,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StyledText(
              'Welcome to Flutter Toolkit',
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
            const YGap(8),
            StyledText(
              'A Material 3 UI toolkit with themed widgets and utilities',
              fontSize: 14,
              color: AppColors.neutral600,
            ),
            const YGap(32),

            // Form Section
            const StyledText(
              'Form Components',
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            const YGap(16),

            OutlinedTextField(
              controller: _nameController,
              labelText: 'Full Name',
              hintText: 'Enter your name',
              validator: Validators.validateRequired,
              showTopLabel: true,
            ),
            const YGap(16),

            OutlinedTextField(
              controller: _emailController,
              labelText: 'Email Address',
              hintText: 'you@example.com',
              keyboardType: TextInputType.emailAddress,
              validator: Validators.validateEmail,
              showTopLabel: true,
              prefixIcon: const Icon(Icons.email_outlined, size: 20),
            ),
            const YGap(24),

            // Button Section
            const StyledText(
              'Buttons',
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            const YGap(16),

            PrimaryButton(
              title: 'Submit Form',
              icon: Icons.send,
              expanded: true,
              onTap: _handleSubmit,
            ),
            const YGap(12),

            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    title: 'Show Dialog',
                    color: AppColors.blue700,
                    onTap: _showDialog,
                  ),
                ),
                const XGap(12),
                Expanded(
                  child: PrimaryButton(
                    title: 'Error',
                    color: AppColors.red500,
                    icon: Icons.error_outline,
                    onTap: () => AppSnackbar.show(
                      context,
                      title: 'This is an error message',
                      isWarning: true,
                    ),
                  ),
                ),
              ],
            ),
            const YGap(24),

            // Animation Section
            const StyledText(
              'Animations',
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            const YGap(16),

            TapBounce(
              onTap: () => AppSnackbar.show(context, title: 'Bounced!'),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.blue50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.blue500),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.touch_app, color: AppColors.blue500),
                    XGap(12),
                    StyledText(
                      'Tap me for bounce animation',
                      color: AppColors.blue700,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),
            const YGap(32),

            // Theme Colors
            const StyledText(
              'Theme Colors',
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            const YGap(16),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _ColorBox(color: AppColors.blue500, label: 'Primary'),
                _ColorBox(color: AppColors.red500, label: 'Error'),
                _ColorBox(color: AppColors.green500, label: 'Success'),
                _ColorBox(color: AppColors.neutral700, label: 'Neutral'),
              ],
            ),
            const YGap(40),
          ],
        ),
      ),
    );
  }
}

class _ColorBox extends StatelessWidget {
  final Color color;
  final String label;

  const _ColorBox({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        const YGap(8),
        StyledText(label, fontSize: 12, color: AppColors.neutral600),
      ],
    );
  }
}
