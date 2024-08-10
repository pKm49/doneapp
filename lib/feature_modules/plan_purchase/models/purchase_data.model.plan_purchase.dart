
class PurchaseData {
  final int planCategoryId;
  final int planId;

  PurchaseData({
    required this.planCategoryId,
    required this.planId,
  });

  Map toJson() => {
        'plan_category_id': planCategoryId,
        'plan_id': planId,
      };
}

