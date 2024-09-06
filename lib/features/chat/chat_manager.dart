/*
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatManager {
  static const String _activeChatUserIdKey = 'activeChatUserId';
  // Save the active chat user ID to SharedPreferences
  static Future<void> openChat(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_activeChatUserIdKey, userId);
    final usrId =  prefs.getString(_activeChatUserIdKey);
    logger.i('ChatManager: Active chat user ID set to: $usrId');
  }

  // Clear the active chat user ID in SharedPreferences
  static Future<void> closeChat() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_activeChatUserIdKey, '');
    logger.i('ChatManager: Active chat user ID cleared');
  }

  // Get the active chat user ID from SharedPreferences
  static Future<String?> getActiveChatUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final usrId =  prefs.getString(_activeChatUserIdKey);
    logger.i('current chatting usrId = $usrId');
    return usrId;
  }
}
*/
