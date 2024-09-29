import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Nexus/features/subscription/views/subscription.dart';
import '../../../core/assets.dart';
import '../../../core/button.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure you import this for SVG support

void restrictionModal({
  required BuildContext context,
  bool dismisable = true,
  bool showButton = true,
  String text =
      'This is a premium feature.\nKindly subscribe to use this feature.',
}) {
  showDialog(
    context: context,
    barrierDismissible: dismisable,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column( // Changed from Wrap to Column
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.red, // Replace with your primary color
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Center(
                child: SvgPicture.asset(
                  "$svgPath/Empty.svg",
                  height: 100, // Adjust size as needed
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16.0),
              Center( // Centering the text
                child: Text(
                  text,
                  textAlign: TextAlign.center, // This ensures text is centered
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ),
              if (showButton)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: CustomButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SubscriptionScreen(),
                        ),
                      );
                    },
                    text: 'Subscribe',
                    borderRadius: 100,
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}
