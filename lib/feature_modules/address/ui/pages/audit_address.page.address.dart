 import 'package:doneapp/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp/shared_module/constants/valid_addressauthor_modes.constants.shared.dart';
import 'package:doneapp/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/form_validator.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:doneapp/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:doneapp/shared_module/ui/components/language_preview_button.component.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class AuditAddressPage_Address extends StatefulWidget {
  const AuditAddressPage_Address({super.key});

  @override
  State<AuditAddressPage_Address> createState() =>
      _AuditAddressPage_AddressState();
}

class _AuditAddressPage_AddressState
    extends State<AuditAddressPage_Address> {
   VALIDADDRESSAUTHOR_MODES addressAuthorMode = VALIDADDRESSAUTHOR_MODES.complete_registration;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar:AppBar(
          automaticallyImplyLeading: false,
          scrolledUnderElevation:0.0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0.0,
          title: Row(
            children: [
              CustomBackButton(isPrimaryMode:false),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'enter_your_address'.tr,
                    style: getHeadlineLargeStyle(context).copyWith(
                        fontWeight: APPSTYLE_FontWeightBold),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
          actions: [
            LanguagePreviewButtonComponentShared(isPrimaryMode:true),
            addHorizontalSpace(APPSTYLE_SpaceLarge)
          ],
        ) ,
        body: SafeArea(
          child: Container(
            height: screenheight,
            child:Column(
              children: [
                Expanded(
                  child: Container(
                    padding: APPSTYLE_LargePaddingAll.copyWith(bottom: 0.0,top: 0.0),
                    child: ListView(
                      children: [

                        addVerticalSpace(APPSTYLE_SpaceLarge),

                        TextFormField(
                          validator: (email) => checkIfEmailFormValid(email),
                          decoration: InputDecoration(
                            hintText: 'area'.tr,
                            isDense: true,
                          ),
                        ),
                        addVerticalSpace(APPSTYLE_SpaceMedium),
                        TextFormField(
                          validator: (password) =>
                              checkIfPasswordFieldValid(password),
                          decoration: InputDecoration(
                            hintText: 'block'.tr,
                            isDense: true,
                          ),
                        ),
                        addVerticalSpace(APPSTYLE_SpaceMedium),
                        Row(children: [
                          Expanded(child: TextFormField(
                            validator: (password) =>
                                checkIfPasswordFieldValid(password),
                            decoration: InputDecoration(
                              hintText: 'street'.tr,
                              isDense: true,
                            ),
                          ),),
                          addHorizontalSpace(APPSTYLE_SpaceMedium),

                          Expanded(child: TextFormField(
                            validator: (password) =>
                                checkIfPasswordFieldValid(password),
                            decoration: InputDecoration(
                              hintText: 'jeddah'.tr,
                              isDense: true,
                            ),
                          ),),
                        ],),
                        addVerticalSpace(APPSTYLE_SpaceMedium),
                        TextFormField(
                          validator: (password) =>
                              checkIfPasswordFieldValid(password),
                          decoration: InputDecoration(
                            hintText: 'house_number'.tr,
                            isDense: true,
                          ),
                        ),
                        addVerticalSpace(APPSTYLE_SpaceMedium),
                        TextFormField(
                          validator: (password) =>
                              checkIfPasswordFieldValid(password),
                          decoration: InputDecoration(
                            hintText: 'floor_number'.tr,
                            isDense: true,
                          ),
                        ),
                        addVerticalSpace(APPSTYLE_SpaceMedium),
                        TextFormField(
                          validator: (password) =>
                              checkIfPasswordFieldValid(password),
                          decoration: InputDecoration(
                            hintText: 'flat_number'.tr,
                            isDense: true,
                          ),
                        ),
                        addVerticalSpace(APPSTYLE_SpaceMedium),
                        TextFormField(
                          validator: (password) =>
                              checkIfPasswordFieldValid(password),
                          decoration: InputDecoration(
                            hintText: 'comments'.tr,
                            isDense: true,
                          ),
                        ),
                        addVerticalSpace(APPSTYLE_SpaceLarge),

                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: APPSTYLE_SpaceLarge,vertical: APPSTYLE_SpaceSmall),
                  child:  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if(addressAuthorMode==VALIDADDRESSAUTHOR_MODES.complete_registration){
                          Get.toNamed(
                              AppRouteNames.registerAboutMeRoute);
                        } else{
                          Get.back();
                        }

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
