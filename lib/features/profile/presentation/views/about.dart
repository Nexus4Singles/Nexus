import 'package:flutter/material.dart';

import '../../../../core/colors.dart';
import '../../../../core/style.dart';

class AboutNexusScreen extends StatefulWidget {
  const AboutNexusScreen({super.key});

  @override
  State<AboutNexusScreen> createState() => _AboutNexusScreenState();
}

class _AboutNexusScreenState extends State<AboutNexusScreen> {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              Text(
                "Nexus is more than just another Christian dating app; it is an intentional movement to see more godly marriages exist in God’s kingdom. \n\nThis platform is exclusively for singles who do not just view Christianity as the religion they identify with, but those who actually have a relationship with God. \n\nYour profile outlook plays a key role in determining how effective you find this app. If you're someone who has invested in overall self development, particularly spiritually, mentally & physically, the chances that you will find your person within a short time are really high.\n\nOur goal is not to match-make single Christians, but to leverage technology to create a centralized platform that offers greater visibility for Christian singles, who are seeking serious relationships leading to marriage. This would increase their chances of connecting to their future spouses, of course, with the help of the Holy Spirit for discernment & guidance.\n\nNexus does not get involved in the dealings or engagement between users. Our responsibility is to provide the visibility required to establish the connection between two parties through technology. Hence, it is still your responsibility as a user to determine who you give access to, based on their profile.\n\nNevertheless, we are committed to ensuring this is not just another random Dating App where anyone can join and that is why we introduced the audio recordings to help you filter who you decide to connect with based on their responses to the questions asked.\n\nWe have ensured that the questions require responses that are highly subjective and personal, which makes it quite unnecessary for users to seek external help to answer them. This is to provide an extra layer of authenticity to profiles being viewed, and to help users understand the beliefs and thought processes of other users.\n\nWe believe that users should be able to distinguish between genuine and rehearsed responses to the questions asked, in order to determine who to connect with. However, we highly recommend having extensive discussions with matched users and not being in a hurry to exchange personal contacts with any user. We would not be responsible for emotional damages done to anyone on this platform.\n\nNevertheless, we have designed block and report user features to help you guard yourself from anyone who is discovered to be toxic or manipulative. Hence, we will not hesitate to remove any user who is reported to have the intent of “playing games” with other users, once we have sufficient evidence.\n\nWe are starting with Nigerians and will gradually scale to other nationalities all over the world.\n\nJoin us on this journey of ours to see more kingdom marriages exist across the world. Tell someone about Nexus today!",
                style: textStyle14.copyWith(
                    height: 1.5, color: black, fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ),
    );
  }
}
