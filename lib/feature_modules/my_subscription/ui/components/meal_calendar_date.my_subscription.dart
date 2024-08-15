 
import 'package:doneapp/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:doneapp/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp/shared_module/constants/valid_subscription_day_status.constants.shared.dart';
import 'package:doneapp/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
        height: 55 + (APPSTYLE_SpaceExtraSmall * 2),
        decoration:   BoxDecoration(
            borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),
            color:isMonthDay?APPSTYLE_Grey30:APPSTYLE_Grey10,
            border:Border.all(color:  isSelected ?APPSTYLE_Grey80:APPSTYLE_BackgroundWhite, width: .5)
        ),
        margin: EdgeInsets.only(right:APPSTYLE_SpaceExtraSmall ),
        padding: APPSTYLE_ExtraSmallPaddingAll,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              dateText,
              textAlign: TextAlign.center,
              style: getLabelLargeStyle(context)
                  .copyWith(
                  color:
                  (isMonthDay && isSubscriptionDay) ? APPSTYLE_PrimaryColor:
                  isMonthDay ? APPSTYLE_Grey80:APPSTYLE_Grey40
              ),
            ),
             Visibility(
              visible: (status==VALIDSUBSCRIPTIONDAY_STATUS.offDay ) &&  (isMonthDay && isSubscriptionDay) ,
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: const Icon(Icons.close_rounded,
                    color:APPSTYLE_PrimaryColor
                    , size: 14),
              ),
            ),
            Visibility(
              visible: (status==VALIDSUBSCRIPTIONDAY_STATUS.offDay ) &&  (isMonthDay && isSubscriptionDay) ,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text("off-day_single".tr,style: getLabelSmallStyle(context).copyWith(
                  color: APPSTYLE_PrimaryColor
                ),),
              ),
            ),
            Visibility(
              visible:  status==VALIDSUBSCRIPTIONDAY_STATUS.delivered  &&  (isMonthDay && isSubscriptionDay) ,
              child: const Icon(Icons.delivery_dining,
                  color:APPSTYLE_WhatsappGreen
                  , size: 14),
            ),
            Visibility(
              visible: (status==VALIDSUBSCRIPTIONDAY_STATUS.delivered ) &&  (isMonthDay && isSubscriptionDay) ,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text("delivered_single".tr,style: getLabelSmallStyle(context).copyWith(
                    color: APPSTYLE_WhatsappGreen
                ),),
              ),
            ),
            Visibility(
              visible: status==VALIDSUBSCRIPTIONDAY_STATUS.freezed  &&  (isMonthDay && isSubscriptionDay)  ,
              child: const Icon(Icons.pause,
                  color:APPSTYLE_GuideYellow
                  , size: 14),
            ),
            Visibility(
              visible: (status==VALIDSUBSCRIPTIONDAY_STATUS.freezed ) &&  (isMonthDay && isSubscriptionDay) ,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text("freezed_single".tr,style: getLabelSmallStyle(context).copyWith(
                    color: APPSTYLE_GuideYellow
                ),),
              ),
            ),
            Visibility(
              visible: status==VALIDSUBSCRIPTIONDAY_STATUS.mealSelected  &&  (isMonthDay && isSubscriptionDay)  ,
              child: const Icon(Ionicons.restaurant ,
                  color:APPSTYLE_WhatsappGreen
                  , size: 14),
            ),
            Visibility(
              visible: (status==VALIDSUBSCRIPTIONDAY_STATUS.mealSelected ) &&  (isMonthDay && isSubscriptionDay) ,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text("meal-selected_single".tr,style: getLabelSmallStyle(context).copyWith(
                    color: APPSTYLE_WhatsappGreen
                ),),
              ),
            ),
            Visibility(
              visible: status==VALIDSUBSCRIPTIONDAY_STATUS.mealNotSelected  &&  (isMonthDay && isSubscriptionDay)  ,
              child: SvgPicture.asset(ASSETS_SELECTHAND,width: 10,color: APPSTYLE_PrimaryColor,)
            ),
            Visibility(
              visible: (status==VALIDSUBSCRIPTIONDAY_STATUS.mealNotSelected ) &&  (isMonthDay && isSubscriptionDay) ,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text("meal-not-selected_single".tr,style: getLabelSmallStyle(context).copyWith(
                    color: APPSTYLE_PrimaryColor
                ),),
              ),
            ),
          ],
        ));
  }
}
