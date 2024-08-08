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

class RegisterAboutmePage_Auth extends StatefulWidget {
  const RegisterAboutmePage_Auth({super.key});

  @override
  State<RegisterAboutmePage_Auth> createState() =>
      _RegisterAboutmePage_AuthState();
}

class _RegisterAboutmePage_AuthState
    extends State<RegisterAboutmePage_Auth> {
  bool isTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar:AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: APPSTYLE_BackgroundWhite,
          scrolledUnderElevation:0.0,
          elevation: 0.0,
          title: Row(
            children: [
              CustomBackButton(isPrimaryMode:false),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'about_me'.tr,
                    style: getHeadlineLargeStyle(context).copyWith(
                        fontWeight: APPSTYLE_FontWeightBold),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
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

                      addVerticalSpace(APPSTYLE_SpaceLarge  ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {

                              },
                              child: Container(
                                height: size.height * 0.07,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: APPSTYLE_Black,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(ASSETS_MALE,
                                      height: size.height * 0.05,
                                    ),
                                    addHorizontalSpace(APPSTYLE_SpaceSmall),
                                    Text(
                                      "Male",
                                      style: getBodyMediumStyle(context).copyWith(
                                        color: APPSTYLE_BackgroundWhite,
                                        fontWeight: APPSTYLE_FontWeightBold
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          addHorizontalSpace(APPSTYLE_SpaceMedium),
                          Expanded(
                            child: InkWell(
                              onTap: () {

                              },
                              child: Container(
                                height: size.height * 0.07,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: APPSTYLE_Grey20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      ASSETS_FEMALE,
                                      height: size.height * 0.05,
                                    ),
                                    addHorizontalSpace(APPSTYLE_SpaceSmall),
                                    Text(
                                      "Female",
                                      style: getBodyMediumStyle(context).copyWith(
                                          color: APPSTYLE_Black,
                                          fontWeight: APPSTYLE_FontWeightBold
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),

                      addVerticalSpace(APPSTYLE_SpaceLarge * 2),

                      Text(
                        'how_tall_q'.tr,
                        style: getBodyMediumStyle(context).copyWith(  fontWeight: APPSTYLE_FontWeightBold),
                        textAlign: TextAlign.start,
                      ),

                      addVerticalSpace(APPSTYLE_SpaceMedium),
                      Row(children: [
                        Expanded(child: TextFormField(
                          validator: (password) =>
                              checkIfPasswordFieldValid(password),
                          decoration: InputDecoration(
                            hintText: '170',
                            isDense: true,
                          ),
                        ),),
                        addHorizontalSpace(APPSTYLE_SpaceMedium),

                        Expanded(child:

                        Text(
                          'cm'.tr,
                          style: getBodyMediumStyle(context).copyWith(),
                          textAlign: TextAlign.start,
                        ), ),
                      ],),
                      addVerticalSpace(APPSTYLE_SpaceLarge*2),
                      Text(
                        'what_is_weight_q'.tr,
                        style: getBodyMediumStyle(context).copyWith(  fontWeight: APPSTYLE_FontWeightBold),
                        textAlign: TextAlign.start,
                      ),

                      addVerticalSpace(APPSTYLE_SpaceMedium),
                      Row(children: [
                        Expanded(child: TextFormField(
                          validator: (password) =>
                              checkIfPasswordFieldValid(password),
                          decoration: InputDecoration(
                            hintText: '100',
                            isDense: true,
                          ),
                        ),),
                        addHorizontalSpace(APPSTYLE_SpaceMedium),

                        Expanded(child:

                        Text(
                          'Kg'.tr,
                          style: getBodyMediumStyle(context).copyWith(),
                          textAlign: TextAlign.start,
                        ), ),
                      ],),
                      addVerticalSpace(APPSTYLE_SpaceLarge  ),

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
                        Get.toNamed(AppRouteNames.registerOriginRoute);
                      },
                      style: getElevatedButtonStyle(context),
                      child: Text(
                          "continue".tr,
                          style: getHeadlineMediumStyle(context).copyWith(
                              color: APPSTYLE_BackgroundWhite,
                              fontWeight: APPSTYLE_FontWeightBold)
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
