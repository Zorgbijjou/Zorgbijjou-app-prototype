import 'package:chat/chat.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

class ConversationsTabletComponent extends StatelessWidget {
  final ConversationsViewModel conversationsViewModel;
  final ConversationViewModel? activeConversationViewModel;
  final Function(BuildContext, Conversation) onConversationClicked;
  final Function(BuildContext, String) onMessageSendClicked;

  const ConversationsTabletComponent({
    super.key,
    required this.conversationsViewModel,
    required this.activeConversationViewModel,
    required this.onConversationClicked,
    required this.onMessageSendClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.tokens.color.tokensTurqoise800,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Container(
          color: context.tokens.color.tokensWhite,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageHeader.firstLevel(
                  title: 'Gesprek',
                  icon: Icon(
                    CustomIcons.message_text_square_02,
                    color: context.tokens.color.tokensTurqoise400,
                    size: 32,
                  )),
              Divider(color: context.tokens.color.tokensGrey200, height: 0),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridSizedBox(
                      alignment: GridSizedBoxAlignment.left,
                      defaultColumnSpan: 3,
                      columnSpans: const {GridSize.lg: 5, GridSize.xl: 5},
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: context.tokens.color.tokensGrey200,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Builder(builder: (context) {
                          if (conversationsViewModel.isLoading) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          var conversations =
                              conversationsViewModel.conversationsOrdered;

                          if (conversations.isEmpty) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(AppLocalizations.of(context)!
                                    .noConversations),
                              ),
                            );
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: conversations.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var conversation = conversations[index];
                              var isSelected =
                                  _isConversationSelected(conversation);
                              return ConversationItemComponent.fromConversation(
                                isSelected: isSelected,
                                conversation: conversation,
                                onTap: () => onConversationClicked(
                                    context, conversation),
                              );
                            },
                          );
                        }),
                      ),
                    ),
                    GridSizedBox(
                      alignment: GridSizedBoxAlignment.right,
                      defaultColumnSpan: 3,
                      columnSpans: const {
                        GridSize.lg: 7,
                        GridSize.xl: 7,
                      },
                      includeGutter: true,
                      child: activeConversationViewModel != null
                          ? ConversationComponent(
                              pageHeader: PageHeader.subLevel(
                                title: activeConversationViewModel!
                                    .practitionerName,
                                avatar: AvatarComponent.medium(
                                  image: const AssetImage(
                                      'assets/images/avatar-placeholder.png',
                                      package: 'chat'),
                                ),
                              ),
                              viewModel: activeConversationViewModel!,
                              onMessageSendClicked: onMessageSendClicked,
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool _isConversationSelected(Conversation conversation) {
    return activeConversationViewModel != null &&
        activeConversationViewModel!.conversationId == conversation.id;
  }
}
