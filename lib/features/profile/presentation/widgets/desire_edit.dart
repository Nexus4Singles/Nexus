import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../../core/button.dart';
import '../../../../core/colors.dart';
import '../../../../core/size_boxes.dart';
import '../../../../core/style.dart';
import '../../../../core/utils/toast.dart';
import '../../../auth/data/data-sources/local-datasource/list_items.dart';
import '../../../auth/presentation/widgets/hobbie_card.dart';
import '../../../home/controllers/home_controller.dart';
import '../../../home/presentation/change_notifier/home_notifier.dart';
import '../controllers/profile_ctr.dart';

class DesireEdit extends StatefulWidget {
  const DesireEdit({super.key});

  @override
  State<DesireEdit> createState() => _DesireEditState();
}

class _DesireEditState extends State<DesireEdit> {
  List<String> selectedDesires = [];

  @override
  void initState() {
    var currentUser = HomeController.instance.user.value;
    selectedDesires.assignAll(currentUser.desiredQualities!);
    super.initState();
  }

  var ctr = Get.put(ProfileCtr());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size(0, 50),
        child: Container(
          decoration: const BoxDecoration(color: white),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Edit Desired Qualities",
                    style: textStyle18.copyWith(fontWeight: FontWeight.bold)),
                InkWell(
                  child: const Icon(Icons.close),
                  onTap: () {
                    Get.back();
                  },
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: CustomButton(
          onPressed: () async {
            await ctr.updateQualities(selectedDesires, () async {
              await Provider.of<HomeNotifier>(context, listen: false)
                  .getProfile();
            });
          },
          text: "Update",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBoxH40(),
              Wrap(
                runSpacing: 10,
                spacing: 10,
                children: List.generate(
                  LocalData().desireQualities.length,
                  (index) => HobbieCard(
                    text: LocalData().desireQualities[index],
                    isChecked: selectedDesires.contains(
                      LocalData().desireQualities[index],
                    ),
                    onPress: () {
                      if (selectedDesires
                          .contains(LocalData().desireQualities[index])) {
                        setState(() {
                          selectedDesires
                              .remove(LocalData().desireQualities[index]);
                        });
                      } else {
                        if (selectedDesires.length == 8) {
                          return AppToast()
                              .showErrorToast('Maximum of 8 qualities');
                        }
                        setState(() {
                          selectedDesires.add(
                            LocalData().desireQualities[index],
                          );
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBoxH40(),
            ],
          ),
        ),
      ),
    );
  }
}
