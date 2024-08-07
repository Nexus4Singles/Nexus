import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:Nexus/core/models/notification_model.dart';
import 'package:Nexus/core/services/notifications_service.dart';
import 'package:Nexus/core/utils/app_logger.dart';
import 'package:Nexus/features/home/controllers/home_controller.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

class NotificationController extends GetxController {
  static NotificationController get instance =>
      Get.find<NotificationController>();
  final NotificationsService apiService = NotificationsService();

  @override
  void onReady() {
    super.onReady();
    print("ON INIT RANGER");
    getAllNotifications();
  }

  RxBool isLoading = false.obs;
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  var homeController = HomeController.instance;

  void getAllNotifications() async {
    isLoading.value = true;
    try {
      List<NotificationModel> result =
          await apiService.getAllNotifications(homeController.user.value.id);
      notifications.value = result;
      appLog("Notifications fetched successfully!", result);
    } catch (error) {
      appLog("Failed to fetch notifications", error);
      // Get.snackbar("Error", "Failed to fetch notifications: $error");
    } finally {
      isLoading.value = false;
    }
  }

  void sendLikeNotification(String recipientId) async {
    await apiService.likeNotification(
      recipientId,
      onSuccess: (response) {
        appLog("Like notification sent successfully!", response);
      },
      onError: (error) {
        appLog("Failed to send like notification", error);
      },
    );
  }

  void sendMessageNotification(
      String recipientId, String messageContent, String messageType) async {
    await apiService.messageNotification(
      recipientId,
      messageContent,
      messageType,
      onSuccess: (response) {
        appLog("Message notification sent successfully!", response);
      },
      onError: (error) {

        appLog("Failed to send message notification", error);
      },
    );
  }

  void sendMatchNotification(String recipientId) async {
    await apiService.matchNotification(
      recipientId,
      onSuccess: (response) {
        appLog("Match notification sent successfully!", response);
      },
      onError: (error) {
        appLog("Failed to send match notification", error);
      },
    );
  }

  Map<String, List<NotificationModel>> get groupedNotifications {
    Map<String, List<NotificationModel>> grouped = {};

    for (var notification in notifications) {
      String date = DateFormat('yyyy-MM-dd')
          .format(notification.createdAt ?? DateTime.now());
      if (grouped[date] == null) {
        grouped[date] = [];
      }
      grouped[date]!.add(notification);
    }

    return grouped;
  }

  String getDisplayDate(String date) {
    if (date == DateFormat('yyyy-MM-dd').format(DateTime.now())) {
      return 'Today';
    } else if (date ==
        DateFormat('yyyy-MM-dd')
            .format(DateTime.now().subtract(const Duration(days: 1)))) {
      return 'Yesterday';
    } else {
      return DateFormat('MMMM dd, yyyy').format(DateTime.parse(date));
    }
  }
}
