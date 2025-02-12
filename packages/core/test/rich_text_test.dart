import 'package:core/widgets/rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theme/theme.dart';

import 'helpers.dart';

List<InlineSpan> _getSpans(Finder textFinder) {
  return textFinder
      .evaluate()
      .map((w) => (w.widget as Text).textSpan as TextSpan)
      .expand((span) => span.children!)
      .toList();
}

void main() {
  testWidgets('Should show text in one span', (tester) async {
    await tester.pumpWidget(materialAppWithTokens(
      child: ZbjRichText(
        text: 'Lorum ipsum',
        style: DefaultTextStyleTokens().tokensTypographyParagraphMd,
      ),
    ));

    expect(find.text('Lorum ipsum'), findsOneWidget);
  });

  testWidgets('Should show phone number with color and underlined',
      (tester) async {
    TextStyle textStyle = DefaultTextStyleTokens().tokensTypographyParagraphXs;
    TextStyle linkTextStyle = textStyle.copyWith(
      color: DefaultColorTokens().tokensTurqoise600,
      decoration: TextDecoration.underline,
    );

    await tester.pumpWidget(materialAppWithTokens(
      child: ZbjRichText(
        text: 'Lorum ipsum 0695959555 me',
        style: textStyle,
      ),
    ));

    var textFinder = find.text('Lorum ipsum 0695959555 me');
    List<InlineSpan> textSpans = _getSpans(textFinder);
    expect(textSpans[0].style, textStyle);
    expect(textSpans[1].style, linkTextStyle);
    expect(textSpans[2].style, textStyle);
  });

  testWidgets('Should split text on phone number', (tester) async {
    var textStyle = DefaultTextStyleTokens().tokensTypographyParagraphXs;
    TextStyle linkTextStyle = textStyle.copyWith(
      color: DefaultColorTokens().tokensTurqoise600,
      decoration: TextDecoration.underline,
    );

    await tester.pumpWidget(materialAppWithTokens(
      child: ZbjRichText(
        text: 'Lorum ipsum 0695959555. me',
        style: textStyle,
      ),
    ));

    var textFinder = find.text('Lorum ipsum 0695959555. me');
    List<InlineSpan> textSpans = _getSpans(textFinder);

    expect(textSpans[0].toPlainText(), 'Lorum ipsum ');
    expect(textSpans[1].toPlainText(), '0695959555');
    expect(textSpans[2].toPlainText(), '. me');

    expect(textSpans[0].style, textStyle);
    expect(textSpans[1].style, linkTextStyle);
    expect(textSpans[2].style, textStyle);
  });

  testWidgets('Should split on phone number in the beginning', (tester) async {
    var textStyle = DefaultTextStyleTokens().tokensTypographyParagraphXs;
    TextStyle linkTextStyle = textStyle.copyWith(
      color: DefaultColorTokens().tokensTurqoise600,
      decoration: TextDecoration.underline,
    );

    await tester.pumpWidget(materialAppWithTokens(
      child: ZbjRichText(
        text: '0302524180 me and a lot of other text.',
        style: textStyle,
      ),
    ));

    var textFinder = find.text('0302524180 me and a lot of other text.');
    List<InlineSpan> textSpans = _getSpans(textFinder);

    expect(textSpans[0].toPlainText(), '0302524180');
    expect(textSpans[1].toPlainText(), ' me and a lot of other text.');

    expect(textSpans[0].style, linkTextStyle);
    expect(textSpans[1].style, textStyle);
  });

  testWidgets('Should split on phone number in the end', (tester) async {
    var textStyle = DefaultTextStyleTokens().tokensTypographyParagraphXs;
    TextStyle linkTextStyle = textStyle.copyWith(
      color: DefaultColorTokens().tokensTurqoise600,
      decoration: TextDecoration.underline,
    );

    await tester.pumpWidget(materialAppWithTokens(
      child: ZbjRichText(
        text: 'Some text0302524180',
        style: textStyle,
      ),
    ));

    var textFinder = find.text('Some text0302524180');
    List<InlineSpan> textSpans = _getSpans(textFinder);

    expect(textSpans[0].toPlainText(), 'Some text');
    expect(textSpans[1].toPlainText(), '0302524180');

    expect(textSpans[0].style, textStyle);
    expect(textSpans[1].style, linkTextStyle);
  });

  testWidgets('Should split on multiple phone numbers', (tester) async {
    var textStyle = DefaultTextStyleTokens().tokensTypographyParagraphXs;
    TextStyle linkTextStyle = textStyle.copyWith(
      color: DefaultColorTokens().tokensTurqoise600,
      decoration: TextDecoration.underline,
    );

    await tester.pumpWidget(materialAppWithTokens(
      child: ZbjRichText(
        text: 'Some text0302524180 and call 0695959555 me.',
        style: textStyle,
      ),
    ));

    var textFinder = find.text('Some text0302524180 and call 0695959555 me.');
    List<InlineSpan> textSpans = _getSpans(textFinder);

    expect(textSpans[0].toPlainText(), 'Some text');
    expect(textSpans[1].toPlainText(), '0302524180');
    expect(textSpans[2].toPlainText(), ' and call ');
    expect(textSpans[3].toPlainText(), '0695959555');
    expect(textSpans[4].toPlainText(), ' me.');

    expect(textSpans[0].style, textStyle);
    expect(textSpans[1].style, linkTextStyle);
    expect(textSpans[2].style, textStyle);
    expect(textSpans[3].style, linkTextStyle);
    expect(textSpans[4].style, textStyle);
  });
}
