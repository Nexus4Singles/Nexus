import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/text_field.dart';
import 'package:nexus/features/explore/controllers/explore_ctr.dart';
import 'package:nexus/features/explore/presentation/widgets/filter_modal.dart';
import 'package:nexus/features/home/presentation/widgets/coming_soon_modal.dart';
import '../../../../core/utils/progress_indicator.dart';
import '../../../home/presentation/views/user_details.dart';
import '../widgets/user_tile.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  TextEditingController search = TextEditingController();

  final ctr = Get.put(ExploreCtr());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const SizedBox.shrink(),
        bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 50),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        InkWell(
                          onTap: () {
                            showCountryPicker(
                              countryListTheme: CountryListThemeData(
                                  textStyle: textStyle14,
                                  inputDecoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                  borderRadius: BorderRadius.circular(24)),
                              context: context,
                              showPhoneCode: false,
                              onSelect: (Country country) {
                                ctr.searchCountry(country.name);
                              },
                            );
                          },
                          child: CustomTextField(
                            prefixIcon:
                                const Icon(Iconsax.location5, color: altoGrey),
                            radius: 215.sp,
                            controller: search,
                            hintText: 'Search by Country of Residence',
                            enabled: false,
                            // suffixIcon:
                          ),
                        ),
                        Positioned(
                          right: 5,
                          child: InkWell(
                            onTap: () {
                              showModal(
                                  "You will be able to manually search profiles here as soon as we launch.");
                            },
                            child: Container(
                              padding: EdgeInsets.all(5.sp),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: primary,
                              ),
                              child: const Icon(
                                Icons.search_sharp,
                                color: white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBoxW10(),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.r),
                          ),
                        ),
                        showDragHandle: true,
                        builder: (context) {
                          return const ExploreFilterModal();
                        },
                      );
                      // showModal(
                      //   'You will be able to filter by Age, Church, Nationality & Education level as soon as we launch.',
                      // );
                    },
                    child: const Icon(
                      Iconsax.setting_4,
                    ),
                  ),
                ],
              ),
            )),
        title: Text(
          'Explore',
          style: textStyle18.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                ctr.isLoading.value
                    ? const Center(child: CustomCircularProgressIndicator())
                    : ctr.searchedUsers.isEmpty
                        ? SizedBox(
                            width: Get.width,
                            height: Get.height / 1.5,
                            child: Center(
                              child: Text(
                                'Stay in control of profiles you see! Use the explore feature to search for profiles and get more desired results using filters',
                                style: textStyle14.copyWith(
                                  color: black.withOpacity(.8),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              ...ctr.searchedUsers.map(
                                (val) => ExploreUserTile(
                                  image: val.photos![0],
                                  name: val.username,
                                  age: val.age.toString(),
                                  location: val.location!.place ?? "",
                                  onPress: () {
                                    Get.to(
                                        () => UserDetailScreen(userModel: val));
                                  },
                                ),
                              )
                            ],
                          ),
                const SizedBoxH40()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showModal(String text) {
    showAdaptiveDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog.adaptive(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: ComingSoonModal(text: text),
        );
      },
    );
  }
}
