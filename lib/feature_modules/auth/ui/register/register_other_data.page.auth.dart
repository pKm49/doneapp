import 'package:doneapp/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:doneapp/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp/shared_module/constants/valid_phoneverification_modes.constants.shared.dart';
import 'package:doneapp/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:doneapp/shared_module/controllers/controller.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/form_validator.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:doneapp/shared_module/ui/components/custom_curve_shape.component.shared.dart';
import 'package:doneapp/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:doneapp/shared_module/ui/components/language_preview_button.component.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterOtherDataPage_Auth extends StatelessWidget {
  RegisterOtherDataPage_Auth({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: APPSTYLE_PrimaryColor,
          scrolledUnderElevation:0.0,
          elevation: 0.0,
          title: Row(
            children: [
              CustomBackButton(isPrimaryMode: false),
            ],
          ),
          actions: [
            LanguagePreviewButtonComponentShared(textColor:APPSTYLE_BackgroundWhite),
            addHorizontalSpace(APPSTYLE_SpaceLarge)
          ],
        ),
        body: SafeArea(
          child: Container(
            height: screenheight,
            child: Column(
              children: [

                Expanded(
                  child: ListView(
                    children: [
                      CustomCurveShapeComponent_Shared(
                        color: APPSTYLE_PrimaryColor,
                        title: "sign_up".tr,
                      ),
                      Padding(
                        padding: APPSTYLE_LargePaddingHorizontal,
                        child: TextFormField(
                          validator: (email) =>
                              checkIfNameFormValid(email, 'first_name_ar'.tr),
                          decoration: InputDecoration(
                            hintText: 'first_name_ar_hint'.tr,
                            label: Row(
                              children: [
                                Text('first_name_ar'.tr),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "*",
                                    style: TextStyle(color: APPSTYLE_GuideRed),
                                  ),
                                )
                              ],
                            ),
                            isDense: true,
                          ),
                        ),
                      ),
                      addVerticalSpace(APPSTYLE_SpaceMedium),
                      Padding(
                        padding: APPSTYLE_LargePaddingHorizontal,
                        child: TextFormField(
                          validator: (email) =>
                              checkIfNameFormValid(email, 'last_name_ar'.tr),
                          decoration: InputDecoration(
                            hintText: 'last_name_ar_hint'.tr,
                            label: Row(
                              children: [
                                Text('last_name_ar'.tr),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "*",
                                    style: TextStyle(color: APPSTYLE_GuideRed),
                                  ),
                                )
                              ],
                            ),
                            isDense: true,
                          ),
                        ),
                      ),
                      addVerticalSpace(APPSTYLE_SpaceMedium),
                      Padding(
                        padding: APPSTYLE_LargePaddingHorizontal,
                        child: TextFormField(
                          validator: (email) => checkIfEmailFormValid(email),
                          decoration: InputDecoration(
                            hintText: 'enter_email'.tr,
                            label: Row(
                              children: [
                                Text('email'.tr),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "*",
                                    style: TextStyle(color: APPSTYLE_GuideRed),
                                  ),
                                )
                              ],
                            ),
                            isDense: true,
                          ),
                        ),
                      ),
                      addVerticalSpace(APPSTYLE_SpaceMedium),
                      Padding(
                        padding: APPSTYLE_LargePaddingHorizontal,
                        child: TextFormField(
                          validator: (password) =>
                              checkIfPasswordFieldValid(password),
                          decoration: InputDecoration(
                            hintText: 'enter_password'.tr,
                            label: Row(
                              children: [
                                Text('password'.tr),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "*",
                                    style: TextStyle(color: APPSTYLE_GuideRed),
                                  ),
                                )
                              ],
                            ),
                            isDense: true,
                          ),
                        ),
                      ),
                      addVerticalSpace(APPSTYLE_SpaceMedium),
                      Padding(
                        padding: APPSTYLE_LargePaddingHorizontal,
                        child: TextFormField(
                          validator: (confirm_password) =>
                              checkIfConfirmPasswordFieldValid(
                                  confirm_password, ""),
                          decoration: InputDecoration(
                            hintText: 're_enter_password'.tr,
                            label: Row(
                              children: [
                                Text('confirm_password'.tr),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "*",
                                    style: TextStyle(color: APPSTYLE_GuideRed),
                                  ),
                                )
                              ],
                            ),
                            isDense: true,
                          ),
                        ),
                      ),
                      addVerticalSpace(APPSTYLE_SpaceLarge ),

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
                        handleSubmit();
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

  void handleSubmit() {
    Get
        .toNamed(
        AppRouteNames
            .otpVerificationMobileInputRoute,
        arguments: [VALIDPHONEVERIFICATION_MODES.register,"+965 12312345"]);
  }
}
