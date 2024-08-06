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

class CheckoutPage_PlanPurchase extends StatefulWidget {
  const CheckoutPage_PlanPurchase({super.key});

  @override
  State<CheckoutPage_PlanPurchase> createState() =>
      _CheckoutPage_PlanPurchaseState();
}

class _CheckoutPage_PlanPurchaseState
    extends State<CheckoutPage_PlanPurchase> {
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
                    'checkout'.tr,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                      child: ListView(
                        children: [
                          addVerticalSpace(APPSTYLE_SpaceLarge),

                          Padding(
                            padding: APPSTYLE_MediumPaddingHorizontal,
                            child: Text( 'payment_summary'.tr,
                              textAlign: TextAlign.start,
                              style: getHeadlineMediumStyle(context)
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          addVerticalSpace(APPSTYLE_SpaceMedium),
                          Container(
                            width: screenwidth,
                            decoration: APPSTYLE_ShadowedContainerSmallDecoration,
                            padding: APPSTYLE_MediumPaddingAll,
                            margin: APPSTYLE_LargePaddingHorizontal,
                            alignment: Alignment.center,
                            child: Wrap(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text( 'sub_total'.tr,
                                      style: getBodyMediumStyle(context).copyWith(
                                        color: APPSTYLE_Grey80, ),
                                    ),
                                    Text(
                                      '20.00 KD',
                                      style: getBodyMediumStyle(context).copyWith(
                                          color: APPSTYLE_Grey80,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text( 'discount'.tr,
                                      style: getBodyMediumStyle(context).copyWith(
                                        color: APPSTYLE_Grey80,
                                      ),
                                    ),
                                    Text(
                                      '-05.00 KD',
                                      style: getBodyMediumStyle(context).copyWith(
                                          color: APPSTYLE_GuideGreen,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                addVerticalSpace(APPSTYLE_SpaceMedium),
                                Row(
                                  children: List.generate(
                                      600 ~/ 10,
                                          (index) => Expanded(
                                        child: Container(
                                          color: index % 2 == 0
                                              ? Colors.transparent
                                              : Colors.grey,
                                          height: 2,
                                        ),
                                      )),
                                ),
                                addVerticalSpace(APPSTYLE_SpaceMedium),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text( 'total'.tr,
                                      style: getBodyMediumStyle(context).copyWith(
                                        color: APPSTYLE_Grey80, ),
                                    ),
                                    Text(
                                      '15.00 KD',
                                      style: getBodyMediumStyle(context).copyWith(
                                          color: APPSTYLE_Grey80,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          addVerticalSpace(APPSTYLE_SpaceMedium),

                          addVerticalSpace(APPSTYLE_SpaceMedium),
                          Container(
                            width: screenwidth,
                            decoration: APPSTYLE_ShadowedContainerSmallDecoration,
                            padding: APPSTYLE_MediumPaddingAll,
                            margin: APPSTYLE_LargePaddingHorizontal,
                            alignment: Alignment.center,
                            child:   Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text( 'coupon_code'.tr,
                                  style:
                                  getBodyMediumStyle(context).copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: APPSTYLE_Grey80,
                                  ),
                                ),
                                addHorizontalSpace(APPSTYLE_SpaceMedium),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    padding: EdgeInsets.only(
                                      left:  Localizations.localeOf(context)
                                          .languageCode
                                          .toString() ==
                                          'en'
                                          ? APPSTYLE_SpaceMedium
                                          :0.0 ,
                                      right:  Localizations.localeOf(context)
                                          .languageCode
                                          .toString() ==
                                          'en'
                                          ? 0.0
                                          :APPSTYLE_SpaceMedium,
                                    ),
                                    decoration:
                                    APPSTYLE_BorderedContainerDarkSmallDecoration.copyWith(color: APPSTYLE_Grey20),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child:  TextFormField(

                                              decoration: noBorderInputDecoration.copyWith(
                                                hintText:'enter_code'.tr,
                                              )),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 50,
                                          width: 50,
                                          padding:
                                          EdgeInsets.all(APPSTYLE_SpaceSmall),
                                          decoration:
                                          APPSTYLE_BorderedContainerDarkSmallDecoration
                                              .copyWith(
                                              color:
                                              APPSTYLE_PrimaryColor),
                                          child: Icon(Icons.check,color: APPSTYLE_BackgroundWhite),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),),
                          addVerticalSpace(APPSTYLE_SpaceLarge*2),
                          Padding(
                            padding: APPSTYLE_LargePaddingHorizontal,
                            child: Text( 'order_summary'.tr,
                              textAlign: TextAlign.start,
                              style: getHeadlineMediumStyle(context)
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          addVerticalSpace(APPSTYLE_SpaceMedium),
                          Container(
                            height: 100,
                            width: screenwidth,
                            decoration: APPSTYLE_ShadowedContainerSmallDecoration,
                            padding: APPSTYLE_MediumPaddingAll,
                            margin: APPSTYLE_LargePaddingHorizontal,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text( 'weight_loss'.tr,
                                      style: getBodyMediumStyle(context).copyWith(
                                          color: APPSTYLE_Grey80,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text( 'summer_loss'.tr,
                                      style: getBodyMediumStyle(context).copyWith(
                                          color: APPSTYLE_Grey80,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                addVerticalSpace(APPSTYLE_SpaceSmall),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '12 ${'days'.tr}',
                                      style: getBodyMediumStyle(context).copyWith(
                                        color: APPSTYLE_Grey80,
                                      ),
                                    ),
                                    Text(
                                      '20.00 KD',
                                      style: getBodyMediumStyle(context).copyWith(
                                          color: APPSTYLE_PrimaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),


                          addVerticalSpace(APPSTYLE_SpaceLarge*3),


                        ],
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: APPSTYLE_SpaceLarge,vertical: APPSTYLE_SpaceSmall),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRouteNames.otpVerificationSuccessRoute,arguments: [
                          ASSETS_SUCCESSMARK,"subscription_success".tr,"subscription_success_info".tr,
                          'home'.tr,false
                        ])?.then((value) => Get.toNamed(AppRouteNames.homeRoute,arguments: [0]));
                      },
                      style: getElevatedButtonStyle(context),
                      child: Text(
                        "checkout".tr,
                        style: getHeadlineMediumStyle(context).copyWith(
                            color: APPSTYLE_BackgroundWhite,
                            fontWeight: APPSTYLE_FontWeightBold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
