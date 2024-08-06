import 'package:doneapp/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:flutter/material.dart';

class SubscriptionPlanCardComponent_PlanPurchase extends StatelessWidget {
  bool isSelected;
    SubscriptionPlanCardComponent_PlanPurchase({super.key,required this.isSelected});

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;


    return Container(
      decoration:
      APPSTYLE_BorderedContainerSmallDecoration.copyWith(
          color: Colors.transparent,
          border: Border.all(
              color:isSelected? APPSTYLE_PrimaryColor:Colors.transparent, width: 2)),
      height: screenheight * .25,
      padding: APPSTYLE_ExtraSmallPaddingAll,
      margin: EdgeInsets.only(bottom: APPSTYLE_SpaceSmall,left: APPSTYLE_SpaceLarge,right: APPSTYLE_SpaceLarge),
      child: Container(
        decoration: APPSTYLE_BorderedContainerSmallDecoration
            .copyWith(
          color: APPSTYLE_Black,
          boxShadow: APPSTYLE_ContainerShadow
        ),
        padding: APPSTYLE_MediumPaddingAll,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  "No Friday",
                  style: getHeadlineLargeStyle(context)
                      .copyWith(
                      color:
                      APPSTYLE_BackgroundWhite),
                ),
                Text(
                  "139.0 KWD",
                  style: getHeadlineLargeStyle(context)
                      .copyWith(
                      decoration: TextDecoration.lineThrough,
                      decorationColor: APPSTYLE_BackgroundWhite,
                      decorationStyle: TextDecorationStyle.solid,
                      color:
                      APPSTYLE_BackgroundWhite),
                ),

              ],
            ),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.end,
              crossAxisAlignment:
              CrossAxisAlignment.end,
              children: [


                Text(
                  "119.0 KWD",
                  style: getHeadlineLargeStyle(context)
                      .copyWith(
                      fontSize: APPSTYLE_FontSize24*1.5,
                      color:
                      APPSTYLE_BackgroundWhite),
                ),
              ],
            ),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  "100.0 Protein",
                  style: getBodyMediumStyle(context)
                      .copyWith(
                      color:
                      APPSTYLE_BackgroundWhite),
                ),
                Container(
                  decoration: APPSTYLE_ShadowedContainerLargeDecoration.
                  copyWith(
                    gradient: const LinearGradient(
                        colors: [Color(0xFFF46A6A), APPSTYLE_PrimaryColor],
                        tileMode: TileMode.clamp),
                  ),
                  padding: APPSTYLE_MediumPaddingHorizontal,
                  child: Text(
                    "Monthly",
                    style: getBodyMediumStyle(context)
                        .copyWith(
                        color:
                        APPSTYLE_BackgroundWhite),
                  ),
                )

              ],
            ),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  "100.0 Carb",
                  style: getBodyMediumStyle(context)
                      .copyWith(
                      color:
                      APPSTYLE_BackgroundWhite),
                ),
                Container(
                  decoration: APPSTYLE_ShadowedContainerLargeDecoration.
                  copyWith(
                    gradient: const LinearGradient(
                        colors: [Color(0xFFF46A6A), APPSTYLE_PrimaryColor],
                        tileMode: TileMode.clamp),
                  ),
                  padding: APPSTYLE_MediumPaddingHorizontal,
                  child: Text(
                    "Seasonal Offer",
                    style: getBodyMediumStyle(context)
                        .copyWith(
                        color:
                        APPSTYLE_BackgroundWhite),
                  ),
                )

              ],
            ),
          ],
        ),

      ),
    );
  }

}
