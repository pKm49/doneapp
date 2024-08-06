import 'package:doneapp/shared_module/constants/app_route_names.constants.shared.dart';
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

class FreezeSubscriptionPage_MySubscription extends StatefulWidget {
  const FreezeSubscriptionPage_MySubscription({super.key});

  @override
  State<FreezeSubscriptionPage_MySubscription> createState() => _FreezeSubscriptionPage_MySubscriptionState();
}

class _FreezeSubscriptionPage_MySubscriptionState extends State<FreezeSubscriptionPage_MySubscription> {
  List<int> selectedIndex = [20, 21, 22, 23, 24];

  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return   Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: APPSTYLE_PrimaryColorBg,
        scrolledUnderElevation:0.0,
        elevation: 0.0,
        title: Row(
          children: [
            CustomBackButton(isPrimaryMode: false),
          ],
        ),
        actions: [

        ],
      ),
      body: SafeArea(child: Container(
        child: Column(
          children: [
            CustomCurveShapeComponent_Shared(
              color: APPSTYLE_PrimaryColorBg,
              title: "freeze_sub".tr ,
            ),
            Expanded(
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: APPSTYLE_ShadowedContainerSmallDecoration.copyWith(
                          boxShadow:  [
                            const BoxShadow(
                              color: APPSTYLE_Grey80Shadow24,
                              offset: Offset(1.0, 1.0),
                              blurRadius: 2,
                            ),
                          ],
                            border: Border.all(
                                color: Colors.transparent, width: .2),
                            color: APPSTYLE_Grey20),
                        margin: APPSTYLE_LargePaddingAll,
                        padding: APPSTYLE_MediumPaddingAll,
                        height: 350,
                        width: screenwidth-(APPSTYLE_SpaceLarge*2),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                      padding: APPSTYLE_ExtraSmallPaddingAll,
                                      decoration:
                                      APPSTYLE_BorderedContainerExtraSmallDecoration
                                          .copyWith(color: APPSTYLE_BackgroundWhite),
                                      child: Icon(Ionicons.chevron_back,
                                          color: Colors.black)),
                                ),
                                Expanded(
                                    child: Container(
                                      child: Text(
                                        "January 2024",
                                        textAlign: TextAlign.center,
                                        style: getHeadlineMediumStyle(context)
                                            .copyWith(
                                            color: APPSTYLE_PrimaryColorBg,
                                            fontWeight: APPSTYLE_FontWeightBold),
                                      ),
                                    )),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                      padding: APPSTYLE_ExtraSmallPaddingAll,
                                      decoration:
                                      APPSTYLE_BorderedContainerExtraSmallDecoration
                                          .copyWith(color: APPSTYLE_BackgroundWhite),
                                      child: Icon(Ionicons.chevron_forward,
                                          color: Colors.black)),
                                ),
                              ],
                            ),
                            addVerticalSpace(APPSTYLE_SpaceLarge),
                            Expanded(
                                child: GridView.count(
                                    mainAxisSpacing: APPSTYLE_SpaceExtraSmall * .5,
                                    crossAxisSpacing: APPSTYLE_SpaceExtraSmall * .5,
                                    crossAxisCount: 7,
                                    children: List.generate(
                                      42,
                                          (index) {
                                        return InkWell(
                                          onTap: () {
                                            if (selectedIndex
                                                .contains(index)) {
                                              selectedIndex.remove(index);
                                            } else {
                                              selectedIndex.add(index);
                                            }
                                            setState(() {});
                                          },
                                          child: Container(
                                            margin: APPSTYLE_ExtraSmallPaddingAll,
                                            decoration: BoxDecoration(
                                              color: selectedIndex
                                                  .contains(index)
                                                  ? APPSTYLE_GuideYellow
                                                  : Colors.transparent,
                                              border: Border.all(
                                                  color: index == 27
                                                      ? APPSTYLE_PrimaryColorBg
                                                      : Colors.transparent,
                                                  width: .7),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  APPSTYLE_BorderRadiusExtraSmall),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                    getCalendarDayText(index),
                                                    style: getLabelLargeStyle(
                                                        context)
                                                        .copyWith(
                                                        color:selectedIndex
                                                            .contains(index)
                                                            ?APPSTYLE_BackgroundWhite:
                                                        getCalendarDayTextColor(
                                                            index))),
                                                Icon(Ionicons.checkmark,size: 8,color: APPSTYLE_GuideGreen)
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: APPSTYLE_SpaceLarge,vertical: APPSTYLE_SpaceSmall),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {

                  },
                  style: getElevatedButtonStyle(context),
                  child: Text("freeze".tr,
                      style: getHeadlineMediumStyle(context).copyWith(
                          color: APPSTYLE_BackgroundWhite,
                          fontWeight: APPSTYLE_FontWeightBold),
                      textAlign: TextAlign.center),
                ),
              ),
            ),
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
