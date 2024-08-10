
import 'package:doneapp/shared_module/constants/asset_urls.constants.shared.dart';

class SubscriptoinDailyMealItem {
  final int id;
  final String name;
  final String arabicName;
  final String description;
  final String arabicDescription;
  final String image;
  final double calories;
  final bool isSelected;

  SubscriptoinDailyMealItem(
      {
        required this.id,
        required this.name,
        required this.arabicName,
        required this.description,
        required this.arabicDescription,
        required this.calories,
        required this.isSelected,
        required this.image,
      });
}

SubscriptoinDailyMealItem mapSubscriptoinDailyMealItem(dynamic payload) {

  return SubscriptoinDailyMealItem(
    id: payload["id"] ?? -1,
    arabicName: payload["arabic_name"] ?? "",
    name: payload["name"] ?? "",
    description: payload["description"] != null?
      payload["description"]==false?'':payload["description"]:"",
    arabicDescription: payload["arabic_description"] != null?
    payload["arabic_description"]==false?'':payload["arabic_description"]:"",
    calories: payload["calories"] ?? 0.0,
    isSelected: payload["is_selected"] ?? false,
    image: payload["image"] ?? ASSETS_SAMPLEFOOD,
  );
}
