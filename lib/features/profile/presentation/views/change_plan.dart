import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:Nexus/core/button.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/features/subscription/views/subscription.dart';
import 'package:provider/provider.dart';

import '../../../subscription/provider/subscription_provider.dart';

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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Consumer<SubscriptionProvider>(
          builder: (context, subProvider, child) {
            return subProvider.onPremium
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 15),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Premium',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBoxH10(),
                      Text(
                        subProvider.subExpDate != null &&
                            DateTime.now().isBefore(DateFormat('dd/MM/yyyy')
                                .parse(subProvider.subExpDate!))
                            ? 'Your subscription expires on'
                            : 'Your subscription expires on ',
                        style: textStyle18.copyWith(
                          color: white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBoxH5(),
                      Text(
                        subProvider.subExpDate!,
                        style: textStyle12.copyWith(
                          fontWeight: FontWeight.bold,
                          color: white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'You currently don\'t have any subscription',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffa7a9b7),
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SubscriptionScreen(),
                      ),
                    );
                  },
                  text: 'Subscribe',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
