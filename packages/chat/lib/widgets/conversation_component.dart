import 'package:chat/chat.dart';
import 'package:core/core.dart';
import 'package:core/widgets/form_input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:theme/theme.dart';

class ConversationComponent extends StatefulWidget {
  const ConversationComponent({
    super.key,
    required this.pageHeader,
    required this.viewModel,
    required this.onMessageSendClicked,
  });

  final Widget pageHeader;

  final ConversationViewModel viewModel;
  final Function(BuildContext context, String message) onMessageSendClicked;

  @override
  State<ConversationComponent> createState() => _ConversationComponentState();
}

class _ConversationComponentState extends State<ConversationComponent>
    with SingleTickerProviderStateMixin {
  late TextEditingController _messageController;
  late List<GlobalKey> messageKeys;
  late ScrollController _scrollController;
  final FocusNode _messageInputFocusNode = FocusNode();

  @override
  void initState() {
    _messageController = TextEditingController();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScrollToCloseKeyboard);

    _initializeMessageKeys();
    _onScrollToFocussedMessage(true);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant ConversationComponent oldWidget) {
    if (oldWidget.viewModel.richMessages != widget.viewModel.richMessages) {
      _initializeMessageKeys();

      var isInitialScroll = oldWidget.viewModel.focusMessageIndex == 0;
      _onScrollToFocussedMessage(isInitialScroll);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  void _onScrollToCloseKeyboard() {
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    var scrollVelocity = _scrollController.position.activity!.velocity;
    var scrollDirection = _scrollController.position.userScrollDirection;

    if (scrollDirection == ScrollDirection.forward && scrollVelocity < -750) {
      FocusScope.of(context).unfocus();
    }
  }

  void _onScrollToFocussedMessage(bool isInitialScroll) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      int messageFocusIndex = widget.viewModel.focusMessageIndex;
      if (messageFocusIndex == 0) {
        return;
      }

      if (messageKeys[messageFocusIndex].currentContext == null) {
        return;
      }

      if (isInitialScroll) {
        Scrollable.ensureVisible(
            messageKeys[messageFocusIndex].currentContext!);
      } else {
        Scrollable.ensureVisible(messageKeys[messageFocusIndex].currentContext!,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      }
    });
  }

  void _initializeMessageKeys() {
    messageKeys = List.generate(
        widget.viewModel.richMessages.length, (index) => GlobalKey());
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      widget.pageHeader,
      Divider(
        color: context.tokens.color.tokensGrey200,
        height: 0,
      ),
      Expanded(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/chat-background.jpeg',
                  package: 'chat'),
              fit: BoxFit.fill,
            ),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: !widget.viewModel.isLoading
                ? Column(
                    key: const ValueKey('npt_loading'),
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          child: SingleChildScrollView(
                            key: const ValueKey('scrollable'),
                            controller: _scrollController,
                            child: buildMessagesWidget(context),
                          ),
                        ),
                      ),
                      buildSendMessageWidget(context),
                    ],
                  )
                : Center(
                    key: const ValueKey('loading'),
                    child: CircularProgressIndicator(
                      color: context.tokens.color.tokensRed600,
                    ),
                  ),
          ),
        ),
      ),
    ]);
  }

  Widget buildMessagesWidget(BuildContext context) {
    Widget build = GridPadding(
      verticalPadding: 24,
      child: Column(
        children: [
          for (int i = 0; i < widget.viewModel.richMessages.length; i++) ...[
            SizedBox(
              height: _calculateSpacingToPreviousMessage(
                messageIndex: i,
                isFirstMessageForUserInBlock: !widget.viewModel
                    .isConsecutiveMessageOfUser(
                        widget.viewModel.richMessages[i]),
                isShowingDivider: i == widget.viewModel.focusMessageIndex + 1,
              ),
            ),
            Builder(builder: (context) {
              if (i != (widget.viewModel.focusMessageIndex + 1)) {
                return const SizedBox.shrink();
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: CustomDivider.label(
                  label: AppLocalizations.of(context)!.conversationNewMessage,
                  color: context.tokens.color.tokensTurqoise700,
                ),
              );
            }),
            //
            MessageComponent(
              key: messageKeys[i],
              conversationTitle: widget.viewModel.practitionerName,
              message: widget.viewModel.richMessages[i],
              isFirstMessage: !widget.viewModel
                  .isConsecutiveMessageOfUser(widget.viewModel.richMessages[i]),
            ),
          ]
        ],
      ),
    );

    return build;
  }

  Widget buildSendMessageWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.tokens.color.tokensWhite,
        border: Border(
          top: BorderSide(
            color: context.tokens.color.tokensGrey200,
            width: 1,
          ),
        ),
      ),
      child: GridPadding(
        verticalPadding: 12,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: ZbjFormInputTextField(
                accessibleLabel: AppLocalizations.of(context)!
                    .conversationSendMessageSemanticLabel,
                inputFormatters: const [],
                maxLines: 5,
                controller: _messageController,
                focusNode: _messageInputFocusNode,
                textAlign: TextAlign.start,
                suppressOutlineFocus: true,
              ),
            ),
            const SizedBox(width: 8),
            ZbjIconButton.primary(
              icon: Transform.translate(
                offset: const Offset(-3, 0),
                child: Transform.rotate(
                  angle: 0.8,
                  child: const Icon(CustomIcons.send_01),
                ),
              ),
              onPressed: () {
                widget.onMessageSendClicked(context, _messageController.text);
                _messageController.clear();
              },
            )
          ],
        ),
      ),
    );
  }

  double _calculateSpacingToPreviousMessage({
    required int messageIndex,
    required bool isFirstMessageForUserInBlock,
    required bool isShowingDivider,
  }) {
    // No space for first message
    if (messageIndex == 0) {
      return 0;
    }

    // If the previous message was sent by the same user as the current message add less spacing
    return isFirstMessageForUserInBlock || isShowingDivider ? 24 : 8;
  }
}
