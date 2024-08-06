import 'package:doneapp/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/calendar_utilities.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:doneapp/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:doneapp/shared_module/ui/components/custom_curve_shape.component.shared.dart';
import 'package:doneapp/shared_module/ui/components/language_preview_button.component.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class MySubscriptionListPage_MySubscription extends StatefulWidget {
  const MySubscriptionListPage_MySubscription({super.key});

  @override
  State<MySubscriptionListPage_MySubscription> createState() => _MySubscriptionListPage_MySubscriptionState();
}

class _MySubscriptionListPage_MySubscriptionState extends State<MySubscriptionListPage_MySubscription> {


  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return   Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation:0.0,
        elevation: 0.0,
        title: Row(
          children: [
            CustomBackButton(isPrimaryMode:false),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'subscriptions'.tr,
                  style: getHeadlineLargeStyle(context).copyWith(
                      fontWeight: APPSTYLE_FontWeightBold),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),

      ),
      body: SafeArea(child: Container(
        child: Container(
          width: screenwidth,
          child: ListView(
            children: [
              Container(
                padding: APPSTYLE_MediumPaddingAll,
                margin: APPSTYLE_LargePaddingAll, 
                decoration: APPSTYLE_ShadowedContainerMediumDecoration,
                child: Column(
                  children: [
                    Text( "Plan Name",
                      style: getHeadlineMediumStyle(context).copyWith(fontWeight: APPSTYLE_FontWeightBold)
                    ),
                    Divider(
                      color: APPSTYLE_Grey20,
                    ),
                    addVerticalSpace(APPSTYLE_SpaceSmall),
                    Container(
                      width: screenwidth-((APPSTYLE_SpaceLarge*2)+(APPSTYLE_SpaceMedium*2)),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: List.generate(
                          3,
                              (index) => IntrinsicWidth(
                            child: Container(
                              decoration:APPSTYLE_BorderedContainerSmallDecoration,
                              padding:APPSTYLE_SmallPaddingAll,
                              child: Row(
                                mainAxisSize:
                                MainAxisSize.min,
                                children: [
                                  Text(
                                      "Breakfast",
                                    style: getBodyMediumStyle(context),
                                  ),
                                  const SizedBox(width: 5),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: APPSTYLE_PrimaryColor,
                                      borderRadius:
                                      BorderRadius
                                          .circular(8),
                                    ),
                                    padding: APPSTYLE_SmallPaddingAll.copyWith(
                                        top: APPSTYLE_SpaceExtraSmall,
                                        bottom: APPSTYLE_SpaceExtraSmall),
                                    child: Text(
                                      "1",
                                      style: const TextStyle(
                                          color:
                                          Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    addVerticalSpace(APPSTYLE_SpaceSmall),
                    Divider(
                      color: APPSTYLE_Grey20,
                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_month),
                        addHorizontalSpace(APPSTYLE_SpaceSmall),
                        Text(
                          "August 5 to September 6 ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
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
