import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/view_models/validate_information_view_model.dart';
import 'package:theme/assets/icons/custom_icons.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

class ValidateInformation extends StatefulWidget {
  final ValidateInformationViewModel viewModel;

  const ValidateInformation({
    super.key,
    required this.viewModel,
  });

  @override
  State<StatefulWidget> createState() {
    return ValidateInformationState();
  }
}

class ValidateInformationState extends State<ValidateInformation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 24, bottom: 16, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: NotificationBanner.positive(
              title:
                  AppLocalizations.of(context)!.validateInformationSuccessTitle,
              content: AppLocalizations.of(context)!
                  .validateInformationSuccessContent,
              closable: true,
            ),
          ),
          Text(
            AppLocalizations.of(context)!.validateInformationRecognizedData,
            style: context.tokens.textStyle.tokensTypographyHeadingXl,
          ),
          const SizedBox(height: 24),
          BulletItem.icon(
            label: AppLocalizations.of(context)!
                .validateInformationHospitalDepartment(
                    widget.viewModel.hospitalName,
                    widget.viewModel.departmentName),
            icon: Icon(
              CustomIcons.bell_03,
              color: context.tokens.color.tokensTurqoise600,
            ),
          ),
          const SizedBox(height: 16),
          BulletItem.icon(
            label: AppLocalizations.of(context)!
                .validateInformationTreatment(widget.viewModel.treatmentName),
            icon: Icon(
              CustomIcons.heart,
              color: context.tokens.color.tokensTurqoise600,
            ),
          ),
          const SizedBox(height: 16),
          BulletItem.icon(
            label: AppLocalizations.of(context)!
                .validateInformationPatientName(widget.viewModel.patientName),
            icon: Icon(
              CustomIcons.user_01,
              color: context.tokens.color.tokensTurqoise600,
            ),
          ),
          const SizedBox(height: 24),
          Button.secondary(
            label: AppLocalizations.of(context)!
                .validateInformationIncorrectButton,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
