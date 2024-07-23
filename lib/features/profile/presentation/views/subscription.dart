import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nexus/api/payment.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/features/profile/presentation/views/payment_success.dart';
import 'package:nexus/features/profile/presentation/widgets/pay.dart';
import 'package:nexus/features/profile/presentation/widgets/utils.dart';

class SubsciptionScreen extends StatefulWidget {
  const SubsciptionScreen({super.key});

  @override
  State<SubsciptionScreen> createState() => _SubsciptionScreenState();
}

class _SubsciptionScreenState extends State<SubsciptionScreen> {
  @override
  Widget build(BuildContext context) {
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
            Text(
              'The free version of Nexus provides unlimited access to most features. However, some features have been made premium. We incur some monthly costs to ensure your profiles and audio recordings are securely stored and accessible to users. Hence, we are charging a small subscription fee to access premium features. This is to ensure we are able to maintain our services to you. ',
              style: textStyle12.copyWith(
                fontSize: 11.sp,
                color: black,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 10.h),
            _buildPlanContainer(
              title: 'Free',
              features: [
                'Unlimited Access to Search & View Profiles',
                'Unlimited Access to Like Profiles',
                'Unlimited Access to View Profiles You Liked',
                'Unlimited Access to View Who Liked Your Profile',
                'Unlimited Access to View Compatibility Data',
                'Limited Access to Chat with Matched Users (1 User)',
              ],
            ),
            SizedBox(height: 10.h),
            _buildPlanContainer(
              title: 'Premium',
              features: [
                'Unlimited Messaging',
                'Save Profiles to View Later',
                'Backtrack if you mistakenly swiped left',
                'Access to Advanced Filters on Explore Page',
              ],
              onSelectPlan: () async {
                final offerings = await PurchaseApi.fetchOffers();
                final offer = offerings.singleWhere(
                    (offerings) => offerings.offeringId == 'Subscription');
                if (!mounted) return;

                Utils.showSheet(
                  context,
                  (context) => PayWallWidget(
                    title: 'Upgrade Your Plan',
                    description: 'Upgrade to a new plan to enjoy more benefits',
                    offer: offer,
                    onClickedSku: (sku) async {
                      final transaction = await PurchaseApi.purchaseSku(sku);
                      if (!mounted) return;
                      if (transaction != null) {
                        final permissions = transaction.permissions!.all!;
                        final permission = permissions.firstWhere(
                            (permission) =>
                                permission.permissionId == 'premium');
                        if (permission.isValid!) {
                          // final provider = context.read<GlassfyProvider>();
                          // provider.isPremium = true;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const PaymentSuccessScreen(),
                            ),
                          );
                        }
                      }
                      // Navigator.of(context).pop();
                    },
                  ),
                );
              },
            ),
            // SizedBox(height: 10.h),
            // _buildPlanContainer(
            //   title: '\$12/3 months',
            //   features: [
            //     'Unlimited Messaging',
            //     'Save Profiles to View Later',
            //     'Backtrack if you mistakenly swiped left',
            //     'Access to Advanced Filters on Explore Page',
            //   ],
            //   onSelectPlan: () => _showPaymentBottomSheet(context, 12),
            // ),
          ],
        ),
      ),
    );
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
                onPressed: onSelectPlan,
                child: const Text(
                  'Select Plan',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
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
