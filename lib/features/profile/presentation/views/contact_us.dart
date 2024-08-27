import 'package:flutter/material.dart';

import '../../../../core/colors.dart';
import '../../../../core/style.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          'Contact Us',
          style: textStyle18.copyWith(
              fontSize: 24, fontWeight: FontWeight.w700, color: black),
        ),
        centerTitle: true,
        foregroundColor: black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text.rich(TextSpan(children: [
              const TextSpan(
                  text:
                      "If you do meet the love of your life on this platform, please do not keep the good news from us, as we would like to congratulate you as well. Kindly send an email to us on "),
              TextSpan(
                text: "contact@nexus4singles.com ",
                style: textStyle14.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(
                text:
                    "preferably with pictures of your engagement or wedding ceremony.\n\n",
              ),
              const TextSpan(
                text:
                    "You can also reach out to us for any inquiries or complaints on the email above, or send us a DM on Instagram or Twitter @nexus4singles.",
              ),
            ], style: textStyle14.copyWith(height: 1.8)))
          ],
        ),
      ),
    );
  }
}
