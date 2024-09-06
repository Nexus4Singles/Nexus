import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:Nexus/features/subscription/views/subscription.dart';
import '../../../core/assets.dart';
import '../../../core/button.dart';
import '../../../core/colors.dart';
import '../../../core/style.dart';
import '../../../core/utils/empty_state.dart';

restrictionModal(
    {context,
    dismisable = true,
      showButton = true,
    text = 'This is a premium feature.\nSubscribe now to use this feature.'}) {
  showDialog(
    context: context,
    barrierDismissible: dismisable,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent ,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: Get.height*0.26),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24)
            ),
            padding: const EdgeInsets.only(left: 20.0, right: 12.0, bottom: 12.0, top: 12.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);

                      },
                      child: const Icon(
                        Icons.clear,
                        color: primary,
                      )),
                ),
               const Spacer(),
               // const SizedBox(height: 20,),
                SvgPicture.asset(
                  "$svgPath/Empty.svg",
                  height: 100, // Adjust size as needed
                  width: 100, fit: BoxFit.cover,
                ),
                const Spacer(),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: textStyle14.copyWith(color: dustyGrey),
                ),
                const Spacer(),
                showButton ?
                CustomButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SubscriptionScreen()),
                      );
                      },
                    text: 'Subscribe',
                    borderRadius: 100)
                : const SizedBox.shrink(),
                const Spacer(),

              ],
            )
          ),
        ),
      );
    },
  );
}
