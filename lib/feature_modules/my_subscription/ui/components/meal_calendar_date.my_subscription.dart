 
import 'package:doneapp/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:doneapp/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp/shared_module/constants/valid_subscription_day_status.constants.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';

class MealCalendarDateComponent_MySubscription extends StatelessWidget {

  Color borderColor;
  String dateText;
  String status;
  bool isSelected;
  bool isMonthDay;

  bool isSubscriptionDay;
  MealCalendarDateComponent_MySubscription({super.key,required this.isSubscriptionDay,required this.isSelected,required this.isMonthDay,
    required this.borderColor ,  required this.status ,   required this.dateText});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40 + (APPSTYLE_SpaceExtraSmall * 2),
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
          children: [
            Text(
              dateText,
              textAlign: TextAlign.center,
              style: getBodyMediumStyle(context)
                  .copyWith(
                  color:
                  (isMonthDay && isSubscriptionDay) ? APPSTYLE_PrimaryColor:
                  isMonthDay ?APPSTYLE_Grey60:APPSTYLE_Grey40
              ),
            ),
            addVerticalSpace(APPSTYLE_SpaceExtraSmall),
            Visibility(
              visible: status==VALIDSUBSCRIPTIONDAY_STATUS.offDay &&  (isMonthDay && isSubscriptionDay) ,
              child: Icon(Icons.close,
                  color:APPSTYLE_PrimaryColor
                  , size: 15),
            ),
            Visibility(
              visible:  status==VALIDSUBSCRIPTIONDAY_STATUS.delivered  &&  (isMonthDay && isSubscriptionDay) ,
              child: Icon(Icons.delivery_dining,
                  color:APPSTYLE_WhatsappGreen
                  , size: 15),
            ),
            Visibility(
              visible: status==VALIDSUBSCRIPTIONDAY_STATUS.freezed  &&  (isMonthDay && isSubscriptionDay)  ,
              child: Icon(Icons.pause,
                  color:APPSTYLE_PrimaryColor
                  , size: 15),
            ),
            Visibility(
              visible: status==VALIDSUBSCRIPTIONDAY_STATUS.mealSelected  &&  (isMonthDay && isSubscriptionDay)  ,
              child: Icon(Ionicons.checkmark ,
                  color:APPSTYLE_WhatsappGreen
                  , size: 15),
            ),
            Visibility(
              visible: status==VALIDSUBSCRIPTIONDAY_STATUS.mealNotSelected  &&  (isMonthDay && isSubscriptionDay)  ,
              child: SvgPicture.asset(ASSETS_SELECTHAND,width: 10,color: APPSTYLE_PrimaryColor,)
            ),


          ],
        ));
  }
}
