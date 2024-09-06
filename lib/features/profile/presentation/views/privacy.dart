import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/features/profile/presentation/widgets/privacy_item.dart';

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
                'At Nexus, we are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy outlines how we collect, use, and safeguard your data when you use our app. By accessing or using nexus, you agree to the terms outlined in this policy.',
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
                title: 'User Experience:',
                desc:
                    'Your profile information is visible to only opposite gender users on the platform, which is also used to recommend suitable profiles who share your Christian values and interests.',
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
                'User Rights',
                style: textStyle14.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBoxH10(),
              const PrivacyItem(
                title: 'Consent:',
                desc:
                    'By signing up on the app, users provide consent for the collection and processing of their personal data. Users ​have the right to withdraw their consent at any time by deleting their account.',
              ),
              const SizedBoxH10(),
              const PrivacyItem(
                title: 'Data Retention:',
                desc:
                    'We retain user data only for as long as necessary for the purposes outlined in this policy. Users can request ​the deletion of their data when they deactivate their account.',
              ),
              const SizedBoxH10(),
              const PrivacyItem(
                title: 'User Rights:',
                desc:
                    'Users have the right to access, rectify, or erase their personal data. They can exercise these rights through ​in-app settings or by contacting us.',
              ),
              const SizedBoxH20(),
              Text(
                'Data Movement:',
                style: textStyle14.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBoxH10(),
              const PrivacyItem(
                title: 'International Data Transfers:',
                desc:
                    'If we transfer user data outside the European Economic Area (EEA), we ensure an adequate level of protection for the data ​through standard contractual clauses or binding corporate rules.',
              ),
              const SizedBoxH10(),
              const PrivacyItem(
                title: 'Data Breach Notification:',
                desc:
                    'We have procedures in place for detecting, investigating, and notifying users of data breaches in compliance with GDPR\'s requirement for timely notification of breaches.',
              ),
               const SizedBoxH10(),
              const PrivacyItem(
                title: 'Cookies and Tracking Technologies:',
                desc:
                    'Nexus doesnt use any cookies or tracking technologies to track user data. However, if this changes in the future, it shall be disclosed to all users.',
                    ),
              const SizedBoxH10(),
              const PrivacyItem(
                title: 'Account Deletion:',
                desc:
                    'To delete your account, just sign in to the app with your login credentials and click on settings. Accept the prompt to delete ​your account and your account and all of its data will be deleted.',
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
