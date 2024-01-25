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
      body:SingleChildScrollView(child:  Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Text(
              'Nexus is more than just another Christian\n dating app; it is an intentional movement to see\n more godly marriages exist in God’s kingdom.\n\nThis application is strictly exclusive to African\nsingles who are not just identifying with \nChristianity as a religion but have a relationship\n with God.\n\nThe goal is not to match-make single \nChristians, but to leverage technology to create\nmore visibility for Christians singles in Africa \nseeking serious relationships leading to \nmarriage. This would increase their chances of \nconnecting to their future spouses, of course, \nwith the help of the Holy Spirit for discernment.\n\nWe are starting from Nigeria and will gradually \nscale to some other African countries.\n\nJoin us on this journey of ours to see more \nkingdom marriages exist in Africa. Tell someone \nabout Nexus today!',
              style: textStyle16.copyWith(
                  height: 1.5, color: black, fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),),
    );
  }
}
