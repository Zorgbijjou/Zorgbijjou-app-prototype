import 'package:core/widgets/outlined_focus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as fmd;
import 'package:markdown/markdown.dart' as md;
import 'package:theme/assets/tokens/tokens.g.dart';
import 'package:url_launcher/url_launcher.dart';

import '../styles/colored_button_style.dart';

class Markdown extends StatelessWidget {
  final String content;

  const Markdown({
    super.key,
    this.content = '',
  });

  getMarkdownImageAsset(Uri uri) {
    if (uri.hasScheme) {
      return Image.network(uri.toString());
    }

    if (kIsWeb) {
      return Image.asset(uri.toString());
    }

    return Image.asset('assets/$uri');
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return fmd.MarkdownBody(
        data: content,
        blockSyntaxes: [SectionSpacingSyntax()],
        builders: {
          'sectionSpacing': SectionSpacingBuilder(),
          'a': AccessibleLinkBuilder(),
        },
        imageBuilder: (uri, title, alt) {
          return getMarkdownImageAsset(uri);
        },
        onTapLink: (text, url, title) {
          _launchUrl(url);
        },
        styleSheet: fmd.MarkdownStyleSheet.fromTheme(ThemeData(
            textTheme: TextTheme(
          titleSmall: context.tokens.textStyle.tokensTypographyParagraphSm
              .copyWith(color: Colors.red),
          bodyMedium: context
              .tokens.textStyle.tokensTypographyParagraphMd, // Paragraphs
          headlineSmall: context
              .tokens.textStyle.tokensTypographyHeadingLg, // Heading 1: #
          titleLarge: context
              .tokens.textStyle.tokensTypographyHeadingMd, // Heading 2: ##
          titleMedium: context
              .tokens.textStyle.tokensTypographyHeadingSm, // Heading 3: ##
        ))).copyWith(
            blockquotePadding: const EdgeInsets.all(16),
            blockquoteDecoration: ShapeDecoration(
                color: context.tokens.color.tokensBlue50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)))));
  }
}

class SectionSpacingBuilder extends fmd.MarkdownElementBuilder {
  @override
  Widget? visitText(md.Text text, TextStyle? preferredStyle) {
    return const SizedBox(
      height: 16,
    );
  }

  @override
  bool isBlockElement() {
    return true;
  }
}

class SectionSpacingSyntax extends md.BlockSyntax {
  @override
  md.Node? parse(md.BlockParser parser) {
    parser.advance();
    return md.Element.text('sectionSpacing', 'sectionSpacing');
  }

  @override
  RegExp get pattern => RegExp(r'^---section---$');
}

class AccessibleLinkBuilder extends fmd.MarkdownElementBuilder {
  var focusNode = FocusNode();

  @override
  Widget? visitElementAfterWithContext(BuildContext context, md.Element element,
      TextStyle? preferredStyle, TextStyle? parentStyle) {
    if (element.tag == 'a') {
      String text = element.textContent;
      String? url = element.attributes['href'];

      var baseStyle = TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      );

      var buttonStyle = ColoredButtonStyle.subtleButtonStyle(context)
          .getButtonStyle(baseStyle);

      return Text.rich(
        TextSpan(children: [
          WidgetSpan(
            child: Semantics(
              link: true,
              label: text,
              excludeSemantics: true,
              child: OutlinedFocus(
                focusNode: focusNode,
                borderRadius: BorderRadius.circular(4),
                builder: (context, showFocus) {
                  return TextButton(
                    focusNode: focusNode,
                    onPressed: () {
                      if (url != null) {
                        _launchUrl(url);
                      }
                    },
                    style: buttonStyle,
                    child: Text(
                      text,
                      style: context
                          .tokens.textStyle.tokensTypographyParagraphMd
                          .copyWith(
                        color: context.tokens.color.tokensTurqoise600,
                        height: 1.0,
                        decoration: TextDecoration.underline,
                        decorationColor: context.tokens.color.tokensTurqoise600,
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ]),
      );
    }
    return null;
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
