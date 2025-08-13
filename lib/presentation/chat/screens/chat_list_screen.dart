import 'package:flutter/material.dart';
import 'package:wisp/presentation/chat/widgets/chat_list_item.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {


    List<String> chatList = [
      '황지훈',
      '김민수',
      '이영희',
      '박철수',
      '최지우',
      '정우성',
      '한가인',
      '이병헌',
      '송중기',
      '김태희'
    ];

    List<String> lastMessageList = [
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

    return Center(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
            return ChatListItem(
              chatName: chatList[index],
              lastMessage: lastMessageList[index],
              isOnline: true,
              lastMessageTime: DateTime.now(),
              avatarUrl: '',
              chatId: '', 
              unreadMessageCount: 3,
            );
          },
        ));
  }
}
