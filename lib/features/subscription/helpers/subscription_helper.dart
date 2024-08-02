import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glassfy_flutter/glassfy_flutter.dart';
import 'package:glassfy_flutter/models.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import '../../../core/models/user.dart';
import '../provider/subscription_provider.dart';
import '../services/subscription_service.dart';
import '../views/acknowledgment.dart';
import '../widgets/pay_wall_widget.dart';


class SubscriptionHelper {

  ///GooglePay
  static Future<void> onSubscribe(BuildContext context) async {
    try {
      final offerings = await Glassfy.offerings();

      final offer = offerings.all
      !.singleWhere((offering) => offering.offeringId == 'Premium');

      if (context.mounted) {
        showModalBottomSheet(
          useRootNavigator: true,
          isDismissible: true,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          context: context,
          builder: (context) =>
              PayWallWidget(
                title: 'Upgrade Your Plan',
                description: 'Upgrade to a new plan to enjoy more benefits',
                offer: offer,
                onClickedSku: (sku) async {
                  final transaction = await SubscriptionService.purchaseSku(
                      sku);
                  if (!context.mounted) return;

                  if (transaction != null) {
                    final permissions = transaction.permissions!.all!;
                    final permission = permissions.firstWhere(
                            (permission) =>
                        permission.permissionId == 'premium');
                      await checkPermission(permission, context);

                  }
                  //Navigator.of(context).pop();
                },
              ),
        );
      }
    } catch (e) {
      if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            duration: const Duration(
                seconds: 2),
          ),
        );
      }
    }
  }

  ///Permission-Check
  static Future<void> checkPermission(GlassfyPermission permission, BuildContext context) async {
    final subProvider = context.read<SubscriptionProvider>();
    if (permission.isValid!) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const AcknowledgmentScreen()));
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('dd/MM/yyyy').format(addOneMonth(now));
      voidUpdateProvider(subProvider, true, true, formattedDate);
      await updateSubBackend(subProvider.currentUser, true, true, formattedDate, context);
    } else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unsuccessful'),
          duration: Duration(
              seconds: 2),
        ),
      );
    }
  }

  ///Expiry-Date-Helper
  static bool isSubscriptionValid(BuildContext context, String? subExpDate) {
    if(subExpDate == null){
      return false;
    } else {

      var x = DateTime.now().isBefore(
          DateFormat('dd/MM/yyyy').parse(subExpDate));
      return x;
    }
  }


  static DateTime addOneMonth(DateTime date) {
    DateTime newDate = DateTime(date.year, date.month + 1, date.day);
    if (newDate.month != (date.month % 12) + 1) {
      newDate = DateTime(date.year, date.month + 2, 0);
      newDate = DateTime(newDate.year, newDate.month, date.day);
    }
    return newDate;
  }


  static Future<void> updateSubBackend(UserModel? user, bool onP, bool prevSub, String? subExp,BuildContext context) async {
    if (user == null) {
      return;
    }

    DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(user.id);

    // Data to update
    Map<String, dynamic> data = {
      'onPremium': onP,
      'prevSubscribed': prevSub,
      'subExpDate': subExp,
    };

    try {
      await userDoc.update(data);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            duration: const Duration(
                seconds: 2),
          ),
        );
      }
    }
  }

  static void voidUpdateProvider(SubscriptionProvider sp, bool onP, bool prevSub, String? subExp){
    sp.onPremium = onP;
    sp.prevSubscribed = prevSub;
    sp.subExpDate = subExp;
  }

  static Future<void> updateBackendPremiumStatus(UserModel? user, bool onP,BuildContext context) async {
    if (user == null) {
      return;
    }

    DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(user.id);

    // Data to update
    Map<String, dynamic> data = {
      'onPremium': onP
    };

    try {
      await userDoc.update(data);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            duration: const Duration(
                seconds: 2),
          ),
        );
      }
    }
  }

  static Future<void> updateFreeTextStatus(UserModel? user, bool usedFreeText,BuildContext context) async {
    if (user == null) {
      return;
    }

    DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(user.id);

    // Data to update
    Map<String, dynamic> data = {
      'usedOneFreeText': usedFreeText
    };

    try {
      await userDoc.update(data);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            duration: const Duration(
                seconds: 2),
          ),
        );
      }
    }
  }

}

