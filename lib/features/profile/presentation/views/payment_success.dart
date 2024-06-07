import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
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
          Text(
            'You have successfully subscribed  to a  plan.',
            style: textStyle18.copyWith(
                fontSize: 12, fontWeight: FontWeight.w300, color: black),
          ),
          const SizedBox(
            height: 20,
          ),
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
