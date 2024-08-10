import 'package:doneapp/feature_modules/my_subscription/models/subscription_dailymeal.model.my_subscription.dart';
import 'package:doneapp/feature_modules/my_subscription/models/subscription_dailymeal_item.model.my_subscription.dart';
import 'package:doneapp/feature_modules/my_subscription/models/subscription_mealconfig.model.my_subscription.dart';
import 'package:doneapp/feature_modules/my_subscription/services/http.my_subscription.service.dart';
import 'package:doneapp/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp/shared_module/constants/valid_subscription_day_status.constants.shared.dart';
import 'package:doneapp/shared_module/controllers/controller.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySubscriptionController extends GetxController {

  var isSubscriptionDatesLoading = false.obs;
  var subscriptionDates = <DateTime, String>{}.obs;
  var currentMonth = DateTime (DateTime.now().year,DateTime.now().month,1).obs;
  var subscriptionMonths = <DateTime>[].obs;
  var subscriptionDays = <DateTime>[].obs;
  var firstWeekDays = <DateTime>[].obs;
  var secondWeekDays = <DateTime>[].obs;
  var thirdWeekDays = <DateTime>[].obs;
  var fourthWeekDays = <DateTime>[].obs;
  var fifthWeekDays = <DateTime>[].obs;
  var sixthWeekDays = <DateTime>[].obs;
  var frozenDays = <String>[].obs;
  var isDayMealSaving = false.obs;
  var isFreezing = false.obs;
  var isMealsFetching = false.obs;
  var recommendedCalories = (0.0).obs;
  var selectedDate = DateTime.now().obs;
  var subscriptoinMealConfig = mapSubscriptoinMealConfig({}, "").obs ;
  var selectedMealConfig = mapSubscriptoinMealConfig({}, "").obs ;

  getSubscriptionDates() async {
    if(!isSubscriptionDatesLoading.value){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? tMobile = prefs.getString('mobile');
      if (tMobile != null && tMobile != '') {
        isSubscriptionDatesLoading.value = true;

        var mySubsHttpService = MySubsHttpService();
        subscriptionDates.value = await mySubsHttpService.getSubscriptionDates(tMobile);
        isSubscriptionDatesLoading.value = false;
        setCurrentMonth();
        setSelectedDate();
        frozenDays.value = [];
      } else {
        showSnackbar(Get.context!, "couldnt_load_profiledata".tr, "error");
        showSnackbar(Get.context!, "login_message".tr, "error");
        Get.offAllNamed(AppRouteNames.loginRoute);
      }

    }
  }

  isAlreadySelectedForFreezing(DateTime dateTime){
    final f = DateFormat('yyyy-MM-dd');
    return frozenDays.contains(f.format(dateTime));
  }

 addDayToFreeze(DateTime dateTime){
   if(dateTime.month== currentMonth.value.month && isSubscriptionDay(dateTime)
      && dateTime.isAfter(DateTime.now())
       && getDayStatus(dateTime) != VALIDSUBSCRIPTIONDAY_STATUS.delivered
       && getDayStatus(dateTime) != VALIDSUBSCRIPTIONDAY_STATUS.offDay
       && getDayStatus(dateTime) != VALIDSUBSCRIPTIONDAY_STATUS.freezed){
     final f = DateFormat('yyyy-MM-dd');
     if(frozenDays.contains(f.format(dateTime)) ){
       frozenDays.remove(f.format(dateTime));
     }else{
       frozenDays.add(f.format(dateTime));
     }
   }

 }

  void setSelectedDate() {

    if(subscriptionDates.isNotEmpty) {
      DateTime startDate = subscriptionDates.keys.toList().first;
      final f = DateFormat('yyyy-MM-dd');
      selectedDate.value = startDate.isAfter(DateTime.now())?
      startDate:DateTime.now();
    }

  }

  void setCurrentMonth() {

    if(subscriptionDates.isNotEmpty){

      DateTime startDate = subscriptionDates.keys.toList().first;
      DateTime endDate = subscriptionDates.keys.toList().last;

      currentMonth.value = getCurrentMonth(startDate, endDate);
      subscriptionDates.forEach((key, value) {
        subscriptionDays.add(key);
        print("$key $value");
        if(!doesContainDate(subscriptionMonths,DateTime(key.year,key.month,1))){
          subscriptionMonths.add(DateTime(key.year,key.month,1));
        }
      });

      setCurrentMonthWeekDays();
    }

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

  doesContainDate(List<DateTime> dateLists ,DateTime fourthWeekDay){
    bool doesContain = false;
    for(var i=0; i<dateLists.length; i++){
      if(fourthWeekDay.year == dateLists[i].year &&
          fourthWeekDay.month == dateLists[i].month &&
          fourthWeekDay.day == dateLists[i].day ){
        doesContain = true;
      }
    }
    return doesContain;
  }

  DateTime getCurrentMonth(DateTime startDate, DateTime toDate) {
    if (startDate.month == toDate.month) {
      return DateTime(startDate.year, startDate.month, 1);
    } else {
      if (DateTime.now().isBefore(startDate)) {
        return DateTime(startDate.year, startDate.month, 1);
      } else if (DateTime.now().isAfter(startDate) &&
          DateTime.now().isBefore(toDate)) {
        return DateTime(DateTime.now().year, DateTime.now().month, 1);
      } else {
        return DateTime(toDate.year, toDate.month, 1);
      }
    }
  }

  bool isSubscriptionDay(DateTime firstWeekDay) {

    return subscriptionDates.keys.toList().contains(firstWeekDay);
  }

  String  getDayStatus(DateTime firstWeekDay) {

   if(subscriptionDates.keys.toList().contains(firstWeekDay)){
     return subscriptionDates[firstWeekDay]??"";
   }
   return "";
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

  Future<void> getMealsByDate(  DateTime tSelectedDay,bool isNavigationRequired ) async {

    if(tSelectedDay.month== currentMonth.value.month && isSubscriptionDay(tSelectedDay)
        && getDayStatus(tSelectedDay) != VALIDSUBSCRIPTIONDAY_STATUS.offDay
        && getDayStatus(tSelectedDay) != VALIDSUBSCRIPTIONDAY_STATUS.freezed && !isMealsFetching.value){
      selectedDate.value = tSelectedDay;

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? tMobile = prefs.getString('mobile');
      if (tMobile != null && tMobile != '') {
        isMealsFetching.value = true;
        if(isNavigationRequired){
          Get.toNamed(AppRouteNames.mealSelectionRoute);
        }
        final f = new DateFormat('yyyy-MM-dd');

        var mySubsHttpService = MySubsHttpService();
        subscriptoinMealConfig.value =  await mySubsHttpService.getMealsByDay(tMobile,f.format(selectedDate.value));
        initializeMealSelection(f.format(selectedDate.value));
        isMealsFetching.value = false;

      } else {
        showSnackbar(Get.context!, "couldnt_load_profiledata".tr, "error");
        showSnackbar(Get.context!, "login_message".tr, "error");
        Get.offAllNamed(AppRouteNames.loginRoute);
      }

    }else{

    }


  }

  Future<void> setMealsByDate( ) async {
    if(!isDayMealSaving.value){

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? tMobile = prefs.getString('mobile');
      if (tMobile != null && tMobile != '') {

        final sharedController = Get.find<SharedController>();
        int subscriptionId = sharedController.mySubscriptions.where((p0) => p0.status=='in_progress').toList().isNotEmpty?
        sharedController.mySubscriptions.where((p0) => p0.status=='in_progress').toList()[0].id:-1;

        if(subscriptionId != -1){
          isDayMealSaving.value = true;
          final f = new DateFormat('yyyy-MM-dd');
          var mySubsHttpService = MySubsHttpService();
          bool isSuccess  =  await mySubsHttpService.saveMealsByDay(subscriptionId,selectedMealConfig.value, f.format(selectedDate.value));

          if(isSuccess){
            showSnackbar(Get.context!, "selection_saved".tr, "info");
          }

          isDayMealSaving.value = false;
        }else {
          showSnackbar(Get.context!, "couldnt_load_profiledata".tr, "error");
          showSnackbar(Get.context!, "login_message".tr, "error");
          Get.offAllNamed(AppRouteNames.loginRoute);
        }

      } else {
        showSnackbar(Get.context!, "couldnt_load_profiledata".tr, "error");
        showSnackbar(Get.context!, "login_message".tr, "error");
        Get.offAllNamed(AppRouteNames.loginRoute);
      }

    }


  }


  void initializeMealSelection(String date) {
    List<SubscriptoinDailyMeal> meals = [];
    double recommendedCalories = 0.0;
    for (var element in subscriptoinMealConfig.value.meals) {

      List<SubscriptoinDailyMealItem> mealItems = [];

      for (var item in element.items) {
        if(item.isSelected){
          recommendedCalories += item.calories;
          mealItems.add(item);
        }
      }

      meals.add(SubscriptoinDailyMeal(
          name: element.name,
          id: element.id,
          arabicName: element.arabicName,
          items: mealItems,
          itemCount: element.itemCount));
    }
    selectedMealConfig.value = SubscriptoinMealConfig(date: date, recommendedCalories:recommendedCalories, meals: meals);

  }

  addOrRemoveMeal(int categoryId, int mealId){
    double currentSelectedCalories = selectedMealConfig.value.recommendedCalories;
    List<SubscriptoinDailyMeal> meals = [];
    for (var element in subscriptoinMealConfig.value.meals) {
      if(element.id != categoryId){
        meals.add(SubscriptoinDailyMeal(
            name: element.name,
            id: element.id,
            arabicName: element.arabicName,
            items: getAlreadySelectedMeals(element.id),
            itemCount: element.itemCount));
      }else{
        List<SubscriptoinDailyMealItem> mealItem = element.items.where((element) => element.id==mealId).toList();
        if(mealItem.isEmpty){
          meals.add(SubscriptoinDailyMeal(
              name: element.name,
              id: element.id,
              arabicName: element.arabicName,
              items: getAlreadySelectedMeals(element.id),
              itemCount: element.itemCount));
        }else{
          if(isMealAlreadySelected(element.id, mealId)){

            List<SubscriptoinDailyMealItem> alreadySelectedMeals = getAlreadySelectedMeals(element.id);

            meals.add(SubscriptoinDailyMeal(
                name: element.name,
                id: element.id,
                arabicName: element.arabicName,
                items: alreadySelectedMeals.where((element) => element.id !=mealId).toList(),
                itemCount: element.itemCount));
            currentSelectedCalories -= mealItem[0].calories;
          }else{
           if(isMealMaximumCountReached(element.id)){
             showSnackbar(Get.context!, "meal_limit_reached".tr, "error");
             meals.add(SubscriptoinDailyMeal(
                 name: element.name,
                 id: element.id,
                 arabicName: element.arabicName,
                 items: getAlreadySelectedMeals(element.id),
                 itemCount: element.itemCount));
           }else{
             List<SubscriptoinDailyMealItem> mealItemsToAdd = [];
             mealItemsToAdd.add(mealItem[0]);
             meals.add(SubscriptoinDailyMeal(
                 name: element.name,
                 id: element.id,
                 arabicName: element.arabicName,
                 items: mealItemsToAdd,
                 itemCount: element.itemCount));
             currentSelectedCalories += mealItem[0].calories;

           }

          }

        }
      }
    }
    selectedMealConfig.value = SubscriptoinMealConfig(
        date: selectedMealConfig.value.date,
        recommendedCalories:currentSelectedCalories, meals: meals);

  }

  List<SubscriptoinDailyMealItem> getAlreadySelectedMeals(int categoryId ){
    if(selectedMealConfig.value.meals.where((element) => element.id==categoryId ).toList().isNotEmpty){
      return selectedMealConfig.value.meals.where((element) => element.id==categoryId
      ).toList()[0].items;
    }else{
      return [];
    }
  }

  isMealAlreadySelected(int categoryId, int mealId){
   return selectedMealConfig.value.meals.where((element) => element.id==categoryId &&
        element.items.where((item) => item.id==mealId).toList().isNotEmpty
    ).toList().isNotEmpty;
  }
  isMealMaximumCountReached(int categoryId){

    List<SubscriptoinDailyMeal> originalMeals = [];
    List<SubscriptoinDailyMeal> selectedMeals = [];

    selectedMeals =  selectedMealConfig.value.meals.where((element) => element.id==categoryId ).toList();
    originalMeals =  subscriptoinMealConfig.value.meals.where((element) => element.id==categoryId ).toList();

    if(selectedMeals.isNotEmpty && originalMeals.isNotEmpty){
      return selectedMeals[0].items.length==originalMeals[0].itemCount;
    }
    return true;

  }

  Future<void> freezeSubscription() async {
    if(!isFreezing.value){
        final sharedController = Get.find<SharedController>();
        int subscriptionId = sharedController.mySubscriptions.where((p0) => p0.status=='in_progress').toList().isNotEmpty?
        sharedController.mySubscriptions.where((p0) => p0.status=='in_progress').toList()[0].id:-1;

        if(subscriptionId != -1){
          isFreezing.value = true;
          final f = new DateFormat('yyyy-MM-dd');
          var mySubsHttpService = MySubsHttpService();
          bool isSuccess  =  await mySubsHttpService.freezeSubscriptionDays(subscriptionId,frozenDays);
          isFreezing.value = false;
          if(isSuccess){
            showSnackbar(Get.context!, "subscription_frozen".tr, "info");
            getSubscriptionDates();
          }


        }else {
          showSnackbar(Get.context!, "couldnt_load_profiledata".tr, "error");
          showSnackbar(Get.context!, "login_message".tr, "error");
          Get.offAllNamed(AppRouteNames.loginRoute);
        }



    }


  }

}