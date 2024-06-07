import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/button_outline.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/features/auth/presentation/widgets/drop_down.dart';

class ExploreFilterModal extends StatefulWidget {
  const ExploreFilterModal({super.key});

  @override
  State<ExploreFilterModal> createState() => _ExploreFilterModalState();
}

class _ExploreFilterModalState extends State<ExploreFilterModal> {
  String state = '';
  String eduLevel = '';
  RangeValues rangeValues = const RangeValues(25, 40);

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
          ProfileDropDown(
            items: const [
              'Option1',
              'Option2',
              'Option3',
            ],
            val: state,
            hintText: 'State of Origin',
            onChanged: (p0) {
              setState(() {
                state = p0!;
              });
            },
          ),
          const SizedBoxH15(),
          ProfileDropDown(
            items: const [
              'Option1',
              'Option2',
              'Option3',
            ],
            val: eduLevel,
            hintText: 'Education Level',
            onChanged: (p0) {
              setState(() {
                eduLevel = p0!;
              });
            },
          ),
          const SizedBoxH20(),
          Text(
            'Age Range',
            style: textStyle16.copyWith(color: otherGrey),
          ),
          const SizedBoxH10(),
          RangeSlider(
            min: 21,
            max: 60,
            activeColor: primary,
            values: rangeValues,
            labels: const RangeLabels('21', '60'),
            onChanged: (value) {
              setState(() {
                rangeValues = value;
              });
            },
          ),
          const SizedBoxH20(),
          Row(
            children: [
              Expanded(
                child: CustomButtonOut(
                  onPressed: () {},
                  text: 'Reset Filter',
                ),
              ),
              const SizedBoxW10(),
              Expanded(
                child: CustomButton(
                  onPressed: () {},
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
