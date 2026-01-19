# Contributing to SynapseOS

Welcome! We're excited that you want to contribute to SynapseOS.

## Development Setup

### Backend (Scala)
1. Install JDK 17 and sbt.
2. Run `sbt compile` to build.
3. Use `sbt test` for unit tests.

### Frontend (Flutter)
1. Install Flutter 3.13.0+.
2. Run `flutter pub get`.
3. Use `flutter test` for testing.

## Standards
- **Scala**: Follow the [Scala Style Guide](https://docs.scala-lang.org/style/). We use `scalafmt` for formatting.
- **Flutter**: Use Clean Architecture and the BLoC pattern. Ensure all widgets are documented.
- **Git**: Use descriptive commit messages and branch from `develop`.

## Pull Request Process
1. Create a feature branch.
2. Implement your changes and add tests.
3. Ensure the CI pipeline passes.
4. Submit a PR for review.
