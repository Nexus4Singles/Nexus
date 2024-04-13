import 'package:flutter/material.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/utils/device.dart';
import 'package:nexus/features/auth/presentation/change_notifier/auth_notifier.dart';
import 'package:provider/provider.dart';

class CountryModal extends StatefulWidget {
  // final AuthNotifier model;
  const CountryModal({
    super.key,
    // required this.model,
  });

  @override
  State<CountryModal> createState() => _CountryModalState();
}

class _CountryModalState extends State<CountryModal> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, model, _) {
      return SizedBox(
        width: width(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBoxH20(),
            InkWell(
              onTap: () {
                model.setCountry('Nigeria');
                Navigator.of(context).pop();
              },
              child: Container(
                width: width(context),
                padding: const EdgeInsets.all(15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:
                      model.country == 'Nigeria' ? primary : Colors.transparent,
                  border: Border.all(
                    color: model.country == 'Nigeria' ? white : iconGrey,
                    width: 0.1,
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                ),
                child: Text(
                  'Nigeria',
                  style: textStyle16.copyWith(
                    color: model.country == 'Nigeria' ? white : iconGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              width: width(context),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 0),
                  bottom: BorderSide(
                    color: iconGrey,
                    width: 0.1,
                  ),
                ),
              ),
              child: Text(
                'Ghana (Coming Soon)',
                style: textStyle16.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: iconGrey,
                ),
              ),
            ),
            Container(
              width: width(context),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 0),
                  bottom: BorderSide(
                    color: iconGrey,
                    width: 0.1,
                  ),
                ),
              ),
              child: Text(
                'Kenya (Coming Soon)',
                style: textStyle16.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: iconGrey,
                ),
              ),
            ),
            Container(
              width: width(context),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 0.5,
                    color: iconGrey,
                  ),
                ),
              ),
              child: Text(
                'South Africa (Coming Soon)',
                style: textStyle16.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: iconGrey,
                ),
              ),
            ),
            const SizedBoxH15(),
          ],
        ),
      );
    });
  }
}
