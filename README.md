# flutter_toolkit

Material 3 ready UI toolkit that bundles themed widgets, form inputs, navigation helpers, validators, and logging utilities to speed up Flutter app development.

## Features

- Pre-built buttons, text fields, scaffold, dialogs, snackbars, and animations
- Material 3 light/dark themes with curated color palette
- Navigation helpers and route builders
- Validators, loggers, and scroll behavior utilities
- Extension methods for common data types

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
	flutter_toolkit: ^0.1.0
```

Run `flutter pub get` and import it where needed:

```dart
import 'package:flutter_toolkit/flutter_toolkit.dart';
```

## Quick start

```dart
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
			title: 'Toolkit Demo',
			theme: BlueTheme.light,
			darkTheme: BlueTheme.dark,
			builder: (context, child) => ScrollConfiguration(
				behavior: NoThumbScrollBehavior(),
				child: child!,
			),
			home: const DemoScreen(),
		);
	}
}

class DemoScreen extends StatelessWidget {
	const DemoScreen({super.key});

	@override
	Widget build(BuildContext context) {
		final controller = TextEditingController();

		return AppScaffold(
			appBar: AppBar(title: const Text('Toolkit')),
			isLoading: false,
			body: Padding(
				padding: const EdgeInsets.all(16),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						const StyledText('Welcome', fontWeight: FontWeight.w700, fontSize: 18),
						const YGap(12),
						OutlinedTextField(
							controller: controller,
							labelText: 'Email',
							hintText: 'you@example.com',
							validator: Validators.email,
							showTopLabel: true,
						),
						const YGap(16),
						PrimaryButton(
							title: 'Submit',
							icon: Icons.check,
							expanded: true,
							onTap: () => AppSnackbar.show(
								context,
								message: 'Submitted',
							),
						),
					],
				),
			),
		);
	}
}
```

## Included

- Widgets: `PrimaryButton`, `OutlinedTextField`, `AppScaffold`, `AppSnackbar`, `AppDialog`, `TapBounce`, shimmer loader
- Navigation: `AppNavigator`, `buildRoute` helpers
- Themes: `BlueTheme.light` / `BlueTheme.dark`, `AppColors`
- Utilities: `Validators`, `logDebug`/`logError`, `AppScrollBehavior`
- Extensions: `StringExt`, `NumExt`, `ContextExt` and more

## Contributing

Issues and pull requests are welcome. Please add tests or examples when contributing new components.

## License

This project is licensed under the terms of the MIT license. See [LICENSE](LICENSE).
