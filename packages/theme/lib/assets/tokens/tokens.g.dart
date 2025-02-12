import 'package:flutter/material.dart';

part 'tokens_extra.g.dart';

abstract class ITokens {
  ColorTokens get color;
  TextStyleTokens get textStyle;
  MaterialColorTokens get materialColor;
}

abstract class ColorTokens {
  Color get tokensGrey50;
  Color get tokensGrey100;
  Color get tokensGrey200;
  Color get tokensGrey300;
  Color get tokensGrey400;
  Color get tokensGrey500;
  Color get tokensGrey600;
  Color get tokensGrey700;
  Color get tokensGrey800;
  Color get tokensOrange50;
  Color get tokensOrange100;
  Color get tokensOrange200;
  Color get tokensOrange300;
  Color get tokensOrange400;
  Color get tokensOrange500;
  Color get tokensOrange600;
  Color get tokensOrange700;
  Color get tokensOrange800;
  Color get tokensYellow50;
  Color get tokensYellow100;
  Color get tokensYellow200;
  Color get tokensYellow300;
  Color get tokensYellow400;
  Color get tokensYellow500;
  Color get tokensYellow600;
  Color get tokensYellow700;
  Color get tokensYellow800;
  Color get tokensTurqoise50;
  Color get tokensTurqoise100;
  Color get tokensTurqoise200;
  Color get tokensTurqoise300;
  Color get tokensTurqoise400;
  Color get tokensTurqoise500;
  Color get tokensTurqoise600;
  Color get tokensTurqoise700;
  Color get tokensTurqoise800;
  Color get tokensGreen50;
  Color get tokensGreen300;
  Color get tokensGreen600;
  Color get tokensGreen800;
  Color get tokensRed50;
  Color get tokensRed400;
  Color get tokensRed600;
  Color get tokensRed800;
  Color get tokensBlue50;
  Color get tokensBlue300;
  Color get tokensBlue600;
  Color get tokensBlue800;
  Color get tokensWhite;
}

abstract class TextStyleTokens {
  TextStyle get tokensTypographyParagraphXs;
  TextStyle get tokensTypographyParagraphSm;
  TextStyle get tokensTypographyParagraphMd;
  TextStyle get tokensTypographyParagraphLg;
  TextStyle get tokensTypographyParagraphBoldXs;
  TextStyle get tokensTypographyParagraphBoldSm;
  TextStyle get tokensTypographyParagraphBoldMd;
  TextStyle get tokensTypographyParagraphBoldLg;
  TextStyle get tokensTypographyHeadingSm;
  TextStyle get tokensTypographyHeadingMd;
  TextStyle get tokensTypographyHeadingLg;
  TextStyle get tokensTypographyHeadingXl;
  TextStyle get tokensTypographyHeading2xl;
  TextStyle get tokensTypographyHeading3xl;
  TextStyle get tokensTypographyHeading4xl;
}

abstract class MaterialColorTokens {
  MaterialColor get tokensGrey;
  MaterialColor get tokensOrange;
  MaterialColor get tokensYellow;
  MaterialColor get tokensTurqoise;
  MaterialColor get tokensGreen;
  MaterialColor get tokensRed;
  MaterialColor get tokensBlue;
}

class DefaultTokens extends ITokens {
  @override
  ColorTokens get color => DefaultColorTokens();
  @override
  TextStyleTokens get textStyle => DefaultTextStyleTokens();
  @override
  MaterialColorTokens get materialColor => DefaultMaterialColorTokens();
}

class DefaultColorTokens extends ColorTokens {
  @override
  Color get tokensGrey50 => const Color(0xFFF6F6F6);
  @override
  Color get tokensGrey100 => const Color(0xFFF0F0F0);
  @override
  Color get tokensGrey200 => const Color(0xFFD3D3D3);
  @override
  Color get tokensGrey300 => const Color(0xFFBCBCBC);
  @override
  Color get tokensGrey400 => const Color(0xFF949494);
  @override
  Color get tokensGrey500 => const Color(0xFF717171);
  @override
  Color get tokensGrey600 => const Color(0xFF585858);
  @override
  Color get tokensGrey700 => const Color(0xFF3C3C3C);
  @override
  Color get tokensGrey800 => const Color(0xFF222222);
  @override
  Color get tokensOrange50 => const Color(0xFFFFF2EE);
  @override
  Color get tokensOrange100 => const Color(0xFFFFD4C6);
  @override
  Color get tokensOrange200 => const Color(0xFFFFBFA9);
  @override
  Color get tokensOrange300 => const Color(0xFFFFA789);
  @override
  Color get tokensOrange400 => const Color(0xFFFF7E51);
  @override
  Color get tokensOrange500 => const Color(0xFFEE6A3C);
  @override
  Color get tokensOrange600 => const Color(0xFFC2522B);
  @override
  Color get tokensOrange700 => const Color(0xFF8A4730);
  @override
  Color get tokensOrange800 => const Color(0xFF502C1F);
  @override
  Color get tokensYellow50 => const Color(0xFFFFF7E8);
  @override
  Color get tokensYellow100 => const Color(0xFFFEECC6);
  @override
  Color get tokensYellow200 => const Color(0xFFFFD57D);
  @override
  Color get tokensYellow300 => const Color(0xFFFFC13F);
  @override
  Color get tokensYellow400 => const Color(0xFFF9A900);
  @override
  Color get tokensYellow500 => const Color(0xFFDC9500);
  @override
  Color get tokensYellow600 => const Color(0xFFB1821E);
  @override
  Color get tokensYellow700 => const Color(0xFF816427);
  @override
  Color get tokensYellow800 => const Color(0xFF594314);
  @override
  Color get tokensTurqoise50 => const Color(0xFFEAF7F8);
  @override
  Color get tokensTurqoise100 => const Color(0xFFCEEBED);
  @override
  Color get tokensTurqoise200 => const Color(0xFF93D8DD);
  @override
  Color get tokensTurqoise300 => const Color(0xFF54C2CA);
  @override
  Color get tokensTurqoise400 => const Color(0xFF00B0BD);
  @override
  Color get tokensTurqoise500 => const Color(0xFF0096A1);
  @override
  Color get tokensTurqoise600 => const Color(0xFF057982);
  @override
  Color get tokensTurqoise700 => const Color(0xFF1C6368);
  @override
  Color get tokensTurqoise800 => const Color(0xFF0F4D52);
  @override
  Color get tokensGreen50 => const Color(0xFFEAF4E3);
  @override
  Color get tokensGreen300 => const Color(0xFF88C860);
  @override
  Color get tokensGreen600 => const Color(0xFF477A27);
  @override
  Color get tokensGreen800 => const Color(0xFF2F501B);
  @override
  Color get tokensRed50 => const Color(0xFFFCECED);
  @override
  Color get tokensRed400 => const Color(0xFFFC656D);
  @override
  Color get tokensRed600 => const Color(0xFFCA323B);
  @override
  Color get tokensRed800 => const Color(0xFF521C20);
  @override
  Color get tokensBlue50 => const Color(0xFFDAE6F8);
  @override
  Color get tokensBlue300 => const Color(0xFF77ADFF);
  @override
  Color get tokensBlue600 => const Color(0xFF184486);
  @override
  Color get tokensBlue800 => const Color(0xFF182F52);
  @override
  Color get tokensWhite => const Color(0xFFFFFFFF);
}

class DefaultTextStyleTokens extends TextStyleTokens {
  @override
  TextStyle get tokensTypographyParagraphXs => const TextStyle(
        fontFamily: 'FS Me',
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0.0,
        package: 'theme',
      );
  @override
  TextStyle get tokensTypographyParagraphSm => const TextStyle(
        fontFamily: 'FS Me',
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0.0,
        package: 'theme',
      );
  @override
  TextStyle get tokensTypographyParagraphMd => const TextStyle(
        fontFamily: 'FS Me',
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0.0,
        package: 'theme',
      );
  @override
  TextStyle get tokensTypographyParagraphLg => const TextStyle(
        fontFamily: 'FS Me',
        fontSize: 20.0,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0.0,
        package: 'theme',
      );
  @override
  TextStyle get tokensTypographyParagraphBoldXs => const TextStyle(
        fontFamily: 'FS Me',
        fontSize: 12.0,
        fontWeight: FontWeight.w700,
        height: 1.5,
        letterSpacing: 0.0,
        package: 'theme',
      );
  @override
  TextStyle get tokensTypographyParagraphBoldSm => const TextStyle(
        fontFamily: 'FS Me',
        fontSize: 14.0,
        fontWeight: FontWeight.w700,
        height: 1.5,
        letterSpacing: 0.0,
        package: 'theme',
      );
  @override
  TextStyle get tokensTypographyParagraphBoldMd => const TextStyle(
        fontFamily: 'FS Me',
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
        height: 1.5,
        letterSpacing: 0.0,
        package: 'theme',
      );
  @override
  TextStyle get tokensTypographyParagraphBoldLg => const TextStyle(
        fontFamily: 'FS Me',
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
        height: 1.5,
        letterSpacing: 0.0,
        package: 'theme',
      );
  @override
  TextStyle get tokensTypographyHeadingSm => const TextStyle(
        fontFamily: 'FS Me',
        fontSize: 14.0,
        fontWeight: FontWeight.w700,
        height: 1.5,
        letterSpacing: 0.0,
        package: 'theme',
      );
  @override
  TextStyle get tokensTypographyHeadingMd => const TextStyle(
        fontFamily: 'FS Me',
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
        height: 1.5,
        letterSpacing: 0.0,
        package: 'theme',
      );
  @override
  TextStyle get tokensTypographyHeadingLg => const TextStyle(
        fontFamily: 'FS Me',
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
        height: 1.5,
        letterSpacing: 0.0,
        package: 'theme',
      );
  @override
  TextStyle get tokensTypographyHeadingXl => const TextStyle(
        fontFamily: 'FS Me',
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        height: 1.25,
        letterSpacing: 0.0,
        package: 'theme',
      );
  @override
  TextStyle get tokensTypographyHeading2xl => const TextStyle(
        fontFamily: 'FS Me',
        fontSize: 31.0,
        fontWeight: FontWeight.w700,
        height: 1.25,
        letterSpacing: -0.16,
        package: 'theme',
      );
  @override
  TextStyle get tokensTypographyHeading3xl => const TextStyle(
        fontFamily: 'FS Me',
        fontSize: 39.0,
        fontWeight: FontWeight.w700,
        height: 1.25,
        letterSpacing: -0.16,
        package: 'theme',
      );
  @override
  TextStyle get tokensTypographyHeading4xl => const TextStyle(
        fontFamily: 'FS Me',
        fontSize: 48.0,
        fontWeight: FontWeight.w700,
        height: 1.25,
        letterSpacing: -0.16,
        package: 'theme',
      );
}

class DefaultMaterialColorTokens extends MaterialColorTokens {
  @override
  MaterialColor get tokensGrey => const MaterialColor(0xFF717171, {
        50: Color(0xFFF6F6F6),
        100: Color(0xFFF0F0F0),
        200: Color(0xFFD3D3D3),
        300: Color(0xFFBCBCBC),
        400: Color(0xFF949494),
        500: Color(0xFF717171),
        600: Color(0xFF585858),
        700: Color(0xFF3C3C3C),
        800: Color(0xFF222222),
      });

  @override
  MaterialColor get tokensOrange => const MaterialColor(0xFFEE6A3C, {
        50: Color(0xFFFFF2EE),
        100: Color(0xFFFFD4C6),
        200: Color(0xFFFFBFA9),
        300: Color(0xFFFFA789),
        400: Color(0xFFFF7E51),
        500: Color(0xFFEE6A3C),
        600: Color(0xFFC2522B),
        700: Color(0xFF8A4730),
        800: Color(0xFF502C1F),
      });

  @override
  MaterialColor get tokensYellow => const MaterialColor(0xFFDC9500, {
        50: Color(0xFFFFF7E8),
        100: Color(0xFFFEECC6),
        200: Color(0xFFFFD57D),
        300: Color(0xFFFFC13F),
        400: Color(0xFFF9A900),
        500: Color(0xFFDC9500),
        600: Color(0xFFB1821E),
        700: Color(0xFF816427),
        800: Color(0xFF594314),
      });

  @override
  MaterialColor get tokensTurqoise => const MaterialColor(0xFF0096A1, {
        50: Color(0xFFEAF7F8),
        100: Color(0xFFCEEBED),
        200: Color(0xFF93D8DD),
        300: Color(0xFF54C2CA),
        400: Color(0xFF00B0BD),
        500: Color(0xFF0096A1),
        600: Color(0xFF057982),
        700: Color(0xFF1C6368),
        800: Color(0xFF0F4D52),
      });

  @override
  MaterialColor get tokensGreen => const MaterialColor(0xFFEAF4E3, {
        50: Color(0xFFEAF4E3),
        300: Color(0xFF88C860),
        600: Color(0xFF477A27),
        800: Color(0xFF2F501B),
      });

  @override
  MaterialColor get tokensRed => const MaterialColor(0xFFFCECED, {
        50: Color(0xFFFCECED),
        400: Color(0xFFFC656D),
        600: Color(0xFFCA323B),
        800: Color(0xFF521C20),
      });

  @override
  MaterialColor get tokensBlue => const MaterialColor(0xFFDAE6F8, {
        50: Color(0xFFDAE6F8),
        300: Color(0xFF77ADFF),
        600: Color(0xFF184486),
        800: Color(0xFF182F52),
      });
}
