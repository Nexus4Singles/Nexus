import 'dart:io';

import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionService {
  ///API
  static const _apiKey = 'goog_mjvhTsGNNSzgnXyRVrIGjCmXwol';

  static const _appUserID = 'appl_dfjYQwnRsUjojfOSnYGqciVcGzx';

  static Future<void> init() async {
    await Purchases.configure(PurchasesConfiguration(_apiKey));

    await Purchases.setLogLevel(LogLevel.debug);

    PurchasesConfiguration configuration;

    if (Platform.isAndroid) {
      configuration = PurchasesConfiguration(_apiKey);
    } else if (Platform.isIOS) {
      configuration =
          PurchasesConfiguration(_appUserID);
      await Purchases.configure(configuration);
    }
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
