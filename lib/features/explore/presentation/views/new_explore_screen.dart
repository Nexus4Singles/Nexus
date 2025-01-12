import 'package:Nexus/core/button.dart';
import 'package:Nexus/core/button_outline.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/core/text_field.dart';
import 'package:Nexus/features/auth/data/data-sources/local-datasource/list_items.dart';
import 'package:Nexus/features/auth/presentation/widgets/drop_down.dart';
import 'package:Nexus/features/explore/controllers/explore_ctr.dart';
import 'package:Nexus/features/subscription/provider/subscription_provider.dart';
import 'package:Nexus/features/subscription/widgets/restriction_modal.dart';
import 'package:Nexus/router.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class NewExploreScreen extends StatefulWidget {
  const NewExploreScreen({
    super.key,
  });

  @override
  State<NewExploreScreen> createState() => _NewExploreScreenState();
}

class _NewExploreScreenState extends State<NewExploreScreen> {
  final ctr = Get.put(ExploreCtr());

  @override
  void initState() {
    ctr.searchedUsers.clear();
    ctr.filteredUsers.clear();
    ctr.exploreError.value = '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void handleSearchUsers(SubscriptionProvider provider) {
      // UNCOMMENT THIS TO ENABLE PREMIUM_ONLY USERS TO FILTER
      if (provider.isRestricted == true) {
        restrictionModal(
          context: context,
          showButton: false,
          text: 'Your subscription entitlements have been restricted.\nPlease'
              ' log in to the account that is linked to your Play Store or App Store account.\nRestart the app, then head to Settings -> '
              'Your Subscription -> Restore Subscription.',
        );

        return;
      }

      ctr.filterUsers();
      Get.toNamed(AppRoutes.exploreResults);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const SizedBox.shrink(),
        title: Text(
          'Explore',
          style: textStyle18.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 100.0,
        ),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Stay in control of profiles you see, by using the advanced filters below to get more desired results',
                style: textStyle14.copyWith(
                  color: const Color(0xffa7a9b7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBoxH30(),
              Center(
                child: Text(
                  'What are you looking for?',
                  style: textStyle14.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBoxH20(),
              Text(
                'Age Range',
                style: textStyle16.copyWith(
                  color: dustyGrey,
                ),
              ),
              const SizedBoxH10(),
              Row(
                children: [
                  Text(
                    '21',
                    style: textStyle16.copyWith(
                      color: black,
                    ),
                  ),
                  Obx(
                    () => Expanded(
                      child: RangeSlider(
                        min: 20,
                        max: 70,
                        inactiveColor: primary.withOpacity(0.2),
                        divisions: 10,
                        activeColor: primary,
                        values: ctr.rangeValues.value,
                        labels: RangeLabels(
                          ctr.rangeValues.value.start.round().toString(),
                          ctr.rangeValues.value.end.round().toString(),
                        ),
                        onChanged: (value) {
                          ctr.rangeValues.value = value;
                        },
                      ),
                    ),
                  ),
                  Text(
                    '70',
                    style: textStyle16.copyWith(color: black),
                  ),
                ],
              ),
              const SizedBoxH15(),
              InkWell(
                onTap: () {
                  showCountryPicker(
                    countryListTheme: CountryListThemeData(
                        textStyle: textStyle14,
                        inputDecoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50))),
                        borderRadius: BorderRadius.circular(24)),
                    context: context,
                    showPhoneCode: false,
                    onSelect: (Country country) {
                      ctr.country.value = country.name;
                    },
                  );
                },
                child: CustomTextField(
                  enabled: false,
                  fillColor: white,
                  suffixIcon: const Icon(Icons.arrow_drop_down_outlined),
                  radius: 12,
                  controller: TextEditingController(text: ctr.country.value),
                  hintText: "Country of Residence",
                ),
              ),
              const SizedBoxH15(),
              ProfileDropDown(
                items: LocalData().educationLevelFilters,
                val: ctr.education.value,
                hintText: 'Education Level',
                onChanged: (p0) {
                  ctr.education.value = p0!;
                },
              ),
              const SizedBoxH15(),
              ProfileDropDown(
                items: LocalData().incomeSourceFilters,
                val: ctr.incomeSource.value,
                hintText: 'Has Source(s) of Income',
                onChanged: (p0) {
                  ctr.incomeSource.value = p0!;
                },
              ),
              const SizedBoxH15(),
              ProfileDropDown(
                items: LocalData().relationshipDistanceFilters,
                val: ctr.relationshipLongDistancePreference.value,
                hintText: 'Open to Long Distance',
                onChanged: (p0) {
                  ctr.relationshipLongDistancePreference.value = p0!;
                },
              ),
              const SizedBoxH15(),
              ProfileDropDown(
                items: LocalData().maritalStatusFilters,
                val: ctr.maritalStatus.value,
                hintText: 'Marital Status',
                onChanged: (p0) {
                  ctr.maritalStatus.value = p0!;
                },
              ),
              const SizedBoxH15(),
              ProfileDropDown(
                items: LocalData().hasKidsFilters,
                val: ctr.hasKids.value,
                hintText: 'Kids',
                onChanged: (p0) {
                  ctr.hasKids.value = p0!;
                },
              ),
              const SizedBoxH15(),
              ProfileDropDown(
                items: LocalData().genotypeFilters,
                val: ctr.genotype.value,
                hintText: 'Genotype',
                onChanged: (p0) {
                  ctr.genotype.value = p0!;
                },
              ),
              const SizedBoxH20(),
              Row(
                children: [
                  Expanded(
                    child: CustomButtonOut(
                      onPressed: () {
                        ctr.resetFilter();
                      },
                      text: 'Reset Filter',
                    ),
                  ),
                  const SizedBoxW10(),
                  Expanded(
                    child: Consumer<SubscriptionProvider>(
                        builder: (context, provider, child) {
                      return CustomButton(
                        onPressed: () => handleSearchUsers(provider),
                        text: 'Search',
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
