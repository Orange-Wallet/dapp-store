# DappStore

## Requirements

### • Flutter SDK

<br>

```
flutter --version
```

```
Flutter 3.3.9 • channel stable • https://github.com/flutter/flutter.git
Framework • revision b8f7f1f986 (4 months ago) • 2022-11-23 06:43:51 +0900
Engine • revision 8f2221fbef
Tools • Dart 2.18.5 • DevTools 2.15.0
```

## Structure Overview

### Core

- **/core** - Core utilities like network, storage, di, error, localization, router, etc. being used app-wide.
- **/core/application** - Base App and necessary dependencies.
- **/core/application/init** - Initialise utilities that need to started before runApp() .
- **/core/connectivity** - Check for network availability.
- **/core/error** - Check for network availability. Ex - throw SomeException();
  - Exceptions - Classes used for throwing exceptions on root layer.
  - Failures - Classes used for returning failures or errors on repository level. Ex - Either<SomeFailure, Unit> someFunc() {}
- **/core/network** - Network requests client wrapper.
- **/core/router** - Router wrapper and routes declaration.
- **/core/store** - Storage wrapper for secure storage impl or DB storage impl.
- **/core/util** - Necessary helper classes.

### Features

- **/features** - Feature implementations.
- **/features/feature_name** - Feature specific implementations.
- **/features/feature_name/application** - Controller or state-mangement utilities.
- **/features/feature_name/domain** - Data Models and base repository implementations.
- **/features/feature_name/domain/entities** - Feature specific data models.
- **/features/feature_name/domain/repositories** - Repository interfaces.
- **/features/feature_name/infrastructure** - All functionality related to fetching, storing, caching, retrieving local or remote data and necessary json classes.
- **/features/feature_name/infrastructure/datasources**
  - Local Data source
  - Remote Data source
- **/features/feature_name/infrastructure/dtos** - Data Transfer Objects that hold Json data models and functions to convert to domain entities.
- **/features/feature_name/infrastructure/respositories** - Unifying all datasources at repository layer to be accessed by any controller or state-management.
- **/features/feature_name/presentation** - Everything UI related.
  - Pages
  - Widgets
- **/features/feature_name/presentation/pages/listeners** - Any listner wrappers. Ex - BlocListeners
- **/features/feature_name/presentation/pages/providers** - Any provider wrappers. Ex - BlocProviders

### Localization

This project generates localized messages based on arb files found in
the `lib/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter
apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)

### Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware
images](https://flutter.dev/docs/development/ui/assets-and-images#resolution-aware).
