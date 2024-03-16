import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/text_field.dart';
import 'package:nexus/features/explore/presentation/widgets/filter_modal.dart';
import 'package:nexus/features/explore/presentation/widgets/user_tile.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.sp),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    prefixIcon: const Icon(
                      Iconsax.location5,
                      color: altoGrey,
                    ),
                    radius: 25.sp,
                    controller: TextEditingController(),
                    hintText: 'United Kingdom',
                    suffixIcon: Container(
                      margin: EdgeInsets.all(5.sp),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: primary,
                      ),
                      child: const Icon(
                        Iconsax.search_normal,
                        color: white,
                      ),
                    ),
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
                        return ExploreFilterModal();
                      },
                    );
                  },
                  child: const Icon(
                    Iconsax.setting_4,
                  ),
                ),
              ],
            ),
            const SizedBoxH15(),
            Column(
              children: [
                Text(
                  'Results',
                  style: textStyle18.copyWith(color: otherGrey),
                ),
                const SizedBoxH10(),
                ExploreUserTile(
                  name: 'Adelanke',
                  age: '27',
                  location: 'London, UK',
                  onPress: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
