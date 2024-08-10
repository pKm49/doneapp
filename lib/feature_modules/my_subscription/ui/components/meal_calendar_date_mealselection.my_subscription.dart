 
import 'package:doneapp/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:doneapp/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp/shared_module/constants/valid_subscription_day_status.constants.shared.dart';
import 'package:doneapp/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/calendar_utilities.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';

class MealCalendarDateMealSelectionComponent_MySubscription extends StatelessWidget {
 
  DateTime date;
  String status;
  bool isSelected; 
  
  MealCalendarDateMealSelectionComponent_MySubscription({super.key,
    required this.isSelected, 
    required this.status ,   required this.date});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.vertical,
      spacing: APPSTYLE_SpaceSmall,
      children: [
        Text(
          getDayNameByDate(date),
          style: getLabelSmallStyle(context).copyWith(
              color: APPSTYLE_Grey80),
        ),
        Container(
          decoration: BoxDecoration(
            color: isSelected
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
                  date.day.toString(),
                  style: getBodyMediumStyle(context).copyWith(
                      fontWeight: APPSTYLE_FontWeightBold,
                      color:isSelected
                          ? APPSTYLE_BackgroundWhite
                          : APPSTYLE_PrimaryColorBg),
                ),

                Visibility(
                  visible: status ==VALIDSUBSCRIPTIONDAY_STATUS.offDay   ,
                  child: Icon(Icons.close,
                      color:APPSTYLE_PrimaryColor
                      , size: 15),
                ),
                Visibility(
                  visible:  status==VALIDSUBSCRIPTIONDAY_STATUS.delivered    ,
                  child: Icon(Icons.delivery_dining,
                      color:APPSTYLE_WhatsappGreen
                      , size: 15),
                ),
                Visibility(
                  visible: status==VALIDSUBSCRIPTIONDAY_STATUS.freezed     ,
                  child: Icon(Icons.pause,
                      color:APPSTYLE_PrimaryColor
                      , size: 15),
                ),
                Visibility(
                  visible: status==VALIDSUBSCRIPTIONDAY_STATUS.mealSelected    ,
                  child: Icon(Ionicons.checkmark ,
                      color:APPSTYLE_WhatsappGreen
                      , size: 15),
                ),
                Visibility(
                    visible: status==VALIDSUBSCRIPTIONDAY_STATUS.mealNotSelected   ,
                    child: SvgPicture.asset(ASSETS_SELECTHAND,width: 10,color:isSelected
                        ? APPSTYLE_BackgroundWhite
                        : APPSTYLE_PrimaryColor  )
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }
}
