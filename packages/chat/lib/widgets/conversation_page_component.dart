import 'package:chat/view_models/conversation_view_model.dart';
import 'package:chat/widgets/conversation_component.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:theme/assets/icons/custom_icons.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

import 'avatar_component.dart';

class ConversationPageComponent extends StatefulWidget {
  final ConversationViewModel viewModel;
  final Function(BuildContext context) onBackClicked;
  final Function(BuildContext context, String message) onMessageSendClicked;

  const ConversationPageComponent({
    super.key,
    required this.viewModel,
    required this.onBackClicked,
    required this.onMessageSendClicked,
  });

  @override
  State<StatefulWidget> createState() {
    return _ConversationComponentState();
  }
}

class _ConversationComponentState extends State<ConversationPageComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.tokens.color.tokensWhite,
        toolbarHeight: 0,
      ),
      body: SafeArea(
          child: ConversationComponent(
        pageHeader: ZbjPageHeader.subLevel(
          icon: ZbjIconButton.subtle(
            icon: const Icon(CustomIcons.arrow_left),
            onPressed: () {
              widget.onBackClicked(context);
            },
          ),
          title: widget.viewModel.practitionerName,
          avatar: AvatarComponent.medium(
            image: const AssetImage('assets/images/avatar-placeholder.png',
                package: 'chat'),
          ),
        ),
        viewModel: widget.viewModel,
        onMessageSendClicked: widget.onMessageSendClicked,
      )),
    );
  }
}
