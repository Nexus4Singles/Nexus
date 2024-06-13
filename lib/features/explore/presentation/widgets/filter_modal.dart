import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/button_outline.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/features/auth/data/data-sources/local-datasource/list_items.dart';
import 'package:nexus/features/auth/presentation/widgets/drop_down.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Filter',
              style: textStyle16.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBoxH15(),
          AbsorbPointer(
            child: ProfileDropDown(
              items: ["Nigeria"],
              val: "Nigeria",
              hintText: 'Nationality',
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
            style: textStyle16.copyWith(color: otherGrey),
          ),
          const SizedBoxH10(),
          Row(
            children: [
              Text(
                '21',
                style: textStyle16.copyWith(color: otherGrey),
              ),
              Obx(
                () => Expanded(
                  child: RangeSlider(
                    min: 20,
                    max: 70,
                    divisions: 50,
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
                style: textStyle16.copyWith(color: otherGrey),
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
                    ctr.filterUsers();
                  },
                  text: 'Apply',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
