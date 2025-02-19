import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:theme/assets/tokens/tokens.g.dart';
import 'package:url_launcher/url_launcher.dart';

class ZbjRichText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextOverflow? overflow;

  const ZbjRichText({
    super.key,
    required this.text,
    required this.style,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: _buildTextSpans(context)),
      overflow: overflow,
    );
  }

  List<TextSpan> _buildTextSpans(BuildContext context) {
    RegExp phoneRegex =
        RegExp(r'\+?[0-9]{1,4}?[-.\s]?(\(?\d{1,3}?\)?[-.\s]?)?\d{3,}');

    List<TextSpan> spans = <TextSpan>[];
    Iterable<RegExpMatch> matches = phoneRegex.allMatches(text);

    int start = 0;
    for (RegExpMatch match in matches) {
      if (match.start > start) {
        spans.add(TextSpan(
          text: text.substring(start, match.start),
          style: style,
        ));
      }
      spans.add(TextSpan(
        text: match.group(0),
        style: style.copyWith(
          color: context.tokens.color.tokensTurqoise600,
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () => _launchPhone('${match.group(0)}'),
      ));
      start = match.end;
    }

    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: style,
      ));
    }

    return spans;
  }

  Future<void> _launchPhone(String phoneNumber) async {
    Uri url = Uri.parse('tel://$phoneNumber');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
