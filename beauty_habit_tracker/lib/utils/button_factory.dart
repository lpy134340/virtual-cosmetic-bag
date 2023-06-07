// ignore_for_file: file_names

import 'package:flutter/material.dart';

enum _StyleEnum { primary, outlined, text }

class ProjectButton extends StatelessWidget {
  const ProjectButton._({
    Key? key,
    this.icon,
    required this.label,
    required this.style,
    required this.onPressed,
    required _StyleEnum styleEnum,
    required this.padding,
  })  : _styleEnum = styleEnum,
        super(key: key);

  /// Primary button
  factory ProjectButton.primary({
    IconData? icon,
    required String label,
    required ButtonStyle style,
    required Function()? onPressed,
    EdgeInsets? padding,
    required String semanticsLabel,
  }) {
    return ProjectButton._(
      label: label,
      style: style,
      onPressed: onPressed,
      icon: icon,
      styleEnum: _StyleEnum.primary,
      padding: padding,
    );
  }

  /// Outlined button
  factory ProjectButton.outlined({
    IconData? icon,
    required String label,
    required ButtonStyle style,
    required Function()? onPressed,
    EdgeInsets? padding,
  }) {
    return ProjectButton._(
      label: label,
      style: style,
      onPressed: onPressed,
      icon: icon,
      styleEnum: _StyleEnum.outlined,
      padding: padding,
    );
  }

  /// Text button
  factory ProjectButton.text({
    IconData? icon,
    required String label,
    required ButtonStyle style,
    required Function()? onPressed,
    EdgeInsets? padding,
  }) {
    return ProjectButton._(
      label: label,
      style: style,
      onPressed: onPressed,
      icon: icon,
      styleEnum: _StyleEnum.text,
      padding: padding,
    );
  }

  /// Icon of the button
  final IconData? icon;

  /// Label of the button
  final String label;

  /// Style of the button
  final ButtonStyle style;

  /// Padding of the inside of the button
  final EdgeInsets? padding;

  /// Action of the button, if null, will go to disabled state
  final Function()? onPressed;

  final _StyleEnum _styleEnum;

  @override
  Widget build(BuildContext context) {
    switch (_styleEnum) {
      case _StyleEnum.primary:
        if (icon != null) {
          return ElevatedButton.icon(
            style: style,
            onPressed: onPressed,
            icon: Icon(icon),
            label: Text(label),
          );
        }
        return ElevatedButton(
          style: style,
          onPressed: onPressed,
          child: Text(label),
        );

      case _StyleEnum.outlined:
        final style = OutlinedButton.styleFrom(
          elevation: 0,
          padding: padding,
        );
        if (icon != null) {
          return OutlinedButton.icon(
            style: style,
            onPressed: onPressed,
            icon: Icon(icon),
            label: Text(label),
          );
        }
        return OutlinedButton(
          style: style,
          onPressed: onPressed,
          child: Text(label),
        );

      case _StyleEnum.text:
        final style = TextButton.styleFrom(
          elevation: 0,
          padding: padding,
        );
        if (icon != null) {
          return TextButton.icon(
            style: style,
            onPressed: onPressed,
            icon: Icon(icon),
            label: Text(label),
          );
        }
        return TextButton(
          style: style,
          onPressed: onPressed,
          child: Text(label),
        );
    }
  }
}
