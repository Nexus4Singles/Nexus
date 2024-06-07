import 'package:flutter/material.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/style.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Text(
                'Nexus is more than just another Christian dating app; it is an intentional movement to see more godly marriages exist in God’s kingdom. \n\nThis platform is strictly exclusive to Christian singles who do not only see Christianity as a religion but actually have a genuine relationship with God. \n\nOur goal is not to match-make single Christians, but to leverage technology to create a centralized platform that offers greater visibility for Christian singles worldwide, who are seeking serious relationships leading to marriage. This would increase their chances of connecting to their future spouses, of course, with the help of the Holy Spirit for discernment & guidance.\n\nWe are starting with Nigerians and will gradually scale to other nationalities.\n\nJoin us on this journey of ours to see more kingdom marriages exist across the world. Tell someone about Nexus today!',
                style: textStyle16.copyWith(
                    height: 1.5, color: black, fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ),
    );
  }
}
