import 'package:flutter/material.dart';

import 'colors.dart';

class LineDivider extends StatelessWidget {
  final bool isDark;
  const LineDivider({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Divider(color: isDark ? grey.withOpacity(.05) : grey);
  }
}
