import 'package:doneapp/feature_modules/my_subscription/controller/my_subscription.controller.dart';
import 'package:doneapp/feature_modules/my_subscription/ui/components/meal_calendar_date_mealselection.my_subscription.dart';
import 'package:doneapp/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:doneapp/shared_module/constants/style_params.constants.shared.dart';
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
              visible: !mySubscriptionController.isMealsFetching.value,
              child: InkWell(
                onTap: () {
                  if(!mySubscriptionController.isDayMealSaving.value &&
                      !mySubscriptionController.isMealsFetching.value ){
                    Get.toNamed(AppRouteNames.freezeSubscriptionRoute);
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
                  child: Row(
                    children: [
                      Icon(Ionicons.pause,
                          color: APPSTYLE_BackgroundWhite,
                          size: APPSTYLE_FontSize16),
                      addHorizontalSpace(APPSTYLE_SpaceExtraSmall),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "pause".tr,
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
                visible: !mySubscriptionController.isMealsFetching.value &&
                    mySubscriptionController
                        .subscriptoinMealConfig.value.meals.isNotEmpty,
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
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: APPSTYLE_LargePaddingHorizontal,
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
                                              APPSTYLE_SpaceMedium,
                                          mainAxisExtent: screenheight * 0.3),
                                  itemBuilder: (context, indx) {
                                    return Container(
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          Container(
                                            height: screenheight * .4,
                                            margin:
                                                const EdgeInsets.only(top: 50),
                                            decoration:
                                                APPSTYLE_BorderedContainerSmallDecoration
                                                    .copyWith(
                                              color: APPSTYLE_Grey20,
                                            ),
                                          ),
                                          Container(
                                            height: screenheight * .4,
                                            padding: APPSTYLE_MediumPaddingAll,
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
                                                            image:
                                                                DecorationImage(
                                                              alignment:
                                                                  Alignment(
                                                                      -.2, 0),
                                                              image: getProductImage(
                                                                  mySubscriptionController
                                                                      .subscriptoinMealConfig
                                                                      .value
                                                                      .meals[
                                                                          index]
                                                                      .items[
                                                                          indx]
                                                                      .image),
                                                              fit: BoxFit.cover,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        1000),
                                                            color:
                                                                APPSTYLE_BackgroundWhite,
                                                            border: Border.all(
                                                                color:
                                                                    APPSTYLE_PrimaryColorBg,
                                                                width: 3)),
                                                    padding:
                                                        APPSTYLE_SmallPaddingAll,
                                                    width: screenwidth * .3,
                                                    height: screenwidth * .3,
                                                    clipBehavior:
                                                        Clip.hardEdge),
                                                addVerticalSpace(
                                                    APPSTYLE_SpaceSmall),
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
                                                  style: getLabelLargeStyle(
                                                          context)
                                                      .copyWith(
                                                          color:
                                                              APPSTYLE_Grey80),
                                                ),
                                                addVerticalSpace(
                                                    APPSTYLE_SpaceSmall),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                          '${mySubscriptionController.subscriptoinMealConfig.value.meals[index].items[indx].calories} Cal',
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
                                                )
                                              ],
                                            ),
                                          )
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
                visible: mySubscriptionController.isMealsFetching.value,
                child: Padding(
                  padding: APPSTYLE_LargePaddingHorizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Shimmer.fromColors(
                        baseColor: APPSTYLE_Grey20,
                        highlightColor: APPSTYLE_Grey40,
                        child: Container(
                          decoration:
                              APPSTYLE_BorderedContainerExtraSmallDecoration
                                  .copyWith(color: APPSTYLE_Grey20),
                          height: 30,
                          width: screenwidth * .3,
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: APPSTYLE_Grey20,
                        highlightColor: APPSTYLE_Grey40,
                        child: Container(
                          decoration:
                              APPSTYLE_BorderedContainerExtraSmallDecoration
                                  .copyWith(color: APPSTYLE_Grey20),
                          height: 30,
                          width: screenwidth * .2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: mySubscriptionController.isMealsFetching.value,
                child: Expanded(
                  child: Padding(
                    padding: APPSTYLE_LargePaddingHorizontal,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 6,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: APPSTYLE_SpaceMedium,
                          mainAxisExtent: screenheight * 0.3),
                      itemBuilder: (context, indx) {
                        return Container(
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                height: screenheight * .4,
                                margin: const EdgeInsets.only(top: 50),
                                decoration:
                                    APPSTYLE_BorderedContainerSmallDecoration
                                        .copyWith(
                                  color: APPSTYLE_Grey20,
                                ),
                              ),
                              Container(
                                height: screenheight * .4,
                                padding: APPSTYLE_MediumPaddingAll,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: APPSTYLE_Grey20,
                                      highlightColor: APPSTYLE_Grey40,
                                      child: Container(
                                          decoration:
                                              APPSTYLE_BorderedContainerDarkMediumDecoration
                                                  .copyWith(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              1000),
                                                      color:
                                                          APPSTYLE_BackgroundWhite,
                                                      border: Border.all(
                                                          color:
                                                              APPSTYLE_PrimaryColorBg,
                                                          width: 3)),
                                          padding: APPSTYLE_SmallPaddingAll,
                                          width: screenwidth * .3,
                                          height: screenwidth * .3,
                                          clipBehavior: Clip.hardEdge),
                                    ),
                                    addVerticalSpace(APPSTYLE_SpaceSmall),
                                    Shimmer.fromColors(
                                      baseColor: APPSTYLE_Grey20,
                                      highlightColor: APPSTYLE_Grey40,
                                      child: Container(
                                        decoration:
                                            APPSTYLE_ShadowedContainerExtraSmallDecoration
                                                .copyWith(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            APPSTYLE_BlurRadiusSmall),
                                                    color: APPSTYLE_Grey20),
                                        height: 20,
                                        width: screenwidth * .25,
                                      ),
                                    ),
                                    addVerticalSpace(APPSTYLE_SpaceSmall),
                                    Shimmer.fromColors(
                                      baseColor: APPSTYLE_Grey20,
                                      highlightColor: APPSTYLE_Grey40,
                                      child: Container(
                                        decoration:
                                            APPSTYLE_ShadowedContainerExtraSmallDecoration
                                                .copyWith(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            APPSTYLE_BlurRadiusSmall),
                                                    color: APPSTYLE_Grey20),
                                        height: 20,
                                        width: screenwidth * .25,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: !mySubscriptionController.isMealsFetching.value &&
                    mySubscriptionController
                        .subscriptoinMealConfig.value.meals.isNotEmpty,
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
                      SizedBox(
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
}
