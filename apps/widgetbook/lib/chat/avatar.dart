import 'package:chat/chat.dart';
import 'package:core/data_source/locale_data_source_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theme/theme.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
    name: 'Small',
    type: AvatarComponent,
    designLink:
        'https://www.figma.com/design/MtBXGXmFo8CcMmFmtHB1PP/Pati%C3%ABntenapp?node-id=3294-20212',
    path: 'Chat')
Widget buildSmallAvatarUseCase(BuildContext context) {
  var localeDataSource = LocaleDataSourceImpl(bundle: rootBundle);
  var showImage = context.knobs.boolean(label: 'With image');

  return FutureBuilder(
      future: localeDataSource.initializeLocales(['nl', 'en']),
      builder: (context, _) => Column(children: [
            Container(
                color: context.tokens.color.tokensWhite,
                child: AvatarComponent.small(
                  name: !showImage
                      ? context.knobs.string(
                          label: 'Name',
                          description: 'Name of the person',
                          initialValue: 'Test Patient')
                      : null,
                  image: showImage
                      ? const AssetImage('assets/images/avatar-placeholder.png',
                          package: 'chat')
                      : null,
                ))
          ]));
}

@widgetbook.UseCase(
    name: 'Medium',
    type: AvatarComponent,
    designLink:
        'https://www.figma.com/design/MtBXGXmFo8CcMmFmtHB1PP/Pati%C3%ABntenapp?node-id=3294-20212',
    path: 'Chat')
Widget buildMediumAvatarUseCase(BuildContext context) {
  var localeDataSource = LocaleDataSourceImpl(bundle: rootBundle);
  var showImage = context.knobs.boolean(label: 'With image');

  return FutureBuilder(
      future: localeDataSource.initializeLocales(['nl', 'en']),
      builder: (context, _) => Column(children: [
            Container(
                color: context.tokens.color.tokensWhite,
                child: AvatarComponent.medium(
                  name: !showImage
                      ? context.knobs.string(
                          label: 'Name',
                          description: 'Name of the person',
                          initialValue: 'Test Patient')
                      : null,
                  image: showImage
                      ? const AssetImage('assets/images/avatar-placeholder.png',
                          package: 'chat')
                      : null,
                ))
          ]));
}
