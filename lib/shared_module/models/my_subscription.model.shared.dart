

import 'package:doneapp/feature_modules/address/models/shipping_address.model.address.dart';

class MySubscription {
  final int id;
  final String number;
  final String status;
  final String progress;

  final int mealsCount;
  final int snacksCount;
  final double price;
  final int planId;
  final String planName;
  final String planArabicName;
  final int planCategoryId;
  final String planCategoryName;
  final String planCategoryArabicName;
  final int days;
  final DateTime fromDate;
  final List<DateTime> freezeDays;
  final List<DateTime> offDays;
  final DateTime toDate;
  final Address address;

  MySubscription(
      {required this.id,
      required this.status,
      required this.number,
      required this.mealsCount,
      required this.snacksCount,
      required this.price,
      required this.planId,
      required this.planName,
      required this.planArabicName,
      required this.planCategoryId,
      required this.planCategoryName,
      required this.planCategoryArabicName,
      required this.days,
      required this.fromDate,
      required this.progress,
      required this.toDate,
      required this.address,
      required this.offDays,
      required this.freezeDays});
}

MySubscription mapMySubscription(dynamic payload) {
  print("mapMySubscription payload is");
  print(payload["freeze_days"]);
  print(payload);
  return MySubscription(
    id: payload["subscription_id"] ?? -1,
    snacksCount: payload["snacks_count"] ?? 0,
    mealsCount: payload["meals_count"] ?? 0,
    price: payload["grand_total"] ?? 0.0,
    planName: payload["plan_name"] ?? "",
    progress: payload["subscription_progress"] ?? "0",
    status: payload["subscription_status"] ?? "",
    planArabicName: payload["plan_arabic_name"] != null
        ? payload["plan_arabic_name"].toString()
        : "",
    planCategoryName: payload["plan_category_name"] ?? "",
    planCategoryId: payload["plan_category_id"] ?? -1,
    planCategoryArabicName: payload["plan_category_arabic_name"] != null
        ? payload["arabic_name"].toString()
        : "",
    days: payload["plan_duration"] ?? 0,
    number: payload["subscription_number"] ?? "",
    planId: payload["plan_id"] ?? 0,
    fromDate: payload["start_date"] != null
        ? DateTime.parse(payload["start_date"].toString())
        : DateTime.now(),
    toDate: payload["end_date"] != null
        ? DateTime.parse(payload["end_date"].toString())
        : DateTime.now(),
    address: mapAddress(payload["address"]??{}),
    freezeDays: payload["freeze_days"] != null
        ? getFrozenDates(payload["freeze_days"])
        : [],
    offDays: payload["off_days"] != null
        ? getFrozenDates(payload["off_days"])
        : [],
  );
}

List<DateTime> getFrozenDates(List<dynamic> payload) {
  List<DateTime> freezeDays = [];
  for (var i = 0; i < payload.length; i++) {
    freezeDays.add(DateTime.parse(payload[i].toString()));
  }
  return freezeDays;
}
