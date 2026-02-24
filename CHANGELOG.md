# Changelog

All notable changes to this package will be documented here.

## [0.3.3] - 2026-02-24

### Added

- `showBackButton` property to `KitDialog.dialog`.
- `showBackButton` property to `KitNavigator.showBottomSheet`.
- `action` property to `KitSnackbar`.

## [0.3.2] - 2026-02-21

## [0.3.1] - 2026-02-20

### Added

- `maxHeight` and `maxWidth` properties to `KitDialog.dialog`.

## [0.3.0] - 2026-01-06

### Changed

- **BREAKING**: Renamed all "App" prefix components to "Kit" prefix for better package branding:
  - `AppScaffold` → `KitScaffold`
  - `AppColumn` → `KitColumn`
  - `AppDialog` → `KitDialog`
  - `AppSnackbar` → `KitSnackbar`
  - `AppNavigator` → `KitNavigator`
  - `AppSelector` → `KitSelector`
  - `AppMultiSelector` → `KitMultiSelector`
  - `AppRadio` → `KitRadio`
  - `AppColors` → `KitColors`
  - `AppLogger` → `KitLogger`
  - `AppOutlinedButton` → `KitOutlinedButton`
- Updated all documentation and examples to reflect the new naming convention

## [0.2.1] - 2026-01-01

### Documentation

- Updated README

## [0.2.0] - 2026-01-01

### Added

- New `Pad` widget with constructors: default, `vertical()`, `horizontal()`, `l()`, `r()`, `t()`, `b()`
- Comprehensive documentation with examples for `Pad`, `SwitchView`, `Blur`, `When`, and `ExpandIf` widgets

## [0.1.0] - 2025-12-20

- Initial public release with Material 3 themes, buttons, text fields, dialogs, snackbars, animations, navigation helpers, validators, and loggers.
