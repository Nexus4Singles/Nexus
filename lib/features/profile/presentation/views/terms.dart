import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/colors.dart';
import '../../../../core/style.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          'Term of Use',
          style: textStyle18.copyWith(
              fontSize: 24, fontWeight: FontWeight.w700, color: black),
        ),
        centerTitle: true,
        foregroundColor: black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 15.sp,
          vertical: 15.sp,
        ),
        child: Column(
          children: [
            RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black), // default text style
                  children: [
                  TextSpan(
                  text: 'Last Update: 20/09/2024\n\nThe use of Nexus constitutes your consent to, and agreement to, abide by the most current version of these terms and conditions (the “Terms”). We may at any time revise these terms and conditions by updating the Terms. You agree to be bound ​by subsequent revisions and agree to review the Terms periodically for changes to the terms and conditions. The most up to ​date version of the Terms will always be available for your review under the “Terms of Use” link that appears at the bottom of the ​Platform.\n\n',
                ),
                TextSpan(
                  text: 'ELIGIBILITY OF MEMBERSHIP\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '- Use of the Platform is available only to persons who can form legally binding contracts under applicable law. If you are ​under the age of 21 years, you will not be allowed to use the Platform.\n',
                ),
                TextSpan(
                  text: '- Our Platform reserves the right to terminate your membership and refuse to provide you with access to the Platform if ​we discover that you are under the age of 21 years.\n',
                ),
                TextSpan(
                  text: '- The Platform is not available to persons whose membership has been ​suspended or terminated by us for any reason whatsoever. If you are registering as a business entity, you represent that ​you have the authority to bind the entity to this User Agreement.\n',
                ),
                TextSpan(
                  text: '- Except where additional terms and conditions are provided, these terms and conditions supersede all previous ​representations, understandings, or agreements and shall prevail notwithstanding any variance with any other terms of ​any order submitted. By using the services of our Platform you agree to be bound by the Terms and Conditions.\n\n',
                ),
                TextSpan(
                  text: 'REGISTRATION\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '- In order to avail yourself of our services, you are required to create an account with us.\n',
                ),
                TextSpan(
                  text: '- In order to register for an account with us (an “Account”) you need to provide certain personal information such as your ​username, email address, password, profile picture, profile information etc...\n',
                ),
                TextSpan(
                  text: '- You represent and warrant that all required registration information you submit is truthful and accurate, and you will maintain ​the accuracy of such information. You are responsible for maintaining the confidentiality of your Account login information ​and are fully responsible for all activities that occur under your Account. You agree to immediately notify us of any ​unauthorized use, or suspected unauthorized use of your Account or any other breach of security.\n',
                ),
                TextSpan(
                  text: '- Nexus cannot and will not be liable for any loss or damage arising from your failure to comply with the above requirements. ​You must not share your password or other access credentials with any other person or entity that is not authorized to ​access your account. Without limiting the foregoing, you are solely responsible for any activities or actions that occur under ​your Platform account access credentials. We encourage you to use a “strong” password (a password that includes a ​combination of upper and lower case letters, numbers, and symbols) with your account. We cannot and will not be liable for ​any loss or damage arising from your failure to comply with any of the above.\n',
                ),

                TextSpan(
                  text: 'SUBSCRIPTION SERVICES\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'Nexus is an online dating platform via which users after registering themselves and creating an account on the Platform can ​subscribe to the services of the Platform by choosing the subscription offerings listed on the Platform.\n',
                ),
                TextSpan(
                  text: 'The Platform does not offer refunds for the subscriptions once made by the Users.\n',
                ),
                TextSpan(
                  text: 'Please be aware that if you subscribe to services for a period (the “Initial Term”), then the terms of your subscription will be ​automatically renewed for additional periods of the same duration as the Initial Term on Nexus, then-current fee for such ​services, unless you cancel your subscription.\n',
                ),

                TextSpan(
                  text: 'YOUR RIGHTS AND LICENSE TO CONTENT\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '- You retain your rights to any Content you post or upload on our Platform. By posting or uploading Content using our ​Platform, you grant us a limited, perpetual, irrevocable, worldwide, non-exclusive, royalty-free, transferable license (with the ​right to sublicense) to use, copy, reproduce, process, adapt, modify, create derivative works of, transmit, host, display, and ​distribute such Content in any and all media or distribution methods (now known or later developed) as necessary to ​provide the Platform and in accordance with these Terms.\n',
                ),
                TextSpan(
                  text: '- You further agree that this license includes the right for us to modify or adapt your Content in order to transmit, display, or ​distribute it over mobile networks and in various media and/or make changes to your Content as are necessary to conform ​and adapt that Content to any requirements or limitations of any networks, devices, services, or media.\n',
                ),
                TextSpan(
                  text: 'You are solely responsible for your use of the Platform, for any content you provide, and for any consequences thereof, ​including, but not limited to, the use of your content by us. Without limiting the foregoing, you represent and warrant that ​you have all the rights, power, and authority necessary to grant the rights granted herein to any Content that you submit.\n',
                ),
                TextSpan(
                  text: 'In addition, so that the Platform can prevent the use of Your Content outside of our Services, you authorize the Company ​to act on your behalf with respect to infringing uses of Your Content taken from our Services by other users or third ​parties. This expressly includes the authority, but not the obligation, to send notices on your behalf if Your Content is taken ​and used by third parties outside of our Services.\n',
                ),
                TextSpan(
                  text: 'YOU AGREE AND CONFIRM\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '- That you will use the services provided by our Platform , its affiliates and contracted companies, for lawful purposes only ​and comply with all applicable laws and regulations while using the Platform and transacting on the Platform.\n',
                ),
                TextSpan(
                  text: '- You will provide authentic and true information in all instances where such information is requested of you. We reserve the ​right to confirm and validate the information and other details provided by you at any point of time. If upon confirmation ​your details are found not to be true (wholly or partly), we have the right in our sole discretion to reject the registration and ​debar you from using the Services of our Platform and / or other affiliated Platforms without prior intimation whatsoever.\n',
                ),
                TextSpan(
                  text: '- That you are accessing the services available on this Platform and transacting at your sole risk and are using your best and ​prudent judgment before entering into any transaction through this Platform. If upon confirmation ​your details are found not to be true (wholly or partly), we have the right in our sole discretion to reject the registration and ​debar you from using the Services of our Platform and / or other affiliated Platforms without prior intimation whatsoever.\n',
                ),
                TextSpan(
                  text: '- You shall at all times ensure full compliance with the applicable laws regarding your use of our service.\n',
                ),
                TextSpan(
                  text: 'YOU MAY NOT USE THIS PLATFORM FOR ANY OF THE FOLLOWING PURPOSES\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '- Disseminating any unlawful, harassing, libelous, abusive, threatening, harmful, vulgar, obscene, or otherwise objectionable material.\n',
                ),
                TextSpan(
                  text: '- Transmitting material that encourages conduct that constitutes a criminal offense, results in civil liability or otherwise breaches any ​relevant laws, regulations or code of practice.\n',
                ),
                TextSpan(
                  text: '- Interfering with any other person’s use or enjoyment of the Platform.\n',
                ),
                TextSpan(
                  text: '- Breaching any applicable laws;\n',
                ),
                TextSpan(
                  text: '- Interfering or disrupting networks or web sites connected to the Platform.\n',
                ),
                TextSpan(
                  text: '- Making, transmitting or storing electronic copies of materials protected by copyright without the permission of the owner.\n',
                ),
                TextSpan(
                  text: 'MODIFICATION OF TERMS & CONDITIONS OF SERVICES\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '- We may at any time modify the Terms & Conditions of Use of the Platform without any prior notification to you. You can access the ​latest version of the User Agreement at any given time on our Platform. You should regularly review the Terms & Conditions on our ​Platform. In the event the modified Terms & Conditions is not acceptable to you, you should discontinue using the service. However, ​if you continue to use the service you shall be deemed to have agreed to accept and abide by the modified Terms & Conditions of ​Use of this Platform.\n\n',
                ),
                TextSpan(
                  text: 'COPYRIGHT & TRADEMARK\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '- Nexus expressly reserve all intellectual property rights in all text, programs, products, ​processes, technology, content and other materials, which appear on this Platform. Access to this Platform does not confer ​and shall not be considered as conferring upon anyone any license under any of Nexus or any third party’s intellectual ​property rights. All rights, including copyright, in this Platform are owned by or licensed to us or third party suppliers. Any use ​of this Platform or its contents, including copying or storing it or them in whole or part, other than for your own personal, ​non-commercial use is prohibited without the permission of our Platform.\n\n',
                ),
                TextSpan(
                  text: '- You cannot modify, distribute or re-post anything on this Platform for any purpose.\n',
                ),
                TextSpan(
                  text: '- Nexus names and logos and all related product and service and our slogans are the trademarks or service marks of Nexus. All ​other marks are the property of their respective companies. No trademark or service mark license is granted in connection ​with the materials contained on this Platform. Access to this Platform does not authorize anyone to use any name, logo or ​mark in any manner.\n',
                ),
                TextSpan(
                  text: 'TERMINATION\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '- We may, at any time and without notice, suspend, cancel, or terminate your right to use the Platform (or any portion of the ​Platform). In the event of suspension, cancellation, or termination, you are no longer authorized to access the part of the ​Platform affected by such suspension, cancellation, or termination. In the event of any suspension, cancellation, or ​termination, the restrictions imposed on you with respect to material downloaded from the Platform and the disclaimers and ​limitations of liabilities set forth in the Agreement, shall survive.\n',
                ),
                TextSpan(
                    text: '- Without limiting the foregoing, we may close, suspend or limit your access to our Platform :'
                    '- if we determine that you have breached, or are acting in breach of, this Agreement;'
                '- if we determine that you have breached legal liabilities (actual or potential), including infringing someone else’s ​Intellectual Property Rights;'
            '- if we determine that you have engaged, or are engaging, in fraudulent, or illegal activities;'
            '- to manage any risk of loss to us, a User, or any other person; or'
            '- for other similar reasons.\n',
            ),
            TextSpan(
              text: '- If we find you breaching these terms of service, you may also become liable for an amount of which we have suffered ​losses/damages.\n',
            ),
          ],
        ),
      ),
      ],
    ),

    ),
    );
  }
}