import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:pay/pay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsNotifier with ChangeNotifier {
  List<PaymentItem> getPaymentItems(double price) => <PaymentItem>[
        PaymentItem(
          label: 'Monthly Subscription',
          type: PaymentItemType.total,
          amount: '$price',
          status: PaymentItemStatus.final_price,
        ),
      ];

  void onGooglePayResult(paymentResult) {
    _updatePaymentStatus(paymentResult);
  }

  void onApplePayResult(paymentResult) {
    _updatePaymentStatus(paymentResult);
  }

  Future<void> _updatePaymentStatus(paymentResult) async {
    Logger().i("Trigger Payment update to backend");
    debugPrint(paymentResult.toString());

    // try {
    //   await FirebaseFirestore.instance.collection('users').doc('user_id').update({
    //     'subscriptionStatus': 'active',
    //     'paymentDetails': paymentResult,
    //   });
    //   notifyListeners();
    // } catch (e) {
    //   notifyListeners();
    // }
  }
}
