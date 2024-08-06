

 import 'package:doneapp/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:doneapp/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:doneapp/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:doneapp/shared_module/ui/components/update_profile_pic.profile.component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ReferralPointsPage_Profile extends StatelessWidget {
  const ReferralPointsPage_Profile({super.key});

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation:0.0,
        backgroundColor: APPSTYLE_BackgroundWhite,
        elevation: 0.0,
        title: Row(
          children: [
            CustomBackButton(isPrimaryMode:false),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'referral_points'.tr,
                  style: getHeadlineLargeStyle(context).copyWith(
                      fontWeight: APPSTYLE_FontWeightBold),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ) ,
      body: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenwidth,
                  padding: APPSTYLE_MediumPaddingAll,
                  margin: APPSTYLE_LargePaddingAll,
                  height: 300,
                  decoration: APPSTYLE_BorderedContainerSmallDecoration.copyWith(color: APPSTYLE_Grey20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            child: Image.asset(ASSETS_DEFAULTPROFILEPIC),
                            radius: screenwidth * .12,
                          )
                        ],
                      ),
                      addVerticalSpace(APPSTYLE_SpaceMedium),

                      Text(
                        'Kayna Alisa',
                        style: getHeadlineLargeStyle(context)
                            .copyWith(color: APPSTYLE_Grey80),
                      ),
                      addVerticalSpace(APPSTYLE_SpaceSmall),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusLarge),
                                color: APPSTYLE_PrimaryColorBg),
                            padding: APPSTYLE_ExtraSmallPaddingAll.copyWith(left: APPSTYLE_SpaceMedium,right: APPSTYLE_SpaceMedium),
                            margin: APPSTYLE_LargePaddingHorizontal,
                            child: Text(
                              'kaynaalisa@gmail.com',
                              textAlign: TextAlign.center,
                              style: getLabelSmallStyle(context)
                                  .copyWith(color: APPSTYLE_BackgroundWhite),
                            ),
                          ),
                        ],
                      ),
                      addVerticalSpace(APPSTYLE_SpaceLarge),
                      Text(
                        'earnings'.tr,
                        textAlign: TextAlign.center,
                        style: getBodyMediumStyle(context).copyWith(color: APPSTYLE_Grey80),
                      ),
                      addVerticalSpace(APPSTYLE_SpaceSmall),

                      Text(
                        '8888',
                        textAlign: TextAlign.center,
                        style: getHeadlineLargeStyle(context).copyWith(color: APPSTYLE_Grey80),
                      ),
                    ],
                  ),
                ),
                addVerticalSpace(APPSTYLE_SpaceLarge),

                Padding(padding: APPSTYLE_LargePaddingHorizontal,child:  Text(
                  'referral_code'.tr,
                  textAlign: TextAlign.start,
                  style: getBodyMediumStyle(context).copyWith(color: APPSTYLE_Grey80),
                ),),
                Container(
                  decoration: APPSTYLE_ShadowedContainerSmallDecoration,
                  padding: APPSTYLE_MediumPaddingAll,
                  margin: APPSTYLE_LargePaddingAll.copyWith(bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text('Kayna Alisa',
                          style: getBodyMediumStyle(context).copyWith(
                              color: APPSTYLE_Grey80, fontWeight: APPSTYLE_FontWeightBold)),
                    ],
                  ),
                ),
                addVerticalSpace(APPSTYLE_SpaceMedium),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenwidth*.3,
                      child: ElevatedButton(
                        onPressed: () {
                          // Get.toNamed();
                          Get.back();
                        },
                        style: getElevatedButtonStyle(context).copyWith(
                          padding:  MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(
                                  horizontal: APPSTYLE_SpaceLarge,
                                  vertical:APPSTYLE_SpaceSmall))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.share,color: APPSTYLE_BackgroundWhite,size: APPSTYLE_FontSize20),
                            addHorizontalSpace(APPSTYLE_SpaceSmall),
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "share".tr ,
                                  style: getBodyMediumStyle(context).copyWith(color: APPSTYLE_BackgroundWhite,fontWeight: APPSTYLE_FontWeightBold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  void showLogoutConfirmDialogue(BuildContext context ) async {

    final dialogTitleWidget = Text('confirm_logout'.tr,style: getHeadlineMediumStyle(context).copyWith(
        color: APPSTYLE_Grey80,fontWeight: APPSTYLE_FontWeightBold));
    final dialogTextWidget = Text(  'confirm_logout_message'.tr,style: getBodyMediumStyle(context),
    );

    final updateButtonTextWidget = Text('yes'.tr,style: TextStyle(color: APPSTYLE_PrimaryColor),);
    final updateButtonCancelTextWidget = Text('no'.tr,style: TextStyle(color: APPSTYLE_Black),);

    updateLogoutAction() {
      // Get.offAllNamed(Approute_LoginPage_Auth);
    }
    updateAction() {
      Navigator.pop(context);

    }
    List<Widget> actions = [

      TextButton(
          onPressed:updateAction,
          style: APPSTYLE_TextButtonStylePrimary.copyWith(padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(
                  horizontal: APPSTYLE_SpaceLarge,
                  vertical: APPSTYLE_SpaceSmall))),
          child:  updateButtonCancelTextWidget),

      TextButton(
          onPressed:updateLogoutAction,
          style: APPSTYLE_TextButtonStylePrimary.copyWith(padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(
                  horizontal: APPSTYLE_SpaceLarge,
                  vertical: APPSTYLE_SpaceSmall))),
          child:  updateButtonTextWidget),
    ];

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            child: AlertDialog(
              title: dialogTitleWidget,
              content: dialogTextWidget,
              actions: actions,
            ),
            onWillPop: () => Future.value(false));
      },
    );
  }

}
