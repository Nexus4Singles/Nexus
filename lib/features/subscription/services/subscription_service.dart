import 'package:glassfy_flutter/glassfy_flutter.dart';
import 'package:glassfy_flutter/models.dart';


class SubscriptionService {
  ///API
  static const _apiKey = '26ab4f1c3fba4888bb53e14217a7e99c';

  static Future<void> init() async {
    await Glassfy.initialize(_apiKey, watcherMode: false);
  }



  ///GooglePay
  static Future<GlassfyTransaction?> purchaseSku(GlassfySku sku) async {
    try {
      return await Glassfy.purchaseSku(sku);
    } catch (e) {
      return null;
    }
  }}
