import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:theme/assets/icons/custom_icons.dart';
import 'package:theme/assets/tokens/tokens.g.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactFooter extends StatelessWidget {
  final Uri _contactPhone = Uri.parse('tel://0302524180');
  final Uri _contactEmail = Uri.parse('mailto:info@zorgbijjou.nl');

  ContactFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.tokens.color.tokensTurqoise100),
      child: Stack(
        children: [
          Container(
            height: 134 + 64,
            padding: const EdgeInsets.only(top: 64),
            child: Align(
              alignment: Alignment.topRight,
              child: Image.asset('packages/faq/assets/images/faq.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 179 - 3 * 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.contactFooterHeader,
                        style:
                            context.tokens.textStyle.tokensTypographyHeadingLg,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppLocalizations.of(context)!.contactFooterInformation,
                        style: context
                            .tokens.textStyle.tokensTypographyParagraphMd,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ZbjStackedButton.primary(
                          fill: true,
                          label:
                              AppLocalizations.of(context)!.contactFooterCallUs,
                          onPressed: () => _launchUrl(_contactPhone),
                          icon: const Icon(CustomIcons.phone),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ZbjStackedButton.primary(
                          fill: true,
                          label: AppLocalizations.of(context)!
                              .contactFooterConversation,
                          onPressed: () => _launchUrl(_contactEmail),
                          icon: const Icon(CustomIcons.message_square_02),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
