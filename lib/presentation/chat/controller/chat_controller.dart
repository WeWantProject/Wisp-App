import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatController extends StateNotifier<void> {
  ChatController() : super(0);

  final TextEditingController messageController = TextEditingController();

  void sendMessage() {
    final message = messageController.text;
    if (message.isNotEmpty) {
      print('Sending message: $message');
      messageController.clear(); // 메시지 전송 후 입력 필드 초기화
    }
  }
}

final chatControllerProvider =
    StateNotifierProvider<ChatController, void>((ref) {
  return ChatController();
});
