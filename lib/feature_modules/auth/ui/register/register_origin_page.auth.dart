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

class RegisterOriginPage_Auth extends StatefulWidget {
  const RegisterOriginPage_Auth({super.key});

  @override
  State<RegisterOriginPage_Auth> createState() =>
      _RegisterOriginPage_AuthState();
}

class _RegisterOriginPage_AuthState
    extends State<RegisterOriginPage_Auth> {
  String referral = "1";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar:AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: APPSTYLE_BackgroundWhite,
          scrolledUnderElevation:0.0,
          elevation: 0.0,
          title: Row(
            children: [
              CustomBackButton(isPrimaryMode:false),
            ],
          ),
          actions: [
            LanguagePreviewButtonComponentShared(textColor:APPSTYLE_PrimaryColor),
            addHorizontalSpace(APPSTYLE_SpaceLarge)
          ],
        ) ,
        body: SafeArea(
          child: Container(
            padding: APPSTYLE_LargePaddingHorizontal,
            height: screenheight,
            child:Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      addVerticalSpace(APPSTYLE_SpaceLarge ),

                      Text(
                        'let_us_know_how_you_found_us'.tr,
                        style: getHeadlineLargeStyle(context).copyWith(
                            fontWeight: APPSTYLE_FontWeightBold),
                        textAlign: TextAlign.start,
                      ),

                      addVerticalSpace(APPSTYLE_SpaceLarge ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            activeColor: APPSTYLE_PrimaryColor,
                            value: "1",
                            onChanged: (value) {
                              referral = value??"1";
                              setState(() {});
                            }, groupValue: referral,),
                          TextButton(
                              onPressed: () {},
                              child: Text("social_media".tr,
                                  style: getLabelLargeStyle(context))),
                        ],
                      ),
                      addVerticalSpace(APPSTYLE_SpaceExtraSmall ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            activeColor: APPSTYLE_PrimaryColor,
                            value: "2",
                            onChanged: (value) {
                              referral = value??"2";
                              setState(() {});
                            }, groupValue: referral,),
                          TextButton(
                              onPressed: () {},
                              child: Text("through_a_friend".tr,
                                  style: getLabelLargeStyle(context))),
                        ],
                      ),
                      addVerticalSpace(APPSTYLE_SpaceExtraSmall ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            activeColor: APPSTYLE_PrimaryColor,
                            value: "3",
                            onChanged: (value) {
                              referral = value??"3";
                              setState(() {});
                            }, groupValue: referral,),
                          TextButton(
                              onPressed: () {},
                              child: Text("others".tr,
                                  style: getLabelLargeStyle(context))),
                        ],
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 0,vertical: APPSTYLE_SpaceSmall),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRouteNames.planPurchaseSubscriptionPlansCategoryListRoute);
                      },
                      style: getElevatedButtonStyle(context),
                      child: Text(
                          "continue".tr,
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
