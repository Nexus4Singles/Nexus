import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/router.dart';

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/congratulation.png'),
          Text(
            'Congratulations',
            style: textStyle18.copyWith(
                fontSize: 32, fontWeight: FontWeight.w700, color: black),
          ),
          const SizedBoxH5(),
          SizedBox(
            width: Get.width * 0.7,
            child: Column(
              children: [
                Text(
                  'Your subscription was successful!!!\nPlease allow a few minutes for your subscription to be activated.',
                  style: textStyle18.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: black,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text.rich(
                  TextSpan(
                    style: textStyle12.copyWith(
                      color: const Color(0xff1E1E1E),
                      height: 1.6,
                    ),
                    children: const [
                      TextSpan(
                        text: 'To check your subscription status, click on',
                      ),
                      TextSpan(
                        text: ' Your Subscription ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: 'under settings')
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.cancelPlan);
                },
                text: 'Go to Home',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
