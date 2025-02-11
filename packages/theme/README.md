# Theme

This package contains components used for implementing a consistent theme

## Features

- Design tokens
- Fonts

## Usage

To use components from this package in another package in the workspace add a dependency to `faq` in the pubspec.yaml:
```yaml
dependencies:
  theme: ^0.0.0
```
And then have Melos bootstrap the reference for you:
```bash
melos bootstrap
```

## Generating design tokens
Export the tokens from Figma in [W3C standards](https://design-tokens.github.io/community-group/format/) format using `tool name here` and replace the contents of [tokens.json](./design/tokens.json). Make sure you have [figma2flutter](https://github.com/mark-nicepants/figma2flutter) installed:
```bash
dart pub global activate figma2flutter
```
Generate the dart design tokens:
```bash
figma2flutter
```
### Add the package for the text style tokens
The font is included in the theme package so the generated text styles need to include a reference to the package in order to work. Find and replace
```dart
letterSpacing: 0.0,
```
with
```dart
letterSpacing: 0.0,
  package: "theme",
```
Lastly format the generated code