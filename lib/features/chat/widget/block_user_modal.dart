import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/button.dart';
import '../../../core/colors.dart';
import '../../../core/models/chats_model.dart';
import '../../../core/size_boxes.dart';
import '../../profile/presentation/views/report_user.dart';
import '../controllers/chat_ctr.dart';

class BlockUserModal extends StatefulWidget {
  final ChatModel chatModel;
  const BlockUserModal({super.key, required this.chatModel});

  @override
  State<BlockUserModal> createState() => _BlockUserModalState();
}

class _BlockUserModalState extends State<BlockUserModal> {
  var clickedBlocked = false;
  var ctr = ChatCtr.instance;

  @override
  Widget build(BuildContext context) {
    final isIBlockedUser = ctr.exploreCtr.myProfile.value.blocked
            ?.contains(widget.chatModel.userModel?.id) ??
        false;

    return SizedBox(
      height: Get.height / 4,
      child: Column(
        children: [
          ListTile(
            title: const Text("Report User"),
            leading: const Icon(Icons.info),
            onTap: () {
              Get.to(() => ReportUser(userModel: widget.chatModel.userModel!));
            },
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) {
              final offsetAnimation = Tween<Offset>(
                begin: const Offset(0, 0.4),
                end: Offset.zero,
              ).animate(animation);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
            child: clickedBlocked
                ? Padding(
                    key: ValueKey<bool>(clickedBlocked),
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            onPressed: () {
                              ctr.blockUnblockAUser(
                                  widget.chatModel.userModel!.id,
                                  isIBlockedUser);
                            },
                            text: isIBlockedUser
                                ? "Unblock now"
                                : "Confirm Block User",
                          ),
                        ),
                        const SizedBoxW15(),
                        Expanded(
                          child: CustomButton(
                            onPressed: () {
                              setState(() {
                                clickedBlocked = !clickedBlocked;
                              });
                            },
                            text: "Cancel",
                            bgColor: altoGrey,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListTile(
                    key: ValueKey<bool>(clickedBlocked),
                    title: Text(
                      isIBlockedUser ? "Unblock this user" : "Block this User",
                      style: const TextStyle(color: red),
                    ),
                    leading: const Icon(Icons.dangerous, color: red),
                    onTap: () {
                      setState(() {
                        clickedBlocked = !clickedBlocked;
                      });
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
