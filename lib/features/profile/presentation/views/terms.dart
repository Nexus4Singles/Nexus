import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/style.dart';

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
            Text(
              'Last Update : 02/12/2023\n\nNexus does not get involved in the dealings or engagement between users. Our responsibility is to provide the visibility required to establish the connection between two parties through technology. Hence, it is still your responsibility as a user to determine who you give access to, based on their profile.\n\nNevertheless, we are committed to ensuring this is not just another random Dating App where anyone can join and that is why we introduced the audio recordings to help you filter who you decide to connect with based on their responses to the questions asked.\n\nWe have ensured that the questions require responses that are highly subjective and personal, which makes it quite unnecessary for users to seek external help to answer them. This is to provide an extra layer of authenticity to profiles being viewed, and to help users understand the beliefs and thought processes of other users.\n\nWe believe that users should be able to distinguish between genuine and rehearsed responses to the questions asked, in order to determine who to connect with. However, we highly recommend having extensive discussions with matched users and not being in a hurry to exchange personal contacts with any user. We would not be responsible for emotional damages done to anyone on this platform.\n\nNevertheless, we have designed a feature to help users report anyone who is discovered to be toxic or manipulative. Hence, we will not hesitate to remove any user who is reported to have the intent of “playing games” with other users, once we have sufficient evidence.',
              style: textStyle14.copyWith(
                  height: 1.5, color: black, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
