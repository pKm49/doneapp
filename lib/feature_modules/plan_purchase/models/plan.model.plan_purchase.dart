

import 'package:doneapp/feature_modules/plan_purchase/models/plan_category.model.plan_purchase.dart';

class SubscriptionPlan {

  final int id;
  final String name;
  final String arabicName;
  final  String durationType;
  final double price;
  final double strikePrice;
  final double protein;
  final double carbohydrates;

  SubscriptionPlan({
    required this.id,
    required this.price,
    required this.name,
    required this.arabicName,
    required this.strikePrice,
    required this.durationType,
    required this.carbohydrates,
    required this.protein,
  });


}

SubscriptionPlan mapSubscriptionItem(dynamic payload ){
  print("mapSubscriptionItem");
  print(payload);
  return SubscriptionPlan(
    id :payload["id"]??-1,
    price :payload["price"]??0.0,
      protein :payload["protein"]??0.0,
      carbohydrates :payload["carbohydrates"]??0.0,
    strikePrice :(payload["strike_price"] !="" && payload["strike_price"] != null)?payload["strike_price"]:0.0,
    name :payload["name"]??"",
    arabicName :payload["arabic_name"] !=null?payload["arabic_name"].toString():"",
    durationType :payload["duration_type"]??"Week"
  );

}
//
// SubscriptionPlan mapMySubscriptionItem(dynamic payload){
//
//   return SubscriptionPlan(
//     id :payload["plan_id"]??-1,
//     subscriptionId :payload["subscription_id"]??-1,
//     snacksCount :payload["snacks_count"]??0,
//     mealsCount :payload["meals_count"]??0,
//     price :payload["price"]??0.0,
//     name :payload["plan_name"]??"",
//     arabicName :payload["plan_arabic_name"] !=null?payload["plan_arabic_name"].toString():"",
//     duration_type :payload["plan_category_name"]??"",
//     categoryId :payload["plan_category_id"]??-1,
//     categoryArabicName :payload["plan_category_arabic_name"] !=null?payload["arabic_name"].toString():"",
//     days :payload["plan_duration"]??0,
//   );
//
// }