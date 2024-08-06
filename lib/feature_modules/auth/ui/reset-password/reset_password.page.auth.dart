import 'package:doneapp/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:doneapp/shared_module/constants/style_params.constants.shared.dart';
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

class ResetPasswordPage_auth extends StatelessWidget {
  ResetPasswordPage_auth({super.key});

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
            LanguagePreviewButtonComponentShared(isPrimaryMode:true),
            addHorizontalSpace(APPSTYLE_SpaceLarge)
          ],
        ) ,
        body: SafeArea(
          child: Container(

            padding: APPSTYLE_LargePaddingAll,
            height: screenheight,
            child: Column(
              children: [

                Expanded(
                  child: ListView(
                    children: [
                      Text(
                        'create_new_password'.tr,
                        style: getHeadlineLargeStyle(context).copyWith(
                            fontWeight: APPSTYLE_FontWeightBold),
                        textAlign: TextAlign.center,
                      ),
                      addVerticalSpace(APPSTYLE_SpaceLarge * 2),

                      TextFormField(
                        validator: (password) =>
                            checkIfPasswordFieldValid(password),
                        decoration: InputDecoration(
                          hintText: 'new_password'.tr,
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
                      addVerticalSpace(APPSTYLE_SpaceMedium),
                      TextFormField(
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

                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppRouteNames.otpVerificationSuccessRoute,arguments: [
                        ASSETS_SUCCESSMARK,"password_changed".tr,"password_changed_message".tr,
                        'back_to_login'.tr,false
                      ])?.then((value) => Get.toNamed(AppRouteNames.loginRoute));
                    },
                    style: getElevatedButtonStyle(context),
                    child: Text("submit".tr,
                        style: getHeadlineMediumStyle(context).copyWith(
                            color: APPSTYLE_BackgroundWhite,
                            fontWeight: APPSTYLE_FontWeightBold),
                        textAlign: TextAlign.center),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

}
