import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/widgets/information_component.dart';

class LoginInformation extends StatelessWidget {
  final Function(BuildContext context) onBackClicked;
  final String? content;

  const LoginInformation({
    super.key,
    required this.onBackClicked,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return InformationComponent(
      header: AppLocalizations.of(context)!.loginInformationHeader,
      content: content,
      onBackClicked: onBackClicked,
    );
  }
}
