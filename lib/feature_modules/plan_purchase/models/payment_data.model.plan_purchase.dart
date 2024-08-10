
import 'package:doneapp/shared_module/models/my_subscription.model.shared.dart';

class PaymentData {

  final String refId;
  final String orderId;
  final String paymentUrl;
  final String redirectUrl;
  final String paymentCheckUrl;
  final MySubscription selectedSubscriptionPlan;
  
  PaymentData({
    required this.refId,
    required this.orderId,
    required this.paymentUrl,
    required this.redirectUrl,
    required this.paymentCheckUrl,
    required this.selectedSubscriptionPlan,
    
  });

  Map toJson() => {
        'refId': refId,
        'orderId': orderId,
        'paymentUrl': paymentUrl,
        'redirectUrl': redirectUrl,
      };
}

PaymentData mapPaymentData(dynamic payload) {
  print("mapPaymentData");
  print(payload);
  MySubscription selectedSubscriptionPlan = mapMySubscription( {} );
  if (payload['subscription_details'] != null) {
    selectedSubscriptionPlan = mapMySubscription(payload['subscription_details']);
  }

  String redirectUrl = "";
  String paymentUrl = "";

  if (payload['redirect_url'] != null) {
    if (payload['redirect_url'] != false) {
      redirectUrl = payload["redirect_url"] ?? "";
    }
  }

  if (payload['transaction_url'] != null) {
    if (payload['transaction_url'] != false) {
      paymentUrl = payload["transaction_url"] ?? "";
    }
  }

  return PaymentData(
    refId: payload["payment_reference"] ?? "",
    orderId: payload["order_reference"] ?? "",
    redirectUrl: redirectUrl,
    paymentUrl: paymentUrl,
    paymentCheckUrl: payload["payment_status_url"] ?? "",
    selectedSubscriptionPlan: selectedSubscriptionPlan,
  );
}
