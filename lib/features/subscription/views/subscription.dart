import 'dart:io';
import 'dart:ui';
import 'package:Nexus/core/utils/helper.dart';
import 'package:Nexus/features/subscription/widgets/restriction_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Nexus/features/profile/presentation/change_notifier/settings_notifier.dart';
import 'package:Nexus/features/profile/presentation/constants/payment.dart';
import 'package:provider/provider.dart';
import 'package:Nexus/core/button.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/style.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import '../helpers/subscription_helper.dart';
import '../provider/subscription_provider.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer<SubscriptionProvider>(builder: (context, model, _) {
      return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          title: Text(
            'Subscription Plans',
            style: textStyle18.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: black,
            ),
          ),
          centerTitle: true,
          foregroundColor: black,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Text(
                'The free version of Nexus provides unlimited access to most features. However, some features have been made premium. We incur some monthly costs to ensure your profiles and audio recordings are securely stored and accessible to users. Hence, we are charging a small subscription fee to access premium features. This is to ensure we are able to maintain our services to you.\n\nIf you live in Nigeria, your Naira debit cards will not work for subscriptions. For more information about subscribing, follow us on Instagram @nexus4singles.',
                style: textStyle14.copyWith(
                  fontSize: 11.sp,
                  color: black,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 25.h),
              _buildPlanContainer(
                title: 'Free',
                features: [
                  'Unlimited Access to Search & View Profiles',
                  'Unlimited Access to Like Profiles',
                  'Unlimited Access to View Profiles You Liked',
                  'Unlimited Access to View Who Liked Your Profile',
                  'Access to Advanced Filters on Explore Page',
                  'Access to Compatibility Data of Matched Users',
                  'Limited Access to Chat with Matched Users (1 User)',
                ],
              ),
              SizedBox(height: 25.h),
              _buildPlanContainer(
                title: 'Premium',
                features: [
                  'Unlimited Messaging',
                  'Access to Compatibility Data on all Profiles',
                  'Save Profiles to View Later',
                ],
                onSelectPlan: () async {
                  model.subLoading = true;
                  try {
                    await _handleSubscribeAction(model);
                    model.subLoading = false;
                  } catch(error){
                    BaseHelper.showSnackBar('Error occurred while attempting to subscribe.');
                   logger.e(error);
                    model.subLoading = false;

                  }
                },
              ),
              SizedBox(height: 25.h),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: CustomButton(
                    onPressed: () async {
                      model.subLoading = true;
                      await SubscriptionHelper.restoreSubscriptionEntitlement(context, model);
                      model.subLoading = false;

                    },
                    child: const Text(
                      'Restore Subscription',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
              ),
              SizedBox(height: 10.h),
              if (model.isLoading ||  model.subLoading == true)
                const Center(child: CircularProgressIndicator(),
                ),

              /*SizedBox(height: 10.h),
                _buildPlanContainer(
                  title: '\$12/3 months',
                  features: [
                    'Unlimited Messaging',
                    'Save Profiles to View Later',
                    'Backtrack if you mistakenly swiped left',
                    'Access to Advanced Filters on Explore Page',
                  ],
                  onSelectPlan: () => _showPaymentBottomSheet(context, 12),
                ),*/
            ],
          ),
        ),
      );
    });
  }

  Widget _buildPlanContainer({
    required String title,
    required List<String> features,
    dynamic onSelectPlan,
  }) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: Color(0xffEAEAEA)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.all(16.sp),
        padding: EdgeInsets.all(10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title.split('/')[0],
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (title.contains('/'))
                  Text(
                    '/${title.split('/')[1]}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xffA7A7A7),
                    ),
                  ),
              ],
            ),
            ...features.map(
              (feature) => Text(
                feature,
                style: textStyle12.copyWith(
                  fontSize: 11.sp,
                  color: const Color(0xff575757),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (onSelectPlan != null)
              CustomButton(
                onPressed: () async {
                  await onSelectPlan();
                },
                child: const Text(
                  'Subscribe',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  _handleSubscribeAction(SubscriptionProvider subProvider) async {
   /* var currentSystemSubscriberId = await SubscriptionHelper.getSubscriberId();
    if(subProvider.onPremium == false && subProvider.isRestricted == true)
      {
        restrictionModal(context: context, dismisable: true, showButton: false, text: 'Please'
              ' log in or switch to the Google Account/Apple ID that is tied to your subscription.\n'
              'Head back here after restarting the app, click the \'Restore Subscription\' button, then try again.');

      } else if ( subProvider.currentUser?.subscriberId == 'null' && currentSystemSubscriberId != null)
        {
          restrictionModal(context: context, dismisable: true, showButton: false, text: 'Please'
              ' log in or switch to the Google Account/Apple ID that is NOT associated to a subscription.\n'
              'Head back here after restarting the app, click the\'Restore Subscription\' button, then try again.');
        }
    else */
    if(subProvider.onPremium == true){
      BaseHelper.showSnackBar ('You\'re on Premium!');
    }
    else {
      await SubscriptionHelper.onSubscribe(context);
    }
  }

}

class AppCircularProgressIndicator extends StatelessWidget {
  const AppCircularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.white),
      strokeWidth: 3,
    );
  }
}
