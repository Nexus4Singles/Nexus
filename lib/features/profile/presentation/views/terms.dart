import 'package:flutter/material.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/style.dart';

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
          'About Nexus',
          style: textStyle18.copyWith(
              fontSize: 24, fontWeight: FontWeight.w700, color: black),
        ),
        centerTitle: true,
        foregroundColor: black,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Text(
              'Nexus does not get involved in the dealings or \nengagement between users. Our responsibility  is to\n provide the visibility required to establish the \nconnection between two parties through technology. \n\nHence, it is still your responsibility as a user to \ndetermine who you give access to, based on their \nprofile.\n\n Nevertheless, we are committed to ensuring this is not \njust another random Dating App where anyone can \njoin and that is why we introduced the audio\n recordings to help you filter who you decide to \nconnect with based on their responses to the questions asked.\nWe have ensured that the questions being asked \nrequire responses that are highly subjective and \npersonal, which makes it quite unnecessary for users \nto seek external help to answer them.\n\nWe highly recommend having extensive discussions \nwith matched users here and not being  in a hurry to \nexchange personal contacts with any user. We would \nnot be responsible for emotional damages done to anyone on this platform.\n\nWe will  also not hesitate to remove any user who has \nbeen discovered to have the intent of “playing games”\n with other users. As time goes on , we will be adding \na block and report feature to allow users block or \nreport any user discovered to be manipulative.',
              style: textStyle14.copyWith(
                  height: 1.5, color: black, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
