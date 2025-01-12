import 'package:glassfy_flutter/glassfy_flutter.dart';
import 'package:glassfy_flutter/models.dart';
import 'package:purchases_flutter/purchases_flutter.dart';


class SubscriptionService {
  ///API
  static const _apiKey = 'goog_mjvhTsGNNSzgnXyRVrIGjCmXwol';


  static Future<void> init() async {
   // await Glassfy.initialize(_apiKey, watcherMode: false);
  await Purchases.configure(PurchasesConfiguration(_apiKey));
  }



  ///GooglePay

static Future<CustomerInfo?> purchasePackage(Package package) async {
  try {
    final result = await Purchases.purchasePackage(package);
    return result;
  } catch (e) {
    return null;
  }
  }
  }
