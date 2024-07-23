import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nexus/api/payment.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/features/profile/presentation/views/subscription.dart';

class ChangePlanScreen extends StatefulWidget {
  const ChangePlanScreen({super.key});

  @override
  State<ChangePlanScreen> createState() => _ChangePlanScreenState();
}

class _ChangePlanScreenState extends State<ChangePlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          'Subscription',
          style: textStyle18.copyWith(
              fontSize: 24.sp, fontWeight: FontWeight.w700, color: black),
        ),
        centerTitle: true,
        foregroundColor: black,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: PurchaseApi.verifySubscriptionStatus(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            EasyLoading.show();
          }

          if (!snapshot.hasData) {
            return Container();
          }

          if (!snapshot.data!) {
            EasyLoading.dismiss();

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'You currently don\'t have any subscription',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    CustomButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const SubsciptionScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Subscribe',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (snapshot.data!) {
            EasyLoading.dismiss();

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 300.sp,
                      // height: 170.sp,
                      decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: const Column(
                        children: [
                          // Text(
                          //   'Basic',
                          //   style: textStyle18.copyWith(
                          //       color: white,
                          //       fontSize: 35.sp,
                          //       fontWeight: FontWeight.w600),
                          // ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Monthly Plan',
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),

                          SizedBoxH10(),

                          // Text(
                          //   'Your subscription will expire on',
                          //   style: textStyle18.copyWith(
                          //     color: white,
                          //     fontSize: 12.sp,
                          //     fontWeight: FontWeight.w400,
                          //   ),
                          // ),
                          // const SizedBoxH5(),

                          // Text(
                          //   '30th April, 2024',
                          //   style: textStyle12.copyWith(
                          //     fontWeight: FontWeight.bold,
                          //     color: white,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  // CustomButton(
                  //   onPressed: () {
                  //     Get.offAndToNamed(AppRoutes.subscription);
                  //   },
                  //   text: 'Change Plan',
                  // ),
                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
