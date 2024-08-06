import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:doneapp/feature_modules/plan_purchase/ui/components/subscriptionplan_card.component.plan_purchase.dart';
import 'package:doneapp/feature_modules/plan_purchase/ui/components/subscriptionplan_categorycard.component.plan_purchase.dart';
import 'package:doneapp/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:doneapp/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/form_validator.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:doneapp/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:doneapp/shared_module/ui/components/language_preview_button.component.shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class SelectPlanPage_PlanPurchase extends StatefulWidget {
  const SelectPlanPage_PlanPurchase({super.key});

  @override
  State<SelectPlanPage_PlanPurchase> createState() =>
      _SelectPlanPage_PlanPurchaseState();
}

class _SelectPlanPage_PlanPurchaseState
    extends State<SelectPlanPage_PlanPurchase> {
  final CarouselController _controller = CarouselController();

  String referral = "1";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: APPSTYLE_BackgroundWhite,
          scrolledUnderElevation: 0.0,
          elevation: 0.0,
          title: Row(
            children: [
              CustomBackButton(isPrimaryMode: false),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'select_your_choice'.tr,
                    style: getHeadlineLargeStyle(context).copyWith(
                        fontWeight: APPSTYLE_FontWeightBold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            LanguagePreviewButtonComponentShared(isPrimaryMode: true),
            addHorizontalSpace(APPSTYLE_SpaceLarge)
          ],
        ),
        body: SafeArea(
          child: Container(
             height: screenheight,
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: screenwidth*.5,
                      decoration: APPSTYLE_ShadowedContainerLargeDecoration.
                      copyWith(
                        gradient: const LinearGradient(
                            colors: [Color(0xFFF46A6A), APPSTYLE_PrimaryColor],
                            tileMode: TileMode.clamp),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: APPSTYLE_SpaceSmall,horizontal: APPSTYLE_SpaceMedium
                      ),
                      child: Row(
                        children: [
                          Icon(Ionicons.calendar_number_outline,color: APPSTYLE_BackgroundWhite,
                              size: APPSTYLE_FontSize16),
                          addHorizontalSpace(APPSTYLE_SpaceSmall),
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "book_an_appointment".tr,
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
                    addHorizontalSpace(APPSTYLE_SpaceLarge)
                  ],
                ),
                addVerticalSpace(APPSTYLE_SpaceMedium),

                Expanded(
                  child: ListView(
                    children: [
                      SubscriptionPlanCardComponent_PlanPurchase(
                        isSelected: true,
                      ),
                      SubscriptionPlanCardComponent_PlanPurchase(
                        isSelected: false,
                      ),
                      SubscriptionPlanCardComponent_PlanPurchase(
                        isSelected: false,
                      ),
                      SubscriptionPlanCardComponent_PlanPurchase(
                        isSelected: false,
                      ),
                      SubscriptionPlanCardComponent_PlanPurchase(
                        isSelected: false,
                      )
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
                        Get.toNamed(AppRouteNames.planPurchaseCheckoutRoute);
                      },
                      style: getElevatedButtonStyle(context),
                      child: Text("continue".tr,
                          style: getHeadlineMediumStyle(context).copyWith(
                              color: APPSTYLE_BackgroundWhite,
                              fontWeight: APPSTYLE_FontWeightBold),
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ));
  }
}
