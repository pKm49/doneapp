import 'dart:ui';

import 'package:doneapp/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:doneapp/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SubscriptionPlanCategoryCardComponent_PlanPurchase extends StatelessWidget {
  const SubscriptionPlanCategoryCardComponent_PlanPurchase({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: APPSTYLE_SmallPaddingAll,
      decoration:
      APPSTYLE_BorderedContainerSmallDecoration
          .copyWith(
        image: DecorationImage(
          image: AssetImage(ASSETS_WELCOME_LOGIN_BG),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white.withOpacity(0.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: APPSTYLE_SmallPaddingAll,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Low Carb",
                              style: getHeadlineMediumStyle(context).copyWith(
                                  color: APPSTYLE_BackgroundWhite,fontWeight: APPSTYLE_FontWeightBold
                              ),),
                            addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                            Text("150 p 50C + Snack + Salad",
                              style: getLabelSmallStyle(context).copyWith(
                                  color: APPSTYLE_BackgroundWhite
                              ),)
                          ],
                        ),
                      ),
                      addHorizontalSpace(APPSTYLE_SpaceSmall),
                      Icon(Ionicons.arrow_forward_circle,color: APPSTYLE_BackgroundWhite)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(

              child:Align(
                alignment: Alignment.bottomCenter,

                child: ListView(
                  shrinkWrap: true,

                  children: [
                    Text("1-Breakfast",
                      style: getBodyMediumStyle(context).copyWith(
                          color: APPSTYLE_BackgroundWhite,
                          fontWeight: APPSTYLE_FontWeightBold
                      ),),
                    addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                    Text("2-Main Course",
                      style: getBodyMediumStyle(context).copyWith(
                          color: APPSTYLE_BackgroundWhite,
                          fontWeight: APPSTYLE_FontWeightBold
                      ),),
                    addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                    Text("2-Salad",
                      style: getBodyMediumStyle(context).copyWith(
                          color: APPSTYLE_BackgroundWhite,
                          fontWeight: APPSTYLE_FontWeightBold
                      ),),
                    addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                    Text("2-Snack & Soup",
                      style: getBodyMediumStyle(context).copyWith(
                          color: APPSTYLE_BackgroundWhite,
                          fontWeight: APPSTYLE_FontWeightBold
                      ),),
                    addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
