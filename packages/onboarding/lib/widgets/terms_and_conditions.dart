import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/widgets/information_component.dart';

class TermsAndConditions extends StatelessWidget {
  final Function(BuildContext context) onBackClicked;
  final String? content;

  const TermsAndConditions({
    super.key,
    required this.content,
    required this.onBackClicked,
  });

  @override
  Widget build(BuildContext context) {
    return InformationComponent(
      header: AppLocalizations.of(context)!.termsAndConditionsHeader,
      content: content,
      onBackClicked: onBackClicked,
    );
  }
}
