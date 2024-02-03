import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/router.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          'Payment Methods',
          style: textStyle18.copyWith(
              fontSize: 24, fontWeight: FontWeight.w700, color: black),
        ),
        centerTitle: true,
        foregroundColor: black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Credit & Debit Card',
                style: textStyle10.copyWith(
                    fontWeight: FontWeight.w600, color: ash),
              ),
              SizedBoxH10(),
              Row(
                children: [
                  Image.asset('assets/images/smallcard.png'),
                  SizedBoxW10(),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.addcard);
                    },
                    child: Text(
                      'Add New Card',
                      style: textStyle16.copyWith(
                          fontWeight: FontWeight.w700, color: black),
                    ),
                  )
                ],
              ),
              SizedBoxH30(),
              Text(
                'More Payment Options',
                style: textStyle10.copyWith(
                    fontWeight: FontWeight.w600, color: ash),
              ),
              Container(
                decoration: BoxDecoration(
                  color: grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                  children: [
                    Image.asset('assets/images/paypal.png'),
                    SizedBoxW10(),
                    Text(
                      'Paypal',
                      style: textStyle16.copyWith(
                          fontWeight: FontWeight.w700, color: black),
                    ),
                  ],
                ),
              ),
              Divider(
                color: white,
              ),
              Container(
                decoration: BoxDecoration(
                  color: grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                  children: [
                    Image.asset('assets/images/apple.png'),
                    SizedBoxW10(),
                    Text(
                      'Apple pay',
                      style: textStyle16.copyWith(
                          fontWeight: FontWeight.w700, color: black),
                    ),
                  ],
                ),
              ),
              Divider(
                color: white,
              ),
              Container(
                decoration: BoxDecoration(
                  color: grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                  children: [
                    Image.asset('assets/images/google.png'),
                    SizedBoxW10(),
                    Text(
                      'Google pay',
                      style: textStyle16.copyWith(
                          fontWeight: FontWeight.w700, color: black),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
