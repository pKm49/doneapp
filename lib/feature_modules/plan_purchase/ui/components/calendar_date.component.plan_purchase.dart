 
 import 'package:doneapp/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:flutter/material.dart';

class  CalendarDateComponent_PlanPurchase extends StatelessWidget {

  Color borderColor;
  String dateText;
  String status;
  bool isSelected;
  bool isMonthDay;

  bool isSubscriptionDay;
  CalendarDateComponent_PlanPurchase({super.key,required this.isSubscriptionDay,required this.isSelected,required this.isMonthDay,
    required this.borderColor ,  required this.status ,   required this.dateText});

  @override
  Widget build(BuildContext context) {

    return Container(
        height: 30 + (APPSTYLE_SpaceExtraSmall * 2),
        decoration:   BoxDecoration(
            borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),
            color:
          isSelected ?APPSTYLE_GuideYellow:APPSTYLE_Grey20
        ),
        margin: EdgeInsets.only(right:APPSTYLE_SpaceExtraSmall / 2),
        padding: EdgeInsets.only(
            bottom: APPSTYLE_SpaceExtraSmall,
            top: APPSTYLE_SpaceExtraSmall),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              dateText,
              textAlign: TextAlign.center,
              style: getBodyMediumStyle(context)
                  .copyWith(
                  color:
                  (isMonthDay && isSubscriptionDay) ? APPSTYLE_PrimaryColor:
                  isMonthDay ? APPSTYLE_Grey60:APPSTYLE_Grey40
              ),
            ),


          ],
        ));
  }
}
