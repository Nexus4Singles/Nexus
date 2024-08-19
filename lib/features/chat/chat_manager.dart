import 'package:flutter/cupertino.dart';

class ChatManager{
  static String? _activeChatUserId;

  static String? get activeChatUserId => _activeChatUserId;

  static void setActiveChatUserId(String? userId) {
    _activeChatUserId = userId;

  }

  static void openChat(String userId) {
    _activeChatUserId = userId;
  }

  static void closeChat() {
    _activeChatUserId = null;
  }
}
