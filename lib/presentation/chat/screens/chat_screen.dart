import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisp/core/config/constants/base_scaffold.dart';
import 'package:wisp/core/config/constants/colors.dart';
import 'package:wisp/presentation/chat/controller/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  final String userName;
  final bool isOnline;
  final String chatId;

  const ChatScreen({
    super.key,
    required this.userName,
    required this.isOnline,
    this.chatId = '',
  });

  @override
  Widget build(BuildContext context) {
    final List<String> messages = [
      '안녕하세요!',
      '오늘 날씨 어때요?',
      '주말에 뭐해요?',
      '프로젝트 진행 상황은 어때요?',
      '다음 주 회의 일정은 언제인가요?',
      '새로운 영화 봤어요?',
      '이번 주말에 시간 있어요?',
      '최근에 읽은 책 추천해 주세요.',
      '다음 달 여행 계획은 어떻게 되나요?',
      '새로운 음악 추천해 주세요.'
    ];

    return BaseScaffold(
      appBar: ChatAppbar(
        userName: userName,
        isOnline: isOnline,
      ),
      child: Column(
        children: [
          Expanded(
            child: _ChatMessageList(messages: messages),
          ),
          const ChatTextField(),
        ],
      ),
    );
  }
}

class _ChatMessageList extends StatelessWidget {
  final List<String> messages;

  const _ChatMessageList({required this.messages});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return ChatItem(
          message: messages[index],
          isRead: index % 2 == 0,
          isMe: index % 2 == 0,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemCount: messages.length,
    );
  }
}

class ChatAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final bool isOnline;

  const ChatAppbar({
    super.key,
    required this.userName,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: WispColors.deepBlue1,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          _BackButton(),
          const Gap(8),
          const _UserAvatar(),
          const Gap(12),
          Expanded(
            child: _UserInfo(
              userName: userName,
              isOnline: isOnline,
            ),
          ),
          _MoreButton(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.pop(),
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
    );
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 20,
      backgroundColor: Colors.white,
      child: Icon(
        Icons.person,
        color: WispColors.deepBlue1,
      ),
    );
  }
}

class _UserInfo extends StatelessWidget {
  final String userName;
  final bool isOnline;

  const _UserInfo({
    required this.userName,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          userName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        if (isOnline) ...[
          const SizedBox(height: 2),
          const _OnlineStatus(),
        ],
      ],
    );
  }
}

class _OnlineStatus extends StatelessWidget {
  const _OnlineStatus();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          Icons.circle,
          color: Colors.green,
          size: 12,
        ),
        SizedBox(width: 5),
        Text(
          '온라인',
          style: TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}

class _MoreButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  final String message;
  final bool isRead;
  final bool isMe;

  const ChatItem({
    super.key,
    required this.message,
    this.isRead = false,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: screenWidth * 0.75,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: _buildMessageDecoration(),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(4),
            _MessageFooter(
              isMe: isMe,
              isRead: isRead,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildMessageDecoration() {
    return BoxDecoration(
      gradient: isMe
          ? const LinearGradient(
              colors: [Color(0xFF3D7BF6), Color(0xFF8C52FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
          : null,
      color: isMe ? null : WispColors.deepBlue1.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(16),
      border: isMe
          ? null
          : Border.all(
              color: Colors.white24,
              width: 0.7,
            ),
    );
  }
}

class _MessageFooter extends StatelessWidget {
  final bool isMe;
  final bool isRead;

  const _MessageFooter({
    required this.isMe,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '오후 12:30',
          style: TextStyle(
            fontSize: 12,
            color: isMe ? Colors.white70 : Colors.white54,
          ),
        ),
        if (isMe && isRead) ...[
          const Gap(5),
          const Icon(
            Icons.done_all,
            size: 16,
            color: Colors.greenAccent,
          ),
        ],
      ],
    );
  }
}

// 채팅 입력 필드
class ChatTextField extends ConsumerStatefulWidget {
  const ChatTextField({super.key});

  @override
  ConsumerState<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends ConsumerState<ChatTextField> {
  bool _emojiShowing = false;
  bool _isAi = false;

  final List<String> aiSuggestions = [
    '안녕하세요! 무엇을 도와드릴까요?',
    '오늘 날씨가 정말 좋네요!',
    '주말에 특별한 계획이 있으신가요?',
    '프로젝트 진행 상황은 어떻게 되나요?',
    '다음 주 회의 일정은 언제인가요?',
  ];

  @override
  Widget build(BuildContext context) {
    final chatController = ref.watch(chatControllerProvider.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_isAi)
          Container(
              height: 200,
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    WispColors.deepBlue3,
                    WispColors.deepPurple,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border(
                  top: BorderSide(color: WispColors.grey, width: 0.5),
                  bottom: BorderSide(color: WispColors.grey, width: 0.5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "\u{1F916} AI 추천 메시지",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: aiSuggestions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          dense: true,
                          title: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: WispColors.grey,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              aiSuggestions[index],
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          onTap: () {
                            chatController.messageController.text =
                                aiSuggestions[index];
                          },
                        );
                      },
                    ),
                  ),
                ],
              )),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: WispColors.grey, width: 0.5),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _ActionButton(
                icon: Icons.emoji_emotions_outlined,
                onPressed: () {
                  setState(() {
                    _emojiShowing = !_emojiShowing;
                  });
                },
              ),
              _ActionButton(
                icon: Icons.attach_file,
                onPressed: () {},
              ),
              Expanded(
                child: _MessageInputField(
                  messageController: chatController.messageController,
                ),
              ),
              _ActionButton(
                icon: Icons.bolt_outlined,
                color: Colors.yellow,
                onPressed: () {
                  setState(() {
                    _isAi = !_isAi;
                  });
                },
              ),
              _SendButton(),
            ],
          ),
        ),
        if (_emojiShowing)
          SizedBox(
            height: 250,
            child: EmojiPicker(
              textEditingController: chatController.messageController,
            ),
          ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;

  const _ActionButton({
    required this.icon,
    required this.onPressed,
    this.color = WispColors.lightSkyBlue,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: color,
      ),
    );
  }
}

class _MessageInputField extends StatelessWidget {
  final TextEditingController messageController;

  const _MessageInputField({
    required this.messageController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.2),
        border: Border.all(color: WispColors.grey, width: 0.5),
        borderRadius: BorderRadius.circular(24),
      ),
      child: TextField(
        minLines: 1,
        maxLines: 5,
        controller: messageController,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: const InputDecoration(
          hintMaxLines: 1,
          hintText: '메시지를 입력하세요',
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          hintStyle: TextStyle(
            color: WispColors.lightSkyBlue,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _SendButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatController = ref.watch(chatControllerProvider.notifier);

    return IconButton(
      onPressed: () {
        chatController.sendMessage();
      },
      icon: const Icon(
        Icons.send,
        color: WispColors.lightSkyBlue,
      ),
    );
  }
}
