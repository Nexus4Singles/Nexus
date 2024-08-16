import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/features/profile/presentation/widgets/privacy_item.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          'Privacy Policy',
          style: textStyle18.copyWith(
              fontSize: 24, fontWeight: FontWeight.w700, color: black),
        ),
        centerTitle: true,
        foregroundColor: black,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Last Update : 04/12/2024',
                style: textStyle14.copyWith(
                    color: black, fontWeight: FontWeight.w600),
              ),
              const SizedBoxH20(),
              Text(
                'At nexus, we are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy outlines how we collect, use, and safeguard your data when you use our Christian dating app. By accessing or using nexus, you agree to the terms outlined in this policy.',
                style: textStyle14.copyWith(color: black),
              ),
              const SizedBoxH20(),
              Text(
                'Information We Collect:',
                style: textStyle14.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBoxH10(),
              const PrivacyItem(
                title: 'User Profile Information:',
                desc:
                    'We collect the information you provide when creating your profile, including your name, age, gender, denomination, and other details to enhance your dating experience.',
              ),
              const SizedBoxH10(),
              const PrivacyItem(
                title: 'Communication Data:',
                desc:
                    'To facilitate connections, we collect data related to your interactions on the app, such as messages, likes, and matches.',
              ),
              const SizedBoxH10(),
              const PrivacyItem(
                title: 'Device Information:',
                desc:
                    'We automatically collect information about the device you use to access the app, including the device type, operating system, and unique device identifiers.',
              ),
              const SizedBoxH20(),
              Text(
                'How We Use Your Information:',
                style: textStyle14.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBoxH10(),
              const PrivacyItem(
                title: 'Matchmaking and User Experience:',
                desc:
                    'Your profile information is used to match you with potential connections who share your Christian values and interests.',
              ),
              const SizedBoxH10(),
              const PrivacyItem(
                title: 'Communication:',
                desc:
                    'We use your communication data to facilitate interactions within the app, allowing users to connect and engage with each other.',
              ),
              const SizedBoxH10(),
              const PrivacyItem(
                title: 'App Improvement:',
                desc:
                    'Collected data helps us enhance and optimize our app, ensuring a user-friendly and secure environment.',
              ),
              const SizedBoxH20(),
              Text(
                'Data Security:',
                style: textStyle14.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBoxH10(),
              const PrivacyItem(
                title: 'Security Measures:',
                desc:
                    'We employ industry-standard security measures to protect your data from unauthorized access, disclosure, alteration, and destruction.',
              ),
              const SizedBoxH10(),
              const PrivacyItem(
                title: 'Encryption:',
                desc:
                    'All data transmitted between your device and our servers is encrypted to ensure the confidentiality of your information.',
              ),
              const SizedBoxH20(),
              Text(
                'Third-Party Services:',
                style: textStyle14.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBoxH10(),
              const PrivacyItem(
                title: 'External Links:',
                desc:
                    'Our app may contain links to third-party websites. Please note that we are not responsible for the privacy practices or content of these sites.',
              ),
              const SizedBoxH20(),
              Text(
                'Your Choices:',
                style: textStyle14.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBoxH10(),
              const PrivacyItem(
                title: 'Profile Settings:',
                desc:
                    'You have control over the information displayed on your profile. Adjust your settings to customize your privacy preferences.',
              ),
              const SizedBoxH10(),
              const PrivacyItem(
                title: 'Account Deactivation:',
                desc:
                    'If you choose to discontinue using , you can deactivate your account, and your data will be securely archived.',
              ),
              const SizedBoxH20(),
              Text(
                'Updates to Privacy Policy:',
                style: textStyle14.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBoxH10(),
              const PrivacyItem(
                title: 'Notification:',
                desc:
                    'We may update this Privacy Policy to reflect changes in our practices. Users will be notified of any significant updates.',
              ),
              const SizedBoxH30(),
            ],
          ),
        ),
      ),
    );
  }
}
