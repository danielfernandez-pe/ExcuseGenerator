fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios lint

```sh
[bundle exec] fastlane ios lint
```

Swiftlint script for syntax control

### ios unit_tests

```sh
[bundle exec] fastlane ios unit_tests
```

Runs all unit tests

### ios remove_signing_assets

```sh
[bundle exec] fastlane ios remove_signing_assets
```

Remove certificates and provisioning profiles for every app environment.

### ios create_signing_assets

```sh
[bundle exec] fastlane ios create_signing_assets
```

Create certificates and provisioning profiles for every app environment. This should be run once at the beginning of the project

### ios get_signing_assets

```sh
[bundle exec] fastlane ios get_signing_assets
```

Get certificates and provisioning profiles for every app environment. This would get only what is on the repository

### ios deploy_appstore

```sh
[bundle exec] fastlane ios deploy_appstore
```

Submit a new build to AppStore

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
