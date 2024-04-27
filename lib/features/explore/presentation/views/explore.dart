import 'package:country_picker/country_picker.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/text_field.dart';
import 'package:nexus/features/explore/presentation/widgets/filter_modal.dart';
// import 'package:nexus/features/explore/presentation/widgets/user_tile.dart';
// import 'package:nexus/features/home/presentation/widgets/coming_soon.dart';
import 'package:nexus/features/home/presentation/widgets/coming_soon_modal.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const SizedBox.shrink(),
        title: Text(
          'Explore',
          style: textStyle18.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // AnimatedOpacity(
          //   duration: const Duration(seconds: 1),
          //   opacity: .2,
          //   child:

          Padding(
            padding: EdgeInsets.all(15.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          InkWell(
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                showPhoneCode: false,
                                onSelect: (Country country) {
                                  setState(() {
                                    search.text = country.name;
                                  });
                                  // showModal();
                                  // print('Select country: ${country.displayName}');
                                },
                              );
                            },
                            child: CustomTextField(
                              prefixIcon: const Icon(
                                Iconsax.location5,
                                color: altoGrey,
                              ),
                              radius: 25.sp,
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
                        // showModalBottomSheet(
                        //   context: context,
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.vertical(
                        //       top: Radius.circular(25.r),
                        //     ),
                        //   ),
                        //   showDragHandle: true,
                        //   builder: (context) {
                        //     return const ExploreFilterModal();
                        //   },
                        // );
                        showModal(
                          'You will be able to filter by Age, Church, Nationality & Education level as soon as we launch.',
                        );
                      },
                      child: const Icon(
                        Iconsax.setting_4,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Center(
                      child: Text(
                        'Stay in control of profiles you see! Use the explore feature to search for profiles and get more desired results using filters',
                        style: textStyle14.copyWith(
                          color: black.withOpacity(.8),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                    // Text(
                    //   'Results',
                    //   style: textStyle18.copyWith(color: otherGrey),
                    // ),
                    // const SizedBoxH10(),
                    // ExploreUserTile(
                    //   name: 'Adelanke',
                    //   age: '27',
                    //   location: 'London, UK',
                    //   onPress: () {},
                    // ),
                  ],
                ),
                const SizedBoxH40(),
              ],
            ),
          ),
          // ),
          // const ComingSoonWidget(
          //     text:
          //         'You will be able to manually search profiles here as soon as we launch.')
        ],
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
