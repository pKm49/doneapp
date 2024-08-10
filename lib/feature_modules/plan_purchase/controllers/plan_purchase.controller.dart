import 'package:doneapp/feature_modules/plan_purchase/models/discount_data.model.plan_purchase.dart';
import 'package:doneapp/feature_modules/plan_purchase/models/payment_data.model.plan_purchase.dart';
import 'package:doneapp/feature_modules/plan_purchase/models/plan.model.plan_purchase.dart';
import 'package:doneapp/feature_modules/plan_purchase/models/plan_category.model.plan_purchase.dart';
import 'package:doneapp/feature_modules/plan_purchase/models/purchase_data.model.plan_purchase.dart';
import 'package:doneapp/feature_modules/plan_purchase/services/http.services.plan_purchase.dart';
import 'package:doneapp/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:shared_preferences/shared_preferences.dart';



class PlanPurchaseController extends GetxController {
  Rx<TextEditingController> couponCodeController = TextEditingController().obs;

  var subscriptionCategories = <SubscriptionPlanCategory>[].obs;
  var subscriptionDurations = <int>[].obs;
  var subscriptions = <SubscriptionPlan>[].obs;
  var isSubscriptionsFetching = false.obs;
  var isCategoriesFetching = false.obs;
  Rx<SubscriptionPlanCategory> currentCategory = mapSubscriptionCategory({}).obs;
  Rx<SubscriptionPlan> currentSubscription = mapSubscriptionItem({}).obs;

  var paymentData = mapPaymentData({}).obs;
  var subTotal = (0.0).obs;
  var discount = (0.0).obs;
  var total = (0.0).obs;
  var isCouponChecking = false.obs;
  var isCouponCodeValid = false.obs;
  var isOrderCreating = false.obs;
  var paymentGatewayIsLoading = false.obs; 


  // calendar
  var firstWeekDays = <DateTime>[].obs;
  var secondWeekDays = <DateTime>[].obs;
  var thirdWeekDays = <DateTime>[].obs;
  var fourthWeekDays = <DateTime>[].obs;
  var fifthWeekDays = <DateTime>[].obs;
  var sixthWeekDays = <DateTime>[].obs;
  var minimumPossibleDate = DateTime.now().obs;
  var selectedDate = DateTime.now().obs;
  var currentMonth = DateTime (DateTime.now().year,DateTime.now().month,1).obs;

  @override
  void onInit() {
    super.onInit();
    minimumPossibleDate.value = DateTime.now().add(Duration(days: 2));
    selectedDate.value = DateTime.now().add(Duration(days: 3));
    setCurrentMonthWeekDays();
     couponCodeController.value.addListener(() {
      resetCouponCode();
    });
  }

  Future<void> getSubscriptionCategories() async {
    isCategoriesFetching.value = true;
    subscriptionCategories.value = [];
    var planPurchaseHttpService = new PlanPurchaseHttpService();
    subscriptionCategories.value =
        await planPurchaseHttpService.getSubscriptionCategories();
    isCategoriesFetching.value = false;
    currentCategory.value = mapSubscriptionCategory({});
    update();
    if (subscriptionCategories.isEmpty) {
      currentSubscription.value = mapSubscriptionItem({});
      subscriptionDurations.value = [];
      subscriptions.value = [];
      subTotal.value = 0.0;
      total.value = 0.0;
      discount.value = 0.0;
    }
  }



  changeCategory(SubscriptionPlanCategory subscriptionPlanCategory) {
    currentCategory.value = subscriptionPlanCategory;
  }

  void changeSubscription(SubscriptionPlan subscription) {
    print("changeSubscription");
    currentSubscription.value = subscription;
    subTotal.value = currentSubscription.value.price;
    discount.value = 0.0;
    total.value = subTotal.value- discount.value;
    print(currentSubscription.value.name);
  }
  Future<void> getSubscriptionsByCategory(  ) async {
    isSubscriptionsFetching.value = true;
    subscriptions.value = [];
    var planPurchaseHttpService = PlanPurchaseHttpService();
    subscriptions.value = await planPurchaseHttpService
        .getSubscriptionsByCategory(currentCategory.value);
    update();
    print("getSubscriptionsByCategory");
    print(subscriptions.value.length);
    subTotal.value = 0.0;
    total.value = 0.0;
    discount.value = 0.0;

    currentSubscription.value = mapSubscriptionItem({});
    isSubscriptionsFetching.value = false;
  }

  resetCouponCode(){
    isCouponCodeValid.value = false;
    subTotal.value = currentSubscription.value.price;
    discount.value = 0.0;
    total.value = subTotal.value;
  }

  Future<void> checkCouponValidity() async {
    isCouponChecking.value = true;
    isCouponCodeValid.value = false;

    var planPurchaseHttpService = PlanPurchaseHttpService();
    DiscountData discountData = await planPurchaseHttpService.verifyCoupon(
         currentSubscription.value.id,
        couponCodeController.value.text);

    if (!discountData.isValid ) {
      isCouponCodeValid.value = false;

      showSnackbar(Get.context!, "coupon_code_not_valid".tr, "error");
      subTotal.value = currentSubscription.value.price;
      discount.value = 0.0;
      total.value = subTotal.value;
      couponCodeController.value.text = "";
    } else {
      isCouponCodeValid.value = true;

      subTotal.value = discountData.total;
      discount.value = discountData.discount;
      total.value = discountData.grandTotal;
      showSnackbar(Get.context!, "coupon_code_valid".tr, "info");
    }
    isCouponChecking.value = false;
  }

  void createOrder() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    final String? mobile = sharedPreferences.getString('mobile');

    if (mobile != null && mobile != "") {
      isOrderCreating.value = true;
      var planPurchaseHttpService = PlanPurchaseHttpService();
      List<dynamic> tSubscriptions = [];
      tSubscriptions.add(PurchaseData(
              planCategoryId: currentSubscription.value.id,
              planId: currentSubscription.value.id )
          .toJson());
      PaymentData tPaymentData = await planPurchaseHttpService.createOrder(
          mobile, tSubscriptions, couponCodeController.value.text);
      paymentData.value = tPaymentData;
      print("payment data");
      print(paymentData.value.paymentUrl);
      print(paymentData.value.redirectUrl);
      print(paymentData.value.refId);
      print(paymentData.value.orderId);
      if (paymentData.value.paymentUrl == "" ||
          paymentData.value.redirectUrl == "") {
        if ((total.value == 0 || total.value == 0.0) && (paymentData.value.refId!='' && paymentData.value.orderId!='')) {
          showSnackbar(Get.context!, "payment_capture_success".tr, "info");
          Get.toNamed(AppRouteNames.otpVerificationSuccessRoute,arguments: [
            ASSETS_SUCCESSMARK,"subscription_success".tr,"subscription_success_info".tr,
            'home'.tr,false,AppRouteNames.homeRoute,""
          ])?.then((value) => Get.toNamed(AppRouteNames.homeRoute,arguments: [0]));
        }else{
          showSnackbar(Get.context!, "payment_capture_error".tr, "error");
        }
          print("payment capture error");
        isOrderCreating.value = false;
      } else {
        Get.toNamed(AppRouteNames.paymentPageRoute, arguments: [
          paymentData.value.paymentUrl,
          paymentData.value.redirectUrl,
          paymentData.value.paymentCheckUrl
        ])?.then((value) => checkOrderStatus());
      }
    } else {
      showSnackbar(Get.context!, "login_message".tr, "error");
      Get.offAllNamed(AppRouteNames.loginRoute);
    }
  }

  void checkOrderStatus() async {
    isOrderCreating.value = true;
    var planPurchaseHttpService = PlanPurchaseHttpService();
    bool isSuccess = await planPurchaseHttpService
        .checkOrderStatus(paymentData.value.refId);
    isOrderCreating.value = false;

    if (!isSuccess) {
      showSnackbar(Get.context!, "payment_capture_error".tr, "error");
    } else {
      showSnackbar(Get.context!, "payment_capture_success".tr, "info");
      Get.toNamed(AppRouteNames.otpVerificationSuccessRoute,arguments: [
        ASSETS_SUCCESSMARK,"subscription_success".tr,"subscription_success_info".tr,
        'home'.tr,false,AppRouteNames.homeRoute,""
      ])?.then((value) => Get.toNamed(AppRouteNames.homeRoute,arguments: [0]));
    }
  }

  paymentGatewayGoback(bool status) {
    Get.back(result: status);
  }

  void changePaymentGatewayLoading(bool status) {
    paymentGatewayIsLoading.value = status;
  }

  void resetData() {
    couponCodeController.value.text = "";
    currentSubscription.value = mapSubscriptionItem({});
    isSubscriptionsFetching.value = false;
    isCategoriesFetching.value = false;
    currentCategory.value = mapSubscriptionCategory({});
    paymentData.value = mapPaymentData({});
    subTotal.value = (0.0);
    discount.value = (0.0);
    total.value = (0.0);
    isCouponChecking.value = false;
    isOrderCreating.value = false;
    paymentGatewayIsLoading.value = false;

  }





  void setSelectedDate(DateTime date) {

    selectedDate.value = date ;

  }



  void previousMonth() {
    var newDate = DateTime(currentMonth.value.year, currentMonth.value.month - 1, currentMonth.value.day);
    currentMonth.value = newDate;
    setCurrentMonthWeekDays();

  }

  void nextMonth() {
    var newDate = DateTime(currentMonth.value.year, currentMonth.value.month + 1, currentMonth.value.day);
    currentMonth.value = newDate;
    setCurrentMonthWeekDays();

  }

  setCurrentMonthWeekDays() {

    List<DateTime> weekDays = [];
    DateTime weekStartDate = getDate(currentMonth.value.subtract(Duration(days: currentMonth.value.weekday))) ;
    DateTime weekEndDate = getDate(currentMonth.value.add(Duration(days: DateTime.daysPerWeek - (currentMonth.value.weekday+1))));
    print("weekStartDate month: ${weekStartDate.month}");
    print("weekEndDate month: ${weekEndDate.month}");
    print("currentMonth.value month : ${currentMonth.value.month}");
    if(weekStartDate.month < currentMonth.value.month && weekEndDate.month < currentMonth.value.month){
      weekStartDate = currentMonth.value;
      weekEndDate = currentMonth.value.add(Duration(days: 6));
    }
    print("weekStartDate : $weekStartDate");
    print("weekEndDate : $weekEndDate");
    firstWeekDays.clear();
    secondWeekDays.clear();
    thirdWeekDays.clear();
    fourthWeekDays.clear();
    fifthWeekDays.clear();
    sixthWeekDays.clear();
    for (int index = 1; index <= 6; index++) {
      weekDays=[];
      if (index != 1) {
        weekStartDate = weekStartDate.add(Duration(days:   7));
        weekEndDate = weekEndDate.add(Duration(days:   7));
      }

      for (int i = 0; i <= weekEndDate
          .difference(weekStartDate)
          .inDays; i++) {
        weekDays.add(weekStartDate.add(Duration(days: i)));
      }

      switch (index){
        case 1:{
          firstWeekDays.addAll(weekDays);
          break;
        }
        case 2:
          {
            secondWeekDays.addAll(weekDays);
            break;
          }
        case 3:
          {
            thirdWeekDays.addAll(weekDays);
            break;
          }
        case 4:
          {
            fourthWeekDays.addAll(weekDays);
            break;
          }
        case 5:
          {
            fifthWeekDays.addAll(weekDays);
            break;
          }
        case 6:
          {
            sixthWeekDays.addAll(weekDays);
            break;
          }
      }

    }

  }

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

}
