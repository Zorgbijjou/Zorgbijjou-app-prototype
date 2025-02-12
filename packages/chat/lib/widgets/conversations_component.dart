import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:theme/assets/icons/custom_icons.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

import '../chat.dart';

class ConversationsComponent extends StatelessWidget {
  final ConversationsViewModel viewModel;
  final Function(BuildContext, Conversation) onConversationClicked;

  const ConversationsComponent({
    super.key,
    required this.viewModel,
    required this.onConversationClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.tokens.color.tokensWhite,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          color: context.tokens.color.tokensWhite,
          child: SingleChildScrollView(child: Builder(builder: (context) {
            if (viewModel.isLoading) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            var conversations = viewModel.conversationsOrdered;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageHeader.firstLevel(
                  title: AppLocalizations.of(context)!.conversationTitle,
                  icon: Icon(
                    CustomIcons.message_text_square_02,
                    color: context.tokens.color.tokensTurqoise400,
                    size: 32,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: conversations.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var conversation = conversations[index];

                    return ConversationItemComponent.fromConversation(
                      conversation: conversation,
                      onTap: () => onConversationClicked(context, conversation),
                    );
                  },
                ),
              ],
            );
          })),
        ),
      ),
    );
  }
}
