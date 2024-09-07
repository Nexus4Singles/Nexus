import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Nexus/core/button.dart';
import 'package:Nexus/core/button_outline.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/core/utils/modals.dart';
import 'package:Nexus/features/auth/data/data-sources/local-datasource/list_items.dart';
import 'package:Nexus/features/auth/presentation/widgets/drop_down.dart';
import 'package:provider/provider.dart';
import '../../../subscription/provider/subscription_provider.dart';
import '../../../subscription/widgets/restriction_modal.dart';
import '../../controllers/explore_ctr.dart';

class ExploreFilterModal extends StatefulWidget {
  const ExploreFilterModal({super.key});

  @override
  State<ExploreFilterModal> createState() => _ExploreFilterModalState();
}

class _ExploreFilterModalState extends State<ExploreFilterModal> {
  String state = '';
  String eduLevel = '';
  String church = '';

  final ctr = Get.put(ExploreCtr());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.sp),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Filters',
                style: textStyle16.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBoxH15(),
            AbsorbPointer(
              child: ProfileDropDown(
                items: [],
                val: "",
                hintText: 'Nationality (Coming Soon)',
                onChanged: (p0) {},
              ),
            ),
            const SizedBoxH15(),
            ProfileDropDown(
              items: LocalData().educationalLevels,
              val: ctr.education.value,
              hintText: 'Education Level',
              onChanged: (p0) {
                ctr.education.value = p0!;
              },
            ),
            const SizedBoxH15(),
            ProfileDropDown(
              items: LocalData().church,
              val: ctr.church.value,
              hintText: 'Church',
              onChanged: (p0) {
                ctr.church.value = p0!;
              },
            ),
            const SizedBoxH20(),
            Text(
              'Age Range',
              style: textStyle16.copyWith(color: dustyGrey),
            ),
            const SizedBoxH10(),
            Row(
              children: [
                Text(
                  '21',
                  style: textStyle16.copyWith(color: black),
                ),
                Obx(
                  () => Expanded(
                    child: RangeSlider(
                      min: 20,
                      max: 70,
                      inactiveColor: primary.withOpacity(0.2),
                      divisions: 10,
                      activeColor: primary,
                      values: ctr.rangeValues.value,
                      labels: RangeLabels(
                          ctr.rangeValues.value.start.round().toString(),
                          ctr.rangeValues.value.end.round().toString()),
                      onChanged: (value) {
                        ctr.rangeValues.value = value;
                      },
                    ),
                  ),
                ),
                Text(
                  '70',
                  style: textStyle16.copyWith(color: black),
                ),
              ],
            ),
            const SizedBoxH20(),
            Row(
              children: [
                Expanded(
                  child: CustomButtonOut(
                    onPressed: () {
                      ctr.resetFilter();
                    },
                    text: 'Reset Filter',
                  ),
                ),
                const SizedBoxW10(),
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      final provider = context.read<SubscriptionProvider>();
                      if (provider.onPremium == true) {
                        if(provider.isRestricted == true)
                        {
                          restrictionModal(context: context, showButton: false, text: 'Your subscription entitlements have been restricted.\nPlease'
                              ' log in to the associated Play Store or App Store account.\nRestart the app then head to Settings -> '
                              'Your Subscription -> Restore Subscription.');
                        } else {
                          ctr.filterUsers();
                        }
                      } else {
                        restrictionModal(text: 'This is a premium feature. The free version of Nexus allows you to search by City & Country of Residence. '
                            'Subscribing gives you access to use advanced filters to narrow down your search.', context: context);


                    }
                    },
                    text: 'Apply',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
