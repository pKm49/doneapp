import 'package:doneapp/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:doneapp/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/calendar_utilities.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:doneapp/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:doneapp/shared_module/ui/components/custom_curve_shape.component.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MealSelectionPage_MySubscription extends StatefulWidget {
  const MealSelectionPage_MySubscription({super.key});

  @override
  State<MealSelectionPage_MySubscription> createState() => _MealSelectionPage_MySubscriptionState();
}

class _MealSelectionPage_MySubscriptionState extends State<MealSelectionPage_MySubscription> {
  List<int> selectedIndex = [20, 21, 22, 23, 24];

  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return   Scaffold(
      resizeToAvoidBottomInset: true,
      appBar:AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation:0.0,
        backgroundColor: APPSTYLE_BackgroundWhite,
        elevation: 0.0,
        title: Row(
          children: [
            CustomBackButton(isPrimaryMode:false),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'select_meal'.tr,
                  style: getHeadlineLargeStyle(context).copyWith(
                      fontWeight: APPSTYLE_FontWeightBold),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
        actions: [
          InkWell(
            onTap: (){
              Get.toNamed(AppRouteNames.freezeSubscriptionRoute);
            },
            child: Container(
              width: screenwidth*.25,
              decoration: APPSTYLE_ShadowedContainerExtraSmallDecoration.
              copyWith(
                boxShadow: [
                  const BoxShadow(
                    color: APPSTYLE_Grey80Shadow24,
                    offset: Offset(0, 3.0),
                    blurRadius: APPSTYLE_BlurRadiusLarge,
                  ),
                ],

                gradient: const LinearGradient(
                    colors: [Color(0xFFF46A6A), APPSTYLE_PrimaryColor],
                    tileMode: TileMode.clamp),
              ),
              padding: EdgeInsets.symmetric(
                  vertical: APPSTYLE_SpaceSmall,horizontal: APPSTYLE_SpaceSmall
              ),
              child: Row(
                children: [
                  Icon(Ionicons.pause,color: APPSTYLE_BackgroundWhite,
                      size: APPSTYLE_FontSize16),
                  addHorizontalSpace(APPSTYLE_SpaceExtraSmall),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "pause".tr,
                        style: getBodyMediumStyle(context)
                            .copyWith(
                            color:
                            APPSTYLE_BackgroundWhite),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          addHorizontalSpace(APPSTYLE_SpaceLarge)
        ],
      ) ,
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            addVerticalSpace(APPSTYLE_SpaceMedium),
            Padding(
              padding: APPSTYLE_LargePaddingHorizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var i = 0; i <= 6; i++)
                      InkWell(
                        onTap: (){
                          selectedItem = i;
                          setState(() {

                          });
                        },
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          direction: Axis.vertical,
                          spacing: APPSTYLE_SpaceSmall,
                          children: [
                            Text(
                              getDayNameByIndex(i),
                              style: getLabelSmallStyle(context).copyWith(
                                  color: APPSTYLE_Grey80),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: selectedItem == i
                                    ? APPSTYLE_PrimaryColor
                                    :  APPSTYLE_BackgroundOffWhite,
                                borderRadius:
                                BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),
                                border: Border.all(color: APPSTYLE_Grey60, width: .4),
                              ),
                              width: screenwidth * .12,
                              padding: APPSTYLE_ExtraSmallPaddingAll.copyWith(
                                  top: APPSTYLE_SpaceSmall, bottom: APPSTYLE_SpaceSmall),
                              margin: APPSTYLE_ExtraSmallPaddingHorizontal,
                              child: Center(
                                child: Column(
                                  children: [

                                    Text(
                                      '0${i + 1}',
                                      style: getBodyMediumStyle(context).copyWith(
                                          fontWeight: APPSTYLE_FontWeightBold,
                                          color: selectedItem == i
                                              ? APPSTYLE_BackgroundWhite
                                              : APPSTYLE_PrimaryColorBg),
                                    ),

                                    Icon(
                                      Ionicons.checkmark,
                                      size: APPSTYLE_FontSize14,
                                      color:selectedItem == i
                                          ? APPSTYLE_BackgroundWhite
                                          : APPSTYLE_PrimaryColorBg ,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  addVerticalSpace(APPSTYLE_SpaceLarge),
                  Padding(
                    padding: APPSTYLE_LargePaddingHorizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Breakfast",style: getHeadlineMediumStyle(context).copyWith(
                              fontWeight: APPSTYLE_FontWeightBold
                            )),
                            Container(
                              width: 30,
                              height: 2,
                              color: APPSTYLE_Grey80,
                            ),
                          ],
                        ),

                        Container(
                          decoration: APPSTYLE_BorderedContainerLargeDecoration.copyWith(
                            color: APPSTYLE_PrimaryColor
                          ),
                          padding: EdgeInsets.symmetric(vertical: APPSTYLE_BorderRadiusExtraSmall*.5,horizontal: APPSTYLE_SpaceSmall),
                          child: Text("1/1 Item",style: getBodyMediumStyle(context).copyWith(color: APPSTYLE_BackgroundWhite),),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: APPSTYLE_LargePaddingHorizontal,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 8,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: APPSTYLE_SpaceMedium,
                          mainAxisExtent:
                          screenheight * 0.3),
                      itemBuilder: (context, index) {
                        return  Container(
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                height: screenheight*.4,
                                margin: const EdgeInsets.only(top:50),
                                decoration: APPSTYLE_BorderedContainerSmallDecoration.copyWith(
                                  color:APPSTYLE_Grey20,
                                ),
                              ),

                              Container(
                                height: screenheight*.4,
                                padding: APPSTYLE_MediumPaddingAll,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        decoration: APPSTYLE_BorderedContainerDarkMediumDecoration.copyWith(
                                            image: DecorationImage(
                                              alignment: Alignment(-.2, 0),
                                              image: AssetImage(ASSETS_SAMPLEFOOD),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.circular(1000),
                                            color: APPSTYLE_BackgroundWhite,
                                          border: Border.all(color: APPSTYLE_PrimaryColorBg, width: 3)
                                        ),
                                        padding: APPSTYLE_SmallPaddingAll,
                                        width: screenwidth*.3,
                                        height: screenwidth*.3,
                                        clipBehavior: Clip.hardEdge),
                                    addVerticalSpace(APPSTYLE_SpaceSmall),
                                    Text("2 Diet d as dasd asd sad sa dMeals",
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: getLabelLargeStyle(context).copyWith(
                                          color: APPSTYLE_Grey80 ),
                                    ),
                                    addVerticalSpace(APPSTYLE_SpaceSmall),
                                    Row(
                                      children: [
                                        Expanded(child: FittedBox(
                                          fit:BoxFit.scaleDown,
                                          child: Text("123 Cal",style: getBodyMediumStyle(context).copyWith(
                                            fontWeight: APPSTYLE_FontWeightBold
                                          )),
                                        )),
                                        Expanded(child:  Container(
                                          decoration: APPSTYLE_BorderedContainerExtraSmallDecoration.copyWith(
                                              color: APPSTYLE_PrimaryColor
                                          ),
                                          padding: EdgeInsets.symmetric(vertical: APPSTYLE_BorderRadiusExtraSmall*.5,horizontal: APPSTYLE_SpaceSmall),
                                          child: Text("add".tr,
                        textAlign: TextAlign.center,
                                            style: getBodyMediumStyle(context).copyWith(
                                                color: APPSTYLE_BackgroundWhite),),
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
                  addVerticalSpace(APPSTYLE_SpaceLarge)
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: APPSTYLE_ContainerTopShadow,
                color: APPSTYLE_BackgroundWhite
              ),
                padding: APPSTYLE_LargePaddingHorizontal.copyWith(top: APPSTYLE_SpaceSmall,bottom: APPSTYLE_SpaceSmall),
              child: Row(
                children: [
                  CircularPercentIndicator(
                    radius: 20.0,
                    lineWidth: 5.0,
                    percent: 0.7,
                    center: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: new Text("74%",style: getLabelSmallStyle(context).copyWith(color: APPSTYLE_PrimaryColor),),
                    ),
                    progressColor: APPSTYLE_PrimaryColor,
                  ),
                  addHorizontalSpace(APPSTYLE_SpaceMedium),
                  Expanded(child: Text("585 Cal",style: getHeadlineLargeStyle(context),)),
                  SizedBox(
                      width: screenwidth*.4,
                      child: ElevatedButton(
                          style: ButtonStyle(

                          ),
                          child:   Text('done'.tr,
                              style: getHeadlineMediumStyle(context).copyWith(
                                  color: APPSTYLE_BackgroundWhite,fontWeight: APPSTYLE_FontWeightBold),
                              textAlign: TextAlign.center),
                          onPressed: () {
                            Get.toNamed(AppRouteNames.registerEnglishNameRoute);
                          })),
                ],
              ),
            )
          ],
        ),
      )),
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

}
