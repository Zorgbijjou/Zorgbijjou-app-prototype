import 'package:core/core.dart';
import 'package:core/widgets/form_input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:onboarding/view_models/login_view_model.dart';
import 'package:theme/assets/icons/custom_icons.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

class Login extends StatefulWidget {
  final LoginViewModel viewModel;
  final Function(BuildContext context) onShowLoginInformationClicked;
  final VoidCallback onSubmitLogin;

  final GlobalKey<FormState> formKey;
  final TextEditingController loginCodeController;
  final TextEditingController birthDateController;

  const Login({
    super.key,
    required this.viewModel,
    required this.formKey,
    required this.loginCodeController,
    required this.birthDateController,
    required this.onShowLoginInformationClicked,
    required this.onSubmitLogin,
  });

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  var birthDateFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 24, left: 24, bottom: 16, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.onboardingLoginHeader,
              style: context.tokens.textStyle.tokensTypographyHeadingXl,
            ),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.onboardingLoginParagraph,
              style: context.tokens.textStyle.tokensTypographyParagraphMd,
            ),
            const SizedBox(height: 24),
            widget.viewModel.error != null
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child:
                        buildErrorNotificationBanner(widget.viewModel.error!),
                  )
                : const SizedBox.shrink(),
            Text(
              AppLocalizations.of(context)!.loginCodeHeader,
              style: context.tokens.textStyle.tokensTypographyParagraphBoldMd,
            ),
            const SizedBox(height: 8),
            ZbjFormInputCodeField(
              fields: 6,
              controller: widget.loginCodeController,
              validator: (val) {
                if (val == null || val.trim().length != 6) {
                  return AppLocalizations.of(context)!.loginCodeIncomplete;
                }
                return null;
              },
              onSubmitted: widget.onSubmitLogin,
            ),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.birthDateHeader,
              style: context.tokens.textStyle.tokensTypographyParagraphBoldMd,
            ),
            const SizedBox(height: 8),
            ZbjFormInputTextField(
              controller: widget.birthDateController,
              accessibleLabel:
                  AppLocalizations.of(context)!.birthDateAccessibleLabel,
              hint: AppLocalizations.of(context)!.birthDateExample,
              inputWidth: 160,
              validator: (val) {
                if (!isValidDate(val)) {
                  return AppLocalizations.of(context)!.birthDateIncomplete;
                }
                return null;
              },
              inputFormatters: [
                MaskTextInputFormatter(
                  mask: '##-##-####',
                  filter: {'#': RegExp(r'[0-9]')},
                  type: MaskAutoCompletionType.eager,
                ),
              ],
              onFieldSubmitted: (val) => widget.onSubmitLogin(),
              focusNode: birthDateFocusNode,
            ),
            const SizedBox(height: 24),
            Button.subtle(
              label: AppLocalizations.of(context)!
                  .onboardingShowLoginInformationButton,
              icon: const Icon(CustomIcons.info_circle),
              onPressed: () {
                widget.onShowLoginInformationClicked(context);
              },
              cropped: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildErrorNotificationBanner(LoginError error) {
    if (error == LoginError.authenticationError) {
      return NotificationBanner.negative(
        title: AppLocalizations.of(context)!.loginAuthenticationErrorTitle,
        content: AppLocalizations.of(context)!.loginAuthenticationErrorMessage,
      );
    }

    return NotificationBanner.negative(
      title: AppLocalizations.of(context)!.unexpectedErrorTitle,
      content: AppLocalizations.of(context)!.unexpectedErrorMessage,
    );
  }

  bool isValidDate(String? value) {
    if (value == null) return false;
    RegExp dateRegex = RegExp(r'^\d{2}-\d{2}-\d{4}$');
    if (!dateRegex.hasMatch(value)) return false;

    List<String> parts = value.split('-');
    int? day = int.tryParse(parts[0]);
    int? month = int.tryParse(parts[1]);
    int? year = int.tryParse(parts[2]);

    if (day == null || month == null || year == null) return false;

    DateTime date = DateTime(year, month, day);

    return date.year == year && date.month == month && date.day == day;
  }
}
