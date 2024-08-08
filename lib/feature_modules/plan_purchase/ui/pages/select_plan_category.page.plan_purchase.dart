import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
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

class SelectPlanCategoryPage_PlanPurchase extends StatefulWidget {
  const SelectPlanCategoryPage_PlanPurchase({super.key});

  @override
  State<SelectPlanCategoryPage_PlanPurchase> createState() =>
      _SelectPlanCategoryPage_PlanPurchaseState();
}

class _SelectPlanCategoryPage_PlanPurchaseState
    extends State<SelectPlanCategoryPage_PlanPurchase> {
  final CarouselController _controller = CarouselController();

  String referral = "1";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: APPSTYLE_BackgroundWhite,
          scrolledUnderElevation: 0.0,
          elevation: 0.0,
          title: Row(
            children: [
              CustomBackButton(isPrimaryMode: false),
            ],
          ),
          actions: [
            LanguagePreviewButtonComponentShared(textColor:APPSTYLE_PrimaryColor),
            addHorizontalSpace(APPSTYLE_SpaceLarge)
          ],
        ),
        body: SafeArea(
          child: Container(
            padding: APPSTYLE_LargePaddingHorizontal,
            height: screenheight,
            child: Column(
              children: [
                addVerticalSpace(APPSTYLE_SpaceLarge ),
                Text(
                  'which_plan_q'.tr,
                  style: getHeadlineLargeStyle(context)
                      .copyWith(fontWeight: APPSTYLE_FontWeightBold),
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: Center(
                    child: CarouselSlider(
                        carouselController: _controller,
                        options: CarouselOptions(
                          enableInfiniteScroll: false,
                          aspectRatio: .9,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                          autoPlay: false,
                          viewportFraction: 0.7,
                          onPageChanged: (index, reason) {},
                        ),
                        items: [
                            SubscriptionPlanCategoryCardComponent_PlanPurchase(),
                            SubscriptionPlanCategoryCardComponent_PlanPurchase(),
                            SubscriptionPlanCategoryCardComponent_PlanPurchase(),
                            SubscriptionPlanCategoryCardComponent_PlanPurchase(),
                        ]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 0,vertical: APPSTYLE_SpaceSmall),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRouteNames.planPurchaseSubscriptionPlansListRoute);
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
