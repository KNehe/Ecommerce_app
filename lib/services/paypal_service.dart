import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_braintree/flutter_braintree.dart';

class PayPalService {
  static final String tokenizationKey = 'sandbox_9qqht4sx_2c34stzd8dh7rzxb';

  static Future<String> processPayment(
      String amount, BuildContext context) async {
    try {
      final request = BraintreePayPalRequest(amount: amount);

      BraintreePaymentMethodNonce result =
          await Braintree.requestPaypalNonce(tokenizationKey, request);

      if (result != null) {
        return result.nonce;
      } else {
        print('PayPal flow was canceled.');
      }
    } on PlatformException catch (e) {
      print("Paltform excepion: ${e.toString()}");
    } catch (e) {
      print("ERROR: ${e.toString()} ");
    }
  }
}
