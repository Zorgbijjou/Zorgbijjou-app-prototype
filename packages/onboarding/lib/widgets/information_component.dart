import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:theme/assets/icons/custom_icons.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

class InformationComponent extends StatelessWidget {
  final String header;
  final String? content;
  final Function(BuildContext context) onBackClicked;

  const InformationComponent({
    super.key,
    required this.header,
    required this.content,
    required this.onBackClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: context.tokens.color.tokensWhite),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 24, right: 24, bottom: 0, left: 24),
                child: Button.subtle(
                  label: AppLocalizations.of(context)!.backButton,
                  icon: const Icon(CustomIcons.arrow_left),
                  onPressed: () {
                    onBackClicked(context);
                  },
                  cropped: true,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 16, right: 24, bottom: 16, left: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          header,
                          style: context
                              .tokens.textStyle.tokensTypographyHeading2xl,
                        ),
                        const SizedBox(height: 24),
                        ZbjMarkdown(content: content ?? ''),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
