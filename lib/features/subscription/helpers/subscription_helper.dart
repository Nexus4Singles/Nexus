import 'dart:developer';

import 'package:Nexus/core/di/injection_container.config.dart';
import 'package:Nexus/core/utils/helper.dart';
import 'package:Nexus/features/subscription/widgets/restriction_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glassfy_flutter/glassfy_flutter.dart';
import 'package:glassfy_flutter/models.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import '../../../core/models/user.dart';
import '../../../main.dart';
import '../../../router.dart';
import '../../home/controllers/home_controller.dart';
import '../provider/subscription_provider.dart';
import '../services/subscription_service.dart';
import '../views/acknowledgment.dart';
import '../widgets/pay_wall_widget.dart';

class SubscriptionHelper {
  ///Store-Pay
  static Future<void> onSubscribe(BuildContext context) async {
    try {
      // Fetch offerings from RevenueCat
      final offerings = await Purchases.getOfferings();
      // Access the "Premium" offering
      final offering = offerings.getOffering("Premium");

      if (context.mounted && offering != null) {
        showModalBottomSheet(
          useRootNavigator: true,
          isDismissible: true,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          context: context,
          builder: (context) {
            return Consumer<SubscriptionProvider>(
              builder: (context, subProvider, child) {
                return PayWallWidget(
                  title: 'Upgrade Your Plan',
                  description: 'Upgrade to a new plan to enjoy more benefits',
                  offering: offering,
                  onClickedPackage: (package) async {
                    subProvider.isLoading = true;
                    final customerInfo =
                        await SubscriptionService.purchasePackage(package);

                    if (!context.mounted) {
                      subProvider.isLoading = false;
                      return;
                    }
                    if (customerInfo != null &&
                        customerInfo.entitlements.all["premium"]?.isActive ==
                            true) {
                      subProvider.onPremium = true;
                      final rawExpiration = customerInfo
                          .entitlements.all["premium"]?.expirationDate;
                      if (rawExpiration != null) {
                        final expireDate = DateTime.parse(rawExpiration);
                        final formattedDate =
                            DateFormat('dd/MM/yyyy').format(expireDate);
                        subProvider.subExpDate = formattedDate;
                      }
                      subProvider.subExpDate = rawExpiration;
                      final subscriberId =
                          customerInfo.originalAppUserId ?? 'null';
                      logger.i('this is subscriber id: $subscriberId');

                      voidUpdateProvider(subProvider, true, true, rawExpiration,
                          subscriberId, 'null');
                      await updateSubBackend(subProvider.currentUser, true,
                          true, rawExpiration, subscriberId, context);

                      subProvider.isLoading = false;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AcknowledgmentScreen(),
                        ),
                      ).then((_) => Get.offAllNamed('/'));
                    } else {
                      subProvider.isLoading = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Unsuccessful'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                );
              },
            );
          },
        );
      }
    } catch (e) {
      logger.e(e);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error occurred check Internet connection.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  // static Future<bool> onValidateSubscription(BuildContext context) async {
  //   var subProvider = Provider.of<SubscriptionProvider>(context, listen: false);
  //   final homeCtr = HomeController.instance;
  //   final user = homeCtr.user.value;
  //   final DateTime currentDate = DateTime.now();

  //   logger.i('user is ${user.username}, ${user.age}');
  //   logger.i('this is subId from Firebase: ${user.subscriberId}');

  //   var subId = await getSubscriberId() ?? 'null';
  //   subProvider.subscriberId = subId;
  //   logger.i('this is subId from Store: ${user.subscriberId}');

  //   bool subValid = false;

  //   if (subProvider.onPremium == false &&
  //       subProvider.prevSubscribed == true &&
  //       subProvider.usedOneFreeText == true) {
  //     await updateEntitledUserStatus(user, 'null', context);
  //     subProvider.entitledUser = 'null';
  //   }

  //   DateTime? expiryDateOfCurrentSubscription = DateFormat(
  //     'dd/MM/yyyy',
  //   ).tryParse(
  //     user.subExpDate ?? '',
  //   );

  //   //validate sub
  //   subValid = await validateSub(context, user);

  //   if (user.hasExternalSubscriptionFlow == true &&
  //       expiryDateOfCurrentSubscription != null) {
  //     subValid = currentDate.isBefore(expiryDateOfCurrentSubscription);
  //   }

  //   subProvider.onPremium = subValid;
  //   await updateBackendPremiumStatus(user, subValid, context);
  //   subProvider.initSubDet(HomeController.instance.user.value);
  //   return subValid;

  //   /*if (subscriberId != 'null') {
  //     if (subscriberId == subId) {
  //       subProvider.isRestricted = false;
  //       //validate sub
  //       subValid = await validateSub(context, subProvider, user);
  //       subProvider.onPremium = subValid;
  //       await updateBackendPremiumStatus(user, subValid, context);
  //     }
  //     else {

  //       logger.e(
  //           'Access Restricted: User not signed in subscribed app distro account');
  //       subProvider.isRestricted = true;
  //       restrictionModal(context: context,
  //           dismisable: true,
  //           showButton: false,
  //           text: 'Your subscription entitlements have been restricted.\nYour '
  //               'device is already linked to an active subscription. To subscribe with a different Nexus account, kindly login to your Google Play/Apple ID account that has no active Nexus subscription &\n Relaunch the App -> '
  //               'Your Subscription -> Restore Subscription.');
  //     }
  //   }

  //   if (subscriberId == 'null') {
  //     logger.i('not signed up yet, new user with free text');
  //     subProvider.isRestricted = false;
  //     await updateBackendPremiumStatus(user, subValid, context);
  //     subProvider.onPremium = false;
  //   }*/
  // }

  static Future<bool> onValidateSubscription(BuildContext context) async {
    var subProvider = Provider.of<SubscriptionProvider>(context, listen: false);
    final homeCtr = HomeController.instance;
    final user = homeCtr.user.value;
    final DateTime currentDate = DateTime.now();

    logger.i('user is ${user.username}, ${user.age}');
    logger.i('this is subId from Firebase: ${user.subscriberId}');

    final customerInfo = await Purchases.getCustomerInfo();
    final subId = customerInfo.originalAppUserId ?? 'null';
    subProvider.subscriberId = subId;
    logger.i('this is subId from RevenueCat: $subId');

    bool subValid = false;

    if (!subProvider.onPremium &&
        subProvider.prevSubscribed &&
        subProvider.usedOneFreeText) {
      await updateEntitledUserStatus(user, 'null', context);
      subProvider.entitledUser = 'null';
    }

    DateTime? expiryDateOfCurrentSubscription =
        DateFormat('dd/MM/yyyy').tryParse(user.subExpDate ?? '');

    // Validate subscription with RevenueCat
    if (customerInfo.entitlements.all["premium"]?.isActive == true) {
      subValid = true;
    }

    if (user.hasExternalSubscriptionFlow == true &&
        expiryDateOfCurrentSubscription != null) {
      subValid = currentDate.isBefore(expiryDateOfCurrentSubscription);
    }

    subProvider.onPremium = subValid;
    await updateBackendPremiumStatus(user, subValid, context);
    subProvider.initSubDet(HomeController.instance.user.value);
    return subValid;
  }

  static Future<void> updateSubBackend(
    UserModel? user,
    bool onP,
    bool prevSub,
    String? subExp,
    String? subscriberId,
    BuildContext context,
  ) async {
    if (user == null) return;

    DocumentReference userDoc =
        FirebaseFirestore.instance.collection('users').doc(user.id);

    Map<String, dynamic> data = {
      'onPremium': onP,
      'prevSubscribed': prevSub,
      'subExpDate': subExp,
      'subscriberId': subscriberId,
      'entitledUser': 'null',
      'usedOneFreeText': true,
    };

    try {
      await userDoc.update(data);
    } catch (e) {
      logger.e(e);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  // static Future<void> updateSubBackend(UserModel? user, bool onP, bool prevSub,
  //     String? subExp, String? subscriberId, BuildContext context) async {
  //   if (user == null) {
  //     return;
  //   }
  //   DocumentReference userDoc =
  //       FirebaseFirestore.instance.collection('users').doc(user.id);

  //   // Data to update
  //   Map<String, dynamic> data = {
  //     'onPremium': onP,
  //     'prevSubscribed': prevSub,
  //     'subExpDate': subExp,
  //     'subscriberId': subscriberId,
  //     'entitledUser': 'null',
  //     'usedOneFreeText': true,
  //   };

  //   try {
  //     await userDoc.update(data);
  //   } catch (e) {
  //     logger.e(e);
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(e.toString()),
  //           duration: const Duration(seconds: 2),
  //         ),
  //       );
  //     }
  //   }
  // }

  // static void voidUpdateProvider(SubscriptionProvider sp, bool onP,
  //     bool prevSub, String? subExp, String? subscriberId,
  //     [String? entitledUser]) {
  //   sp.onPremium = onP;
  //   sp.prevSubscribed = prevSub;
  //   sp.subExpDate = subExp;
  //   sp.entitledUser = entitledUser;
  //   sp.subscriberId = subscriberId;
  // }

  // static Future<void> updateBackendPremiumStatus(
  //     UserModel? user, bool onP, BuildContext context) async {
  //   if (user == null) {
  //     return;
  //   }

  //   DocumentReference userDoc =
  //       FirebaseFirestore.instance.collection('users').doc(user.id);

  //   // Data to update
  //   Map<String, dynamic> data = {'onPremium': onP};

  //   try {
  //     await userDoc.update(data);
  //   } catch (e) {
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(e.toString()),
  //           duration: const Duration(seconds: 2),
  //         ),
  //       );
  //     }
  //   }
  // }

  static void voidUpdateProvider(
    SubscriptionProvider sp,
    bool onP,
    bool prevSub,
    String? subExp,
    String? subscriberId, [
    String? entitledUser,
  ]) {
    sp.onPremium = onP;
    sp.prevSubscribed = prevSub;
    sp.subExpDate = subExp;
    sp.entitledUser = entitledUser;
    sp.subscriberId = subscriberId;
  }

  static Future<void> updateBackendPremiumStatus(
      UserModel? user, bool onP, BuildContext context) async {
    if (user == null) return;

    DocumentReference userDoc =
        FirebaseFirestore.instance.collection('users').doc(user.id);

    Map<String, dynamic> data = {'onPremium': onP, 'prevSubscribed': onP};

    try {
      await userDoc.update(data);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  static Future<void> updateFreeTextStatus(UserModel? user, bool usedFreeText,
      BuildContext context, String? entitledUser) async {
    if (user == null) {
      return;
    }
    DocumentReference userDoc =
        FirebaseFirestore.instance.collection('users').doc(user.id);
    // Data to update
    Map<String, dynamic> data = {
      'usedOneFreeText': usedFreeText,
      'entitledUser': entitledUser
    };

    try {
      await userDoc.update(data);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  // static Future<void> updateEntitledUserStatus(
  //     UserModel? user, String? entitledUser, BuildContext context) async {
  //   if (user == null) {
  //     return;
  //   }
  //   DocumentReference userDoc =
  //       FirebaseFirestore.instance.collection('users').doc(user.id);
  //   // Data to update
  //   Map<String, dynamic> data = {
  //     'entitledUser': entitledUser,
  //   };

  //   try {
  //     await userDoc.update(data);
  //   } catch (e) {
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(e.toString()),
  //           duration: const Duration(seconds: 2),
  //         ),
  //       );
  //     }
  //   }
  // }

  static Future<void> updateEntitledUserStatus(
      UserModel? user, String? entitledUser, BuildContext context) async {
    if (user == null) return;

    DocumentReference userDoc =
        FirebaseFirestore.instance.collection('users').doc(user.id);

    Map<String, dynamic> data = {
      'entitledUser': entitledUser,
    };

    try {
      await userDoc.update(data);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  // static Future<String?> getSubscriberId() async {
  //   String? subscriberId;
  //   try {
  //     var permissions = await Glassfy.permissions();
  //     subscriberId = permissions.subscriberId;
  //   } catch (e) {
  //     logger.e(e);
  //   }
  //   return subscriberId;
  // }
  static Future<String?> getSubscriberId() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      return customerInfo.originalAppUserId;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  static Future<bool> validateSub(BuildContext context, UserModel user) async {
    try {
      var subProvider =
          Provider.of<SubscriptionProvider>(context, listen: false);
      var permissions = await Glassfy.permissions();
      permissions.all?.forEach((p) async {
        if (p.permissionId == "premium" && p.isValid == true) {
          subProvider.onPremium = true;
          logger.i('subscription valid');
        } else {
          logger.e('subscription no longer valid');
          subProvider.onPremium = false;
          logger.i(subProvider.onPremium);
        }
      });
      return subProvider.onPremium;
    } catch (e) {
      logger.e(e.toString());
      // BaseHelper.showSnackBar('Error validating subscription status');
      return false;
    }
  }

  static Future<void> restoreSubscriptionEntitlement(
    BuildContext context,
    SubscriptionProvider subProvider,
  ) async {
    try {
      // Restore purchases
      final customerInfo = await Purchases.restorePurchases();

      // Print the entire customerInfo for debugging purposes
      print("Customer Info: $customerInfo");

      // Retrieve the 'premium' entitlement from the returned info
      final premiumEntitlement = customerInfo.entitlements.all["premium"];

      // Check if premiumEntitlement is active
      if (premiumEntitlement == null || !premiumEntitlement.isActive) {
        // No active subscription found
        logger.i("You currently do not have an active premium plan");
        if (context.mounted) {
          BaseHelper.showSnackBar("No active subscription found");
        }
      } else {
        // We have an active subscription
        logger.i("Subscription Entitlements restored. Please Restart App!");
        if (context.mounted) {
          BaseHelper.showSnackBar(
              "Subscription Entitlements restored. Please restart the app!");
        }
      }
    } catch (error) {
      // Catch and log any errors during restore
      logger.e("Failed to restore Subscription Entitlements $error");
      if (context.mounted) {
        BaseHelper.showSnackBar("Failed to restore subscription Entitlements");
      }
    }
  }

  // static Future<void> restoreSubscriptionEntitlement(
  //     BuildContext context, SubscriptionProvider subProvider) async {
  //   try {
  //     final customerInfo = await Purchases.restorePurchases();
  //     final entitlement = customerInfo.entitlements.all["premium"];
  //     print(customerInfo);
  //     print(entitlement?.isActive);
  //     if (entitlement?.isActive == true && context.mounted) {
  //       logger.i('Subscription Entitlements restored. Please Restart App!');
  //     } else if (context.mounted) {
  //       logger.i('You currently do not have an active premium plan');
  //       BaseHelper.showSnackBar('Subscription Entitlements restored.');
  //       return;
  //     }
  //     // Get.offAllNamed('/');
  //     BaseHelper.showSnackBar('Subscription Entitlements restored.');
  //   } catch (error) {
  //     logger.e("Failed to restore Subscription Entitlements $error");
  //     if (context.mounted) {
  //       BaseHelper.showSnackBar('Failed to restore subscription Entitlements');
  //     }
  //   }
  // }

  // static Future<void> restoreSubscriptionEntitlement(
  //     BuildContext context, SubscriptionProvider subProvider) async {
  //   try {
  //     // if(subProvider.isRestricted  == false){
  //     var permissions = await Glassfy.restorePurchases();
  //     for (var p in permissions.all ?? []) {
  //       logger.i("${p.permissionId} is ${p.isValid}");
  //       if (p.isValid == true) {
  //         if (context.mounted) {
  //           logger.i(
  //             'Subscription Entitlements restored.Please Restart App!',
  //           );
  //         }
  //       } else {
  //         if (context.mounted) {
  //           logger.i(
  //             'You currently do not have an active premium plan',
  //           );
  //         }
  //       }
  //       Get.offAllNamed('/');
  //       BaseHelper.showSnackBar(
  //         'Subscription Entitlements restored.',
  //       );
  //     }
  //     //}
  //     /* else {
  //       BaseHelper.showSnackBar(
  //         'Please sign into the Google Play Store or Apple ID associated with your subscription.',
  //       );
  //     }*/
  //   } catch (error) {
  //     logger.e("Failed to restore Subscription Entitlements $error");
  //     if (context.mounted) {
  //       BaseHelper.showSnackBar('Failed to restore subscription Entitlements');
  //     }
  //   }
  // }
}
