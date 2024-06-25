import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';

class SubCancelledScreen extends StatefulWidget {
  const SubCancelledScreen({super.key});

  @override
  State<SubCancelledScreen> createState() => _SubCancelledScreenState();
}

class _SubCancelledScreenState extends State<SubCancelledScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          'Subscription',
          style: textStyle18.copyWith(
              fontSize: 24, fontWeight: FontWeight.w700, color: black),
        ),
        centerTitle: true,
        foregroundColor: black,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 300.sp,
                height: 120.sp,
                decoration: BoxDecoration(
                    color: primary, borderRadius: BorderRadius.circular(15)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'you are back to the free version but\nyou wont be able to chat with new\nmatched users',
                        style: textStyle18.copyWith(
                            color: white, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBoxH20()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
