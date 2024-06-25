import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/text_field.dart';
import 'package:nexus/router.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          'Add card',
          style: textStyle18.copyWith(
              fontSize: 24.sp, fontWeight: FontWeight.w700, color: black),
        ),
        centerTitle: true,
        foregroundColor: black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
        child: Column(
          children: [
            Center(
              child: Image.asset('assets/images/atm.png'),
            ),
            const SizedBoxH30(),
            CustomTextField(
              controller: TextEditingController(),
              hintText: 'Card Holder Name',
            ),
            const Divider(
              color: white,
            ),
            CustomTextField(
              controller: TextEditingController(),
              hintText: 'Card Holder Name',
            ),
            const SizedBoxH20(),
            CustomTextField(
              controller: TextEditingController(),
              hintText: 'Country',
            ),
            const Row(
              children: [],
            ),
            const SizedBoxH30(),
            CustomButton(
              onPressed: () {
                Get.toNamed(AppRoutes.review);
              },
              child: Text(
                'Link card',
                style: textStyle16.copyWith(color: white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
