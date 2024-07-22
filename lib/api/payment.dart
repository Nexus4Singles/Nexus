import 'package:glassfy_flutter/glassfy_flutter.dart';
import 'package:glassfy_flutter/models.dart';
import 'package:logger/logger.dart';

class PurchaseApi {
  static const _apiKey = '434a5b97db0e45f5b4dd4ddccf3cc9c2';

  static Future<void> init() async {
    await Glassfy.initialize(_apiKey, watcherMode: false);
  }

  static Future<List<GlassfyOffering>> fetchOffers() async {
    try {
      final offerings = await Glassfy.offerings();
      return offerings.all ?? [];
    } on Exception catch (e) {
      Logger().e(e);
      return [];
    }
  }

  static Future<GlassfyTransaction?> purchaseSku(GlassfySku sku) async {
    try {
      return await Glassfy.purchaseSku(sku);
    } catch (e) {
      return null;
    }
  }

  static Future<bool> verifySubscriptionStatus() async {
    bool isSubscribed = false;
    try {
      var permission = await Glassfy.permissions();
      permission.all?.forEach(
        (p) {
          if (p.permissionId == "premium" && p.isValid == true) {
            // unlock aFeature
            isSubscribed = true;
          }
        },
      );
      return isSubscribed;
    } catch (e) {
      // initialization error
      rethrow;
    }
  }
}
