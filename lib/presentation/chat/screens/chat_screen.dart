import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wisp/core/config/constants/base_scaffold.dart';
import 'package:wisp/core/config/constants/colors.dart';

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
      '새로운 음악 추천해 주세요.',
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

// 메시지 리스트를 별도 위젯으로 분리
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
          const SizedBox(width: 8),
          const _UserAvatar(),
          const SizedBox(width: 12),
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

// AppBar의 뒤로가기 버튼
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

// 사용자 아바타
class _UserAvatar extends StatelessWidget {
  const _UserAvatar();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 20,
      backgroundColor: Colors.white,
      // api 연결시 받아올 예정
      child: Icon(
        Icons.person,
        color: WispColors.deepBlue1,
      ),
    );
  }
}

// 사용자 정보 (이름, 온라인 상태)
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

// 온라인 상태 표시
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

// AppBar의 더보기 버튼
class _MoreButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // TODO: 더보기 메뉴 구현
      },
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
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
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
      color: isMe ? null : WispColors.deepBlue1.withOpacity(0.1),
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

// 메시지 하단 정보 (시간, 읽음 표시)
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
          '오후 12:30', // 시간은 API로부터 받아올 예정
          style: TextStyle(
            fontSize: 12,
            color: isMe ? Colors.white70 : Colors.white54,
          ),
        ),
        if (isMe && isRead) ...[
          const SizedBox(width: 5),
          const Icon(
            Icons.check,
            size: 16,
            color: Colors.greenAccent,
          ),
        ],
      ],
    );
  }
}

class ChatTextField extends StatelessWidget {
  const ChatTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              // TODO: 이모지 피커 구현
            },
          ),
          const SizedBox(width: 8),
          _ActionButton(
            icon: Icons.attach_file,
            onPressed: () {
              // TODO: 파일 첨부 구현
            },
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _MessageInputField(),
          ),
          const SizedBox(width: 8),
          _ActionButton(
            icon: Icons.bolt_outlined,
            color: Colors.yellow,
            onPressed: () {
              // TODO: 특수 기능 구현
            },
          ),
          const SizedBox(width: 8),
          _SendButton(),
        ],
      ),
    );
  }
}

// 액션 버튼 (이모지, 첨부파일, 특수기능)
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

// 메시지 입력 필드
class _MessageInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        border: Border.all(color: WispColors.grey, width: 0.5),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const TextField(
        minLines: 1,
        maxLines: 5,
        decoration: InputDecoration(
          hintText: '메시지를 입력하세요',
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          hintStyle: TextStyle(
            color: WispColors.lightSkyBlue,
          ),
        ),
      ),
    );
  }
}

// 전송 버튼
class _SendButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // TODO: 메시지 전송 구현
      },
      icon: const Icon(
        Icons.send,
        color: WispColors.lightSkyBlue,
      ),
    );
  }
}