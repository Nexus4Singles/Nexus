import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Nexus/core/button.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:provider/provider.dart';

import '../../../../core/colors.dart';
import '../../../../core/utils/toast.dart';
import '../../../auth/data/data-sources/local-datasource/list_items.dart';
import '../../../auth/presentation/widgets/hobbie_card.dart';
import '../../../home/presentation/change_notifier/home_notifier.dart';
import '../controllers/profile_ctr.dart';

class HobbiesEdit extends StatefulWidget {
  const HobbiesEdit({super.key});

  @override
  State<HobbiesEdit> createState() => _HobbiesEditState();
}

class _HobbiesEditState extends State<HobbiesEdit> {
  List<String> selectedHobbies = [];

  @override
  void initState() {
    var currentUser =
        Provider.of<HomeNotifier>(context, listen: false).currentUser!;
    selectedHobbies.assignAll(currentUser.hobbies!);
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
                Text("Edit Hobbies",
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
          onPressed: () {
            ctr.updateHobbies(selectedHobbies, () async {
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
                  LocalData().hobbies.length,
                  (index) => HobbieCard(
                    text: LocalData().hobbies[index],
                    isChecked: selectedHobbies.contains(
                      LocalData().hobbies[index],
                    ),
                    onPress: () {
                      if (selectedHobbies
                          .contains(LocalData().hobbies[index])) {
                        setState(() {
                          selectedHobbies.remove(LocalData().hobbies[index]);
                        });
                      } else {
                        if (selectedHobbies.length == 5) {
                          return AppToast()
                              .showErrorToast('Maximum of 5 Hobbies/Interests');
                        }
                        setState(() {
                          selectedHobbies.add(
                            LocalData().hobbies[index],
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
