
import 'package:doneapp/feature_modules/my_subscription/models/subscription_dailymeal_item.model.my_subscription.dart';

class SubscriptoinDailyMeal {
  final int id;
  final String name;
  final String arabicName;
  final int itemCount;
  final List<SubscriptoinDailyMealItem> items;

  SubscriptoinDailyMeal(
      {required this.name,
        required this.id,
        required this.arabicName,
        required this.items,
        required this.itemCount});
}

SubscriptoinDailyMeal mapSubscriptoinDailyMeal(dynamic payload) {

  List<SubscriptoinDailyMealItem> items = [];

  if(payload["items"] != null && payload["items"] is! String ){
    payload["items"].forEach((element) {
      if(element != null){
        items.add(mapSubscriptoinDailyMealItem(element));
      }
    });
  }
  return SubscriptoinDailyMeal(
      id: payload["id"] ?? -1,
    itemCount: payload["item_count"] ?? 0,
    arabicName: payload["arabic_name"] ?? "",
    name: payload["name"] ?? "",
      items:items
  );
}
