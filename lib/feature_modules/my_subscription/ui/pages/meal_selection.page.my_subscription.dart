import 'package:doneapp/feature_modules/my_subscription/controller/my_subscription.controller.dart';
import 'package:doneapp/feature_modules/my_subscription/ui/components/meal_calendar_date_mealselection.my_subscription.dart';
import 'package:doneapp/feature_modules/my_subscription/ui/components/meal_selection_itemsloader.component.my_subscription.dart';
import 'package:doneapp/feature_modules/my_subscription/ui/components/meal_selection_titleloader.component.my_subscription.dart';
import 'package:doneapp/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:doneapp/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp/shared_module/constants/valid_addressauthor_modes.constants.shared.dart';
import 'package:doneapp/shared_module/constants/valid_subscription_day_status.constants.shared.dart';
 import 'package:doneapp/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/calendar_utilities.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/date_conversion.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:doneapp/shared_module/ui/components/custom_back_button.component.shared.dart';
 import 'package:flutter/material.dart';
 import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shimmer/shimmer.dart';

class MealSelectionPage_MySubscription extends StatefulWidget {
  const MealSelectionPage_MySubscription({super.key});

  @override
  State<MealSelectionPage_MySubscription> createState() =>
      _MealSelectionPage_MySubscriptionState();
}

class _MealSelectionPage_MySubscriptionState
    extends State<MealSelectionPage_MySubscription> {
  final mySubscriptionController = Get.find<MySubscriptionController>();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!mySubscriptionController.isMealsFetching.value &&
        mySubscriptionController.subscriptoinMealConfig.value.date == "") {
      mySubscriptionController.getMealsByDate(
          mySubscriptionController.selectedDate.value, false);
    }
    scrollToDate();

  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0.0,
          backgroundColor: APPSTYLE_BackgroundWhite,
          elevation: 0.0,
          title: Row(
            children: [
              CustomBackButton(isPrimaryMode: false),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'select_meal'.tr,
                    style: getHeadlineLargeStyle(context)
                        .copyWith(fontWeight: APPSTYLE_FontWeightBold),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
          actions: [
            Visibility(
              visible: !mySubscriptionController.isDayMealSaving.value &&
                  !mySubscriptionController.isMealsFetching.value && !mySubscriptionController
                  .isFreezing.value && mySubscriptionController.selectedDate.value.isAfter(DateTime.now().add(const Duration(days: 2))) &&
                  mySubscriptionController.subscriptionDates[mySubscriptionController.selectedDate.value] != VALIDSUBSCRIPTIONDAY_STATUS.offDay
                  && mySubscriptionController.subscriptionDates[mySubscriptionController.selectedDate.value] != VALIDSUBSCRIPTIONDAY_STATUS.delivered,
              child: InkWell(
                onTap: () {
                  if(!mySubscriptionController.isDayMealSaving.value &&
                      !mySubscriptionController.isMealsFetching.value && !mySubscriptionController
                      .isFreezing.value && mySubscriptionController.selectedDate.value.isAfter(DateTime.now().add(const Duration(days: 2))) &&
                      mySubscriptionController.subscriptionDates[mySubscriptionController.selectedDate.value] != VALIDSUBSCRIPTIONDAY_STATUS.offDay
                  && mySubscriptionController.subscriptionDates[mySubscriptionController.selectedDate.value] != VALIDSUBSCRIPTIONDAY_STATUS.delivered){
                  showFreezeConfirmDialogue(context);
                  }
                },
                child: Container(
                  width: screenwidth * .25,
                  decoration:
                      APPSTYLE_ShadowedContainerExtraSmallDecoration.copyWith(
                          boxShadow: [
                        const BoxShadow(
                          color: APPSTYLE_Grey80Shadow24,
                          offset: Offset(0, 3.0),
                          blurRadius: APPSTYLE_BlurRadiusLarge,
                        ),
                      ],
                          color: APPSTYLE_Black),
                  padding: EdgeInsets.symmetric(
                      vertical: APPSTYLE_SpaceSmall,
                      horizontal: APPSTYLE_SpaceSmall),
                  child:  mySubscriptionController
                      .isFreezing.value
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          LoadingAnimationWidget.staggeredDotsWave(
                                              color: APPSTYLE_BackgroundWhite,
                                              size: 24,
                                            ),
                        ],
                      ): Row(
                    children: [
                      Icon(mySubscriptionController.subscriptionDates[mySubscriptionController.selectedDate.value] == VALIDSUBSCRIPTIONDAY_STATUS.freezed ?
                      Ionicons.play:  Ionicons.pause,
                          color: APPSTYLE_BackgroundWhite,
                          size: APPSTYLE_FontSize16),
                      addHorizontalSpace(APPSTYLE_SpaceExtraSmall),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            mySubscriptionController.subscriptionDates[mySubscriptionController.selectedDate.value] == VALIDSUBSCRIPTIONDAY_STATUS.freezed ?
                            "unpause".tr:"pause".tr,
                            style: getBodyMediumStyle(context)
                                .copyWith(color: APPSTYLE_BackgroundWhite),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            addHorizontalSpace(APPSTYLE_SpaceLarge)
          ],
        ),
        body: SafeArea(
            child: Container(
          child: Column(
            children: [
              Padding(
                padding: APPSTYLE_LargePaddingHorizontal,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var date in mySubscriptionController
                          .subscriptionDates.keys)
                        InkWell(
                            onTap: () {
                              mySubscriptionController.getMealsByDate(
                                  date, false);
                            },
                            child:
                                MealCalendarDateMealSelectionComponent_MySubscription(
                                    date: date,
                                    isSelected: isSameDay(
                                        date,
                                        mySubscriptionController
                                            .selectedDate.value),
                                    status: mySubscriptionController
                                            .subscriptionDates[date] ??
                                        ""))
                    ],
                  ),
                ),
              ),
              addVerticalSpace(APPSTYLE_SpaceLarge),
              Visibility(
                visible: !mySubscriptionController.isMealsFetching.value && !mySubscriptionController.isFreezing.value &&
                    mySubscriptionController
                        .subscriptoinMealConfig.value.meals.isNotEmpty && (mySubscriptionController
                    .subscriptionDates[mySubscriptionController.selectedDate.value]  == VALIDSUBSCRIPTIONDAY_STATUS.mealSelected ||
                    mySubscriptionController
                        .subscriptionDates[mySubscriptionController.selectedDate.value]  == VALIDSUBSCRIPTIONDAY_STATUS.mealNotSelected),
                child: Expanded(
                  child: ListView.builder(
                      itemCount: mySubscriptionController
                          .subscriptoinMealConfig.value.meals.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding:
                              APPSTYLE_MediumPaddingVertical.copyWith(top: 0),
                          child: Wrap(
                            children: [
                              Padding(
                                padding: APPSTYLE_LargePaddingHorizontal,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              Localizations.localeOf(context)
                                                          .languageCode
                                                          .toString() ==
                                                      'ar'
                                                  ? mySubscriptionController
                                                      .subscriptoinMealConfig
                                                      .value
                                                      .meals[index]
                                                      .arabicName
                                                  : mySubscriptionController
                                                      .subscriptoinMealConfig
                                                      .value
                                                      .meals[index]
                                                      .name,
                                              style: getHeadlineMediumStyle(
                                                      context)
                                                  .copyWith(
                                                      fontWeight:
                                                          APPSTYLE_FontWeightBold)),
                                          Container(
                                            width: 30,
                                            height: 2,
                                            color: APPSTYLE_Grey80,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration:
                                          APPSTYLE_BorderedContainerLargeDecoration
                                              .copyWith(
                                                  color: APPSTYLE_PrimaryColor),
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              APPSTYLE_BorderRadiusExtraSmall *
                                                  .5,
                                          horizontal: APPSTYLE_SpaceSmall),
                                      child: Text(
                                        "item_count".tr.replaceAll("1",
                                            "${mySubscriptionController.selectedMealConfig.value.meals[index].items.length}/${mySubscriptionController.subscriptoinMealConfig.value.meals[index].itemCount}"),
                                        style: getBodyMediumStyle(context)
                                            .copyWith(
                                                color:
                                                    APPSTYLE_BackgroundWhite),
                                      ),
                                    ),
                                    Visibility(
                                        visible: mySubscriptionController.selectedMealConfig.value.meals[index].items.isNotEmpty,
                                        child: addHorizontalSpace(APPSTYLE_SpaceSmall)),
                                    Visibility(
                                      visible: mySubscriptionController.selectedMealConfig.value.meals[index].items.isNotEmpty,
                                      child: InkWell(
                                        onTap: (){
                                          mySubscriptionController.removeSelectionPerCategory(mySubscriptionController.selectedMealConfig.value.meals[index].id);
                                        },
                                        child: Container(
                                          decoration:
                                          APPSTYLE_BorderedContainerLargeDecoration
                                              .copyWith(
                                            border: Border.all(color: APPSTYLE_GuideRed, width: .5),
                                              color: APPSTYLE_BackgroundWhite),
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                              APPSTYLE_BorderRadiusExtraSmall *
                                                  .5,
                                              horizontal: APPSTYLE_SpaceSmall),
                                          child: Text(  "clear_selection".tr,
                                            style: getBodyMediumStyle(context)
                                                .copyWith(
                                                color:
                                                APPSTYLE_GuideRed),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: APPSTYLE_LargePaddingHorizontal.copyWith(top: APPSTYLE_SpaceMedium),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: mySubscriptionController
                                      .subscriptoinMealConfig
                                      .value
                                      .meals[index]
                                      .items
                                      .length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 0,
                                          crossAxisSpacing:
                                              APPSTYLE_SpaceSmall,
                                          mainAxisExtent: screenheight * 0.4),
                                  itemBuilder: (context, indx) {
                                    return Container(
                                      decoration:
                                      APPSTYLE_BorderedContainerSmallDecoration
                                          .copyWith(
                                        color: APPSTYLE_Grey20,
                                      ),
                                      margin: EdgeInsets.only(bottom: APPSTYLE_SpaceMedium),
                                      padding: APPSTYLE_SmallPaddingAll,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Container(
                                            decoration: APPSTYLE_BorderedContainerDarkMediumDecoration
                                                .copyWith(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    APPSTYLE_BorderRadiusSmall),
                                                color:
                                                APPSTYLE_Grey20,
                                                image: DecorationImage(image: getProductImage(mySubscriptionController
                                                    .subscriptoinMealConfig
                                                    .value
                                                    .meals[
                                                index]
                                                    .items[
                                                indx]
                                                    .image),fit: BoxFit.cover),
                                                border: Border.all(
                                                    color:
                                                    APPSTYLE_BackgroundWhite,
                                                    width: 0.0)),
                                            width: screenwidth * .4,
                                            height: screenwidth * .35,
                                            clipBehavior:
                                            Clip.hardEdge ),
                                          addVerticalSpace(
                                              APPSTYLE_SpaceExtraSmall),
                                          Text(
                                            Localizations.localeOf(
                                                context)
                                                .languageCode
                                                .toString() ==
                                                'ar'
                                                ? mySubscriptionController
                                                .subscriptoinMealConfig
                                                .value
                                                .meals[index]
                                                .items[indx]
                                                .arabicName
                                                : mySubscriptionController
                                                .subscriptoinMealConfig
                                                .value
                                                .meals[index]
                                                .items[indx]
                                                .name,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: getBodyMediumStyle(
                                                context)
                                                .copyWith(
                                              fontWeight: APPSTYLE_FontWeightBold,
                                                color:
                                                APPSTYLE_Grey80),
                                          ),
                                          addVerticalSpace(
                                              APPSTYLE_SpaceExtraSmall),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                        '${mySubscriptionController.subscriptoinMealConfig.value.meals[index].items[indx].carbs} Carbs',
                                                        style: getLabelLargeStyle(
                                                            context) ),
                                                  )),
                                              addHorizontalSpace(
                                                  APPSTYLE_SpaceSmall),
                                              Expanded(
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                        '${mySubscriptionController.subscriptoinMealConfig.value.meals[index].items[indx].fat} Fat',
                                                        style: getLabelLargeStyle(
                                                            context) ),
                                                  )),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                        '${mySubscriptionController.subscriptoinMealConfig.value.meals[index].items[indx].protien} Prot',
                                                        style: getLabelLargeStyle(
                                                            context) ),
                                                  )),
                                              addHorizontalSpace(
                                                  APPSTYLE_SpaceSmall),
                                              Expanded(
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                        '${mySubscriptionController.subscriptoinMealConfig.value.meals[index].items[indx].calories} Cal',
                                                        style: getLabelLargeStyle(
                                                            context) ),
                                                  )),
                                            ],
                                          ),
                                          addVerticalSpace(
                                              APPSTYLE_SpaceExtraSmall),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                        '${mySubscriptionController.subscriptoinMealConfig.value.meals[index].items[indx].rating} ⭐',
                                                        style: getBodyMediumStyle(
                                                            context)
                                                            .copyWith(
                                                            fontWeight:
                                                            APPSTYLE_FontWeightBold)),
                                                  )),
                                              addHorizontalSpace(
                                                  APPSTYLE_SpaceSmall),
                                              Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      mySubscriptionController
                                                          .addOrRemoveMeal(
                                                          mySubscriptionController
                                                              .subscriptoinMealConfig
                                                              .value
                                                              .meals[
                                                          index]
                                                              .id,
                                                          mySubscriptionController
                                                              .subscriptoinMealConfig
                                                              .value
                                                              .meals[
                                                          index]
                                                              .items[indx]
                                                              .id);
                                                    },
                                                    child: Container(
                                                      decoration:
                                                      APPSTYLE_BorderedContainerExtraSmallDecoration
                                                          .copyWith(
                                                          color:
                                                          mySubscriptionController
                                                              .isMealAlreadySelected(
                                                              mySubscriptionController
                                                                  .subscriptoinMealConfig
                                                                  .value
                                                                  .meals[
                                                              index]
                                                                  .id,
                                                              mySubscriptionController
                                                                  .subscriptoinMealConfig
                                                                  .value
                                                                  .meals[
                                                              index]
                                                                  .items[indx]
                                                                  .id)?APPSTYLE_Black:APPSTYLE_PrimaryColor),
                                                      padding: EdgeInsets.symmetric(
                                                          vertical:
                                                          APPSTYLE_BorderRadiusExtraSmall *
                                                              .5,
                                                          horizontal:
                                                          APPSTYLE_SpaceSmall),
                                                      child: FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        child: Text(
                                                          mySubscriptionController
                                                              .isMealAlreadySelected(
                                                              mySubscriptionController
                                                                  .subscriptoinMealConfig
                                                                  .value
                                                                  .meals[
                                                              index]
                                                                  .id,
                                                              mySubscriptionController
                                                                  .subscriptoinMealConfig
                                                                  .value
                                                                  .meals[
                                                              index]
                                                                  .items[indx]
                                                                  .id)?"remove".tr:"add".tr,
                                                          textAlign: TextAlign
                                                              .center,
                                                          style: getBodyMediumStyle(
                                                              context)
                                                              .copyWith(
                                                              color:
                                                              APPSTYLE_BackgroundWhite),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),

                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
              Visibility(
                visible: !mySubscriptionController.isMealsFetching.value && !mySubscriptionController.isFreezing.value &&
                    mySubscriptionController
                        .subscriptoinMealConfig.value.meals.isNotEmpty && mySubscriptionController
                    .subscriptionDates[mySubscriptionController.selectedDate.value] == VALIDSUBSCRIPTIONDAY_STATUS.delivered,
                child: Expanded(
                  child: ListView.builder(
                      itemCount: mySubscriptionController
                          .subscriptoinMealConfig.value.meals.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding:
                          APPSTYLE_MediumPaddingVertical.copyWith(top: 0),
                          child: Wrap(
                            children: [
                              Padding(
                                padding: APPSTYLE_LargePaddingHorizontal,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            Localizations.localeOf(context)
                                                .languageCode
                                                .toString() ==
                                                'ar'
                                                ? mySubscriptionController
                                                .subscriptoinMealConfig
                                                .value
                                                .meals[index]
                                                .arabicName
                                                : mySubscriptionController
                                                .subscriptoinMealConfig
                                                .value
                                                .meals[index]
                                                .name,
                                            style: getHeadlineMediumStyle(
                                                context)
                                                .copyWith(
                                                fontWeight:
                                                APPSTYLE_FontWeightBold)),
                                        Container(
                                          width: 30,
                                          height: 2,
                                          color: APPSTYLE_Grey80,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: APPSTYLE_LargePaddingHorizontal.copyWith(top:APPSTYLE_SpaceMedium),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: mySubscriptionController
                                      .subscriptoinMealConfig
                                      .value
                                      .meals[index]
                                      .items.where((element) => element.isSelected).toList()
                                      .length,
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 0,
                                      crossAxisSpacing:
                                      APPSTYLE_SpaceMedium,
                                      mainAxisExtent: screenheight * 0.35),
                                  itemBuilder: (context, indx) {
                                    return Container(
                                      decoration:
                                      APPSTYLE_BorderedContainerSmallDecoration
                                          .copyWith(
                                        color: APPSTYLE_Grey20,
                                      ),
                                      padding: APPSTYLE_SmallPaddingAll,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Container(
                                              decoration: APPSTYLE_BorderedContainerDarkMediumDecoration
                                                  .copyWith(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      APPSTYLE_BorderRadiusSmall),
                                                  color:
                                                  APPSTYLE_Grey20,
                                                  image: DecorationImage(image: getProductImage(mySubscriptionController
                                                      .subscriptoinMealConfig
                                                      .value
                                                      .meals[
                                                  index]
                                                      .items.where((element) => element.isSelected).toList()[
                                                  indx]
                                                      .image),fit: BoxFit.cover),
                                                  border: Border.all(
                                                      color:
                                                      APPSTYLE_BackgroundWhite,
                                                      width: 0.0)),
                                              width: screenwidth * .4,
                                              height: screenwidth * .35,
                                              clipBehavior:
                                              Clip.hardEdge ),
                                          addVerticalSpace(
                                              APPSTYLE_SpaceExtraSmall),
                                          Text(
                                            Localizations.localeOf(
                                                context)
                                                .languageCode
                                                .toString() ==
                                                'ar'
                                                ? mySubscriptionController
                                                .subscriptoinMealConfig
                                                .value
                                                .meals[index]
                                                .items.where((element) => element.isSelected).toList()[indx]
                                                .arabicName
                                                : mySubscriptionController
                                                .subscriptoinMealConfig
                                                .value
                                                .meals[index]
                                                .items.where((element) => element.isSelected).toList()[indx]
                                                .name,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: getBodyMediumStyle(
                                                context)
                                                .copyWith(
                                              fontWeight: APPSTYLE_FontWeightBold,
                                                color:
                                                APPSTYLE_Grey80),
                                          ),
                                          addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                        '${mySubscriptionController.subscriptoinMealConfig.value.meals[index].items.where((element) => element.isSelected).toList()[indx].carbs} Carbs',
                                                        style: getLabelLargeStyle(
                                                            context) ),
                                                  )),
                                              addHorizontalSpace(
                                                  APPSTYLE_SpaceSmall),
                                              Expanded(
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                        '${mySubscriptionController.subscriptoinMealConfig.value.meals[index].items.where((element) => element.isSelected).toList()[indx].fat} Fat',
                                                        style: getLabelLargeStyle(
                                                            context) ),
                                                  )),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                        '${mySubscriptionController.subscriptoinMealConfig.value.meals[index].items.where((element) => element.isSelected).toList()[indx].protien} Prot',
                                                        style: getLabelLargeStyle(
                                                            context) ),
                                                  )),
                                              addHorizontalSpace(
                                                  APPSTYLE_SpaceSmall),
                                              Expanded(
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                        '${mySubscriptionController.subscriptoinMealConfig.value.meals[index].items.where((element) => element.isSelected).toList()[indx].calories} Cal',
                                                        style: getLabelLargeStyle(
                                                            context) ),
                                                  )),
                                            ],
                                          ),
                                          addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                        '${mySubscriptionController.subscriptoinMealConfig.value.meals[index].items.where((element) => element.isSelected).toList()[indx].rating}',
                                                        style: getBodyMediumStyle(
                                                            context)
                                                            .copyWith(
                                                            fontWeight:
                                                            APPSTYLE_FontWeightBold)),
                                                  )),
                                              addHorizontalSpace(
                                                  APPSTYLE_SpaceSmall),
                                              Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      mySubscriptionController
                                                          .addOrRemoveMeal(
                                                          mySubscriptionController
                                                              .subscriptoinMealConfig
                                                              .value
                                                              .meals[
                                                          index]
                                                              .id,
                                                          mySubscriptionController
                                                              .subscriptoinMealConfig
                                                              .value
                                                              .meals[
                                                          index]
                                                              .items.where((element) => element.isSelected).toList()[indx]
                                                              .id);
                                                    },
                                                    child: Container(
                                                      decoration:
                                                      APPSTYLE_BorderedContainerExtraSmallDecoration
                                                          .copyWith(
                                                          color: APPSTYLE_WhatsappGreen),
                                                      padding: EdgeInsets.symmetric(
                                                          vertical:
                                                          APPSTYLE_BorderRadiusExtraSmall *
                                                              .5,
                                                          horizontal:
                                                          APPSTYLE_SpaceSmall),
                                                      child: FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        child: Text( "delivered_single".tr,
                                                          textAlign: TextAlign
                                                              .center,
                                                          style: getBodyMediumStyle(
                                                              context)
                                                              .copyWith(
                                                              color:
                                                              APPSTYLE_BackgroundWhite),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),

                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
              Visibility(
                visible:!mySubscriptionController.isMealsFetching.value && !mySubscriptionController.isFreezing.value && mySubscriptionController
                    .subscriptionDates[mySubscriptionController.selectedDate.value] == VALIDSUBSCRIPTIONDAY_STATUS.offDay,
                child: Expanded(
                    child: Padding(
                      padding: APPSTYLE_LargePaddingAll,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1000),
                                  color: APPSTYLE_Grey20,
                                ),
                                width: screenwidth * .3,
                                height: screenwidth * .3,
                                child: Center(
                                  child: Icon(Ionicons.close_circle_outline,
                                      size: screenwidth * .15,
                                      color: APPSTYLE_Grey80),
                                ),
                              )
                            ],
                          ),
                          addVerticalSpace(APPSTYLE_SpaceLarge),
                          Text("off-day".tr,
                              textAlign: TextAlign.center,
                              style: getHeadlineMediumStyle(context)),
                        ],
                      ),
                    )),
              ),
              Visibility(
                visible:!mySubscriptionController.isMealsFetching.value && !mySubscriptionController.isFreezing.value && mySubscriptionController
                    .subscriptionDates[mySubscriptionController.selectedDate.value] == VALIDSUBSCRIPTIONDAY_STATUS.freezed,
                child: Expanded(
                    child: Padding(
                      padding: APPSTYLE_LargePaddingAll,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1000),
                                  color: APPSTYLE_Grey20,
                                ),
                                width: screenwidth * .3,
                                height: screenwidth * .3,
                                child: Center(
                                  child: Icon(Ionicons.pause_circle_outline,
                                      size: screenwidth * .15,
                                      color: APPSTYLE_Grey80),
                                ),
                              )
                            ],
                          ),
                          addVerticalSpace(APPSTYLE_SpaceLarge),
                          Text("freezed".tr,
                              textAlign: TextAlign.center,
                              style: getHeadlineMediumStyle(context)),
                        ],
                      ),
                    )),
              ),
              Visibility(
                visible: mySubscriptionController.isMealsFetching.value ||  mySubscriptionController.isFreezing.value ,
                child: MealSelectionTitleLoader()
              ),
              Visibility(
                visible: mySubscriptionController.isMealsFetching.value ||  mySubscriptionController.isFreezing.value ,
                child: Expanded(
                  child: MealSelectionItemsLoader(),
                ),
              ),
              Visibility(
                visible: !mySubscriptionController.isMealsFetching.value &&  !mySubscriptionController.isFreezing.value &&
                    mySubscriptionController
                        .subscriptoinMealConfig.value.meals.isNotEmpty &&
                    mySubscriptionController
                        .subscriptionDates[mySubscriptionController.selectedDate.value] != VALIDSUBSCRIPTIONDAY_STATUS.offDay &&
                    mySubscriptionController
                        .subscriptionDates[mySubscriptionController.selectedDate.value] != VALIDSUBSCRIPTIONDAY_STATUS.freezed,
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: APPSTYLE_ContainerTopShadow,
                      color: APPSTYLE_BackgroundWhite),
                  padding: APPSTYLE_LargePaddingHorizontal.copyWith(
                      top: APPSTYLE_SpaceSmall, bottom: APPSTYLE_SpaceSmall),
                  child: Row(
                    children: [
                      CircularPercentIndicator(
                        radius: 20.0,
                        lineWidth: 5.0,
                        percent: getPercentage(
                                mySubscriptionController.subscriptoinMealConfig
                                    .value.recommendedCalories,
                                mySubscriptionController.selectedMealConfig
                                    .value.recommendedCalories) /
                            100,
                        center: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            getPercentage(
                                    mySubscriptionController
                                        .subscriptoinMealConfig
                                        .value
                                        .recommendedCalories,
                                    mySubscriptionController.selectedMealConfig
                                        .value.recommendedCalories)
                                .toString(),
                            style: getLabelSmallStyle(context)
                                .copyWith(color: APPSTYLE_PrimaryColor),
                          ),
                        ),
                        progressColor: APPSTYLE_PrimaryColor,
                      ),
                      addHorizontalSpace(APPSTYLE_SpaceMedium),
                      Expanded(
                          child: Text(
                        "${mySubscriptionController.selectedMealConfig.value.recommendedCalories} Cal",
                        style: getHeadlineLargeStyle(context),
                      )),
                      Visibility(
                        visible: (mySubscriptionController
                            .subscriptionDates[mySubscriptionController.selectedDate.value]!=VALIDSUBSCRIPTIONDAY_STATUS.delivered &&
                            mySubscriptionController
                                .subscriptionDates[mySubscriptionController.selectedDate.value]!=VALIDSUBSCRIPTIONDAY_STATUS.freezed &&
                            mySubscriptionController
                                .subscriptionDates[mySubscriptionController.selectedDate.value]!=VALIDSUBSCRIPTIONDAY_STATUS.offDay  ),
                        child: SizedBox(
                            width: screenwidth * .4,
                            child: ElevatedButton(
                                child: mySubscriptionController
                                        .isDayMealSaving.value
                                    ? LoadingAnimationWidget.staggeredDotsWave(
                                        color: APPSTYLE_BackgroundWhite,
                                        size: 24,
                                      )
                                    : Text('save'.tr,
                                        style: getHeadlineMediumStyle(context)
                                            .copyWith(
                                                color: APPSTYLE_BackgroundWhite,
                                                fontWeight:
                                                    APPSTYLE_FontWeightBold),
                                        textAlign: TextAlign.center),
                                onPressed: () {
                                  if(!mySubscriptionController.isDayMealSaving.value &&
                                  !mySubscriptionController.isMealsFetching.value ){
                                    mySubscriptionController.setMealsByDate();
                                  }
                                })),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  String getCalendarDayText(int index) {
    if (index < 7) {
      return getDayNameByIndex(index);
    }
    if (index == 7) {
      return "31";
    }
    if (index < 39) {
      if ((index - 7) < 10) {
        return '0${(index - 7).toString()}';
      }
      return (index - 7).toString();
    }
    if ((index - 38) < 10) {
      return '0${(index - 38).toString()}';
    }
    return (index - 38).toString();
  }

  getCalendarDayTextColor(int index) {
    if (index < 7) {
      return APPSTYLE_Black;
    }
    if (index == 7) {
      return APPSTYLE_Grey40;
    }
    if (index > 38) {
      return APPSTYLE_Grey40;
    }
    return APPSTYLE_PrimaryColorBg;
  }

  getProductImage(image) {
    return (image == ASSETS_SAMPLEFOOD)
        ? AssetImage(ASSETS_SAMPLEFOOD)
        : NetworkImage(image);
  }

  int getPercentage(
      double recommendedCalories, double currentSelectedCalories2) {
    if (recommendedCalories == 0.0) {
      return 0;
    }
    double percentage = (currentSelectedCalories2 * 100) / recommendedCalories;
    if (percentage > 100) {
      return 100;
    }
    if (percentage < 0) {
      return  percentage.round() * -1;
    }
    return percentage.round();
  }


  Future<void> scrollToDate() async {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(_scrollController.hasClients){
        _scrollController.jumpTo(
            mySubscriptionController.subscriptionDates.keys.toList().indexOf(mySubscriptionController.selectedDate.value)*46  );
      }
    });
  }


  void showFreezeConfirmDialogue(BuildContext context ) async {

    final dialogTitleWidget = Text(mySubscriptionController.subscriptionDates[mySubscriptionController.selectedDate.value] != VALIDSUBSCRIPTIONDAY_STATUS.freezed?
    'sub_freeze_title'.tr:'sub_unfreeze_title'.tr,style: getHeadlineMediumStyle(context).copyWith(
        color: APPSTYLE_Grey80,fontWeight: APPSTYLE_FontWeightBold));
    final dialogTextWidget = Text(  mySubscriptionController.subscriptionDates[mySubscriptionController.selectedDate.value] != VALIDSUBSCRIPTIONDAY_STATUS.freezed?
    'sub_freeze_content'.tr:'sub_unfreeze_content'.tr,style: getBodyMediumStyle(context),
    );

    final updateButtonTextWidget = Text('yes'.tr,style: TextStyle(color: APPSTYLE_PrimaryColor),);
    final updateButtonCancelTextWidget = Text('no'.tr,style: TextStyle(color: APPSTYLE_Black),);

    updateLogoutAction() async {
      mySubscriptionController.freezeSubscription(mySubscriptionController.selectedDate.value,
          mySubscriptionController.subscriptionDates[mySubscriptionController.selectedDate.value] != VALIDSUBSCRIPTIONDAY_STATUS.freezed);
      Get.back();
    }

    updateAction() {
      Navigator.pop(context);
    }
    List<Widget> actions = [

      TextButton(
          onPressed:updateAction,
          style: APPSTYLE_TextButtonStylePrimary.copyWith(padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(
                  horizontal: APPSTYLE_SpaceLarge,
                  vertical: APPSTYLE_SpaceSmall))),
          child:  updateButtonCancelTextWidget),

      TextButton(
          onPressed:updateLogoutAction,
          style: APPSTYLE_TextButtonStylePrimary.copyWith(padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(
                  horizontal: APPSTYLE_SpaceLarge,
                  vertical: APPSTYLE_SpaceSmall))),
          child:  updateButtonTextWidget),
    ];

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            child: AlertDialog(
              title: dialogTitleWidget,
              content: dialogTextWidget,
              actions: actions,
            ),
            onWillPop: () => Future.value(false));
      },
    );
  }

}
