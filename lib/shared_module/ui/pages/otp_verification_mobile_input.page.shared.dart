import 'package:doneapp/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:doneapp/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp/shared_module/constants/valid_phoneverification_modes.constants.shared.dart';
import 'package:doneapp/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:doneapp/shared_module/controllers/controller.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/form_validator.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:doneapp/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:doneapp/shared_module/ui/components/language_preview_button.component.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpVerificationMobileInputPage_Shared extends StatefulWidget {
  const OtpVerificationMobileInputPage_Shared({super.key});

  @override
  State<OtpVerificationMobileInputPage_Shared> createState() => _OtpVerificationMobileInputPage_SharedState();
}

class _OtpVerificationMobileInputPage_SharedState extends State<OtpVerificationMobileInputPage_Shared> {

  var getArguments = Get.arguments;
  final sharedController = Get.find<SharedController>();
  VALIDPHONEVERIFICATION_MODES phoneVerificationMode = VALIDPHONEVERIFICATION_MODES.register;
  var mobile = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneVerificationMode = getArguments[0]??VALIDPHONEVERIFICATION_MODES.register;
    mobile = getArguments[1]??"";
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: APPSTYLE_BackgroundWhite,
        scrolledUnderElevation: 0.0,
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
      ),
      resizeToAvoidBottomInset: true,
      body: Container(
        width: screenwidth,
        height: screenheight,
        padding: APPSTYLE_LargePaddingAll.copyWith(top: 0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Image.asset(ASSETS_MOBILEVERIFICATION, width: screenwidth*.8),
                     ],
                   ),
                  addVerticalSpace(APPSTYLE_SpaceLarge ),
                  Text("verify_your_number".tr,
                      textAlign: TextAlign.center,
                      style: getHeadlineLargeStyle(context).copyWith(
                          fontSize: APPSTYLE_FontSize24*1.5 )),
                  addVerticalSpace(APPSTYLE_SpaceLarge),
                  Text("enter_mobile".tr,
                      textAlign: TextAlign.center,
                      style: getHeadlineMediumStyle(context).copyWith()),
                  addVerticalSpace(APPSTYLE_SpaceLarge*2),
                  TextFormField(
                      validator: (value) => checkIfMobileNumberValid(value),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'mobile_number'.tr ,
                          hintText: 'enter_mobile_number'.tr
                      )),
                   addVerticalSpace(APPSTYLE_SpaceLarge ),

                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 0,vertical: APPSTYLE_SpaceSmall),
              child:  SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      child:   Text('send_otp'.tr,
                          style: getHeadlineMediumStyle(context).copyWith(
                              color: APPSTYLE_BackgroundWhite,fontWeight: APPSTYLE_FontWeightBold),
                          textAlign: TextAlign.center),
                      onPressed: () {
                        Get.toNamed(
                            AppRouteNames
                                .otpVerificationOtpInputRoute );

                      })),
            ),
          ],
        ),
      ),
    );
  }
}
