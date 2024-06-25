import 'package:flutter/material.dart';
import 'package:nexus/core/colors.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 32, // Default size, adjust as needed
      height: 32,
      child: CircularProgressIndicator.adaptive(
        strokeWidth: 1,
        valueColor: AlwaysStoppedAnimation<Color>(primary),
      ),
    );
  }
}
