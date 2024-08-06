

 import 'package:doneapp/shared_module/constants/app_route_names.constants.shared.dart';
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

class EditProfilePage_Profile extends StatelessWidget {
  const EditProfilePage_Profile({super.key});

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
          ],
        ),
        actions: [
          InkWell(
            onTap: (){
              Get.toNamed(AppRouteNames.resetPasswordNewpasswordRoute);
            },
            child: Container(
              width: screenwidth*.4,
              decoration: APPSTYLE_ShadowedContainerExtraSmallDecoration.
              copyWith(
                boxShadow: [
                  const BoxShadow(
                    color: APPSTYLE_Grey80Shadow24,
                    offset: Offset(0, 3.0),
                    blurRadius: APPSTYLE_BlurRadiusLarge,
                  ),
                ],
                color: APPSTYLE_Black
              ),
              padding: EdgeInsets.symmetric(
                  vertical: APPSTYLE_SpaceSmall,horizontal: APPSTYLE_SpaceSmall
              ),
              child: Row(
                children: [
                  Icon(Ionicons.key,color: APPSTYLE_BackgroundWhite,
                      size: APPSTYLE_FontSize16),
                  addHorizontalSpace(APPSTYLE_SpaceExtraSmall),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "reset_password".tr,
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
          ),
          addHorizontalSpace(APPSTYLE_SpaceLarge)

        ],
      ) ,
      body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      addVerticalSpace(APPSTYLE_SpaceLarge),
                      Row(

                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          UpdateProfilePic(
                            onClick: () {
                              // openSourceSelector(context);
                            },
                            borderColor: APPSTYLE_PrimaryColor,
                            profilePictureUrl: "",
                          ),
                        ],

                      ),
                      addVerticalSpace(APPSTYLE_SpaceSmall),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Ionicons.camera_outline,size: APPSTYLE_FontSize20,color:APPSTYLE_Grey80),
                          addHorizontalSpace(APPSTYLE_SpaceSmall),
                          Text( 'upload_profile_picture'.tr,
                              textAlign: TextAlign.center,
                              style: getBodyMediumStyle(context)
                                  .copyWith(color: APPSTYLE_Grey80,decoration: TextDecoration.underline)),
                        ],
                      ),
                      addVerticalSpace(APPSTYLE_SpaceMedium),

                      Container(
                        decoration: APPSTYLE_ShadowedContainerSmallDecoration,
                        padding: APPSTYLE_MediumPaddingAll,
                        margin: APPSTYLE_LargePaddingAll.copyWith(bottom: 0),
                        child: Row(
                          children: [
                            Expanded(
                                flex:1,
                                child: Text('First Name',
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: APPSTYLE_Grey40))),
                            Expanded(
                                flex:2,
                                child: Text('Kayna Alisa',
                                    style: getBodyMediumStyle(context).copyWith(
                                        color: APPSTYLE_Grey80, fontWeight: APPSTYLE_FontWeightBold))),
                          ],
                        ),
                      ),
                      Container(
                        decoration: APPSTYLE_ShadowedContainerSmallDecoration,
                        padding: APPSTYLE_MediumPaddingAll,
                        margin: APPSTYLE_LargePaddingAll.copyWith(bottom: 0),
                        child: Row(
                          children: [
                            Expanded(
                                flex:1,

                                child: Text('Last Name',
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: APPSTYLE_Grey40))),
                            Expanded(
                                flex:2,
                                child: Text('Kayna Alisa',
                                    style: getBodyMediumStyle(context).copyWith(
                                        color: APPSTYLE_Grey80, fontWeight: APPSTYLE_FontWeightBold))),
                          ],
                        ),
                      ),
                      Container(
                        decoration: APPSTYLE_ShadowedContainerSmallDecoration,
                        padding: APPSTYLE_MediumPaddingAll,
                        margin: APPSTYLE_LargePaddingAll.copyWith(bottom: 0),
                        child: Row(
                          children: [
                            Expanded(
                                flex:1,

                                child: Text('الاسم الأول',
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: APPSTYLE_Grey40))),
                            Expanded(
                                flex:2,
                                child: Text('Kayna Alisa',
                                    style: getBodyMediumStyle(context).copyWith(
                                        color: APPSTYLE_Grey80, fontWeight: APPSTYLE_FontWeightBold))),
                          ],
                        ),
                      ),
                      Container(
                        decoration: APPSTYLE_ShadowedContainerSmallDecoration,
                        padding: APPSTYLE_MediumPaddingAll,
                        margin: APPSTYLE_LargePaddingAll.copyWith(bottom: 0),
                        child: Row(
                          children: [
                            Expanded(
                                flex:1,
                                child: Text('اسم العائلة',
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: APPSTYLE_Grey40))),
                            Expanded(
                                flex:2,
                                child: Text('Kayna Alisa',
                                    style: getBodyMediumStyle(context).copyWith(
                                        color: APPSTYLE_Grey80, fontWeight: APPSTYLE_FontWeightBold))),
                          ],
                        ),
                      ),
                      Container(
                        decoration: APPSTYLE_ShadowedContainerSmallDecoration,
                        padding: APPSTYLE_MediumPaddingAll,
                        margin: APPSTYLE_LargePaddingAll.copyWith(bottom: 0),
                        child: Row(
                          children: [
                            Expanded(
                                flex:1,
                                child: Text('email'.tr,
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: APPSTYLE_Grey40))),
                            Expanded(
                                flex:2,
                                child: Text('kaynaalisa@gmail.com',
                                    style: getBodyMediumStyle(context).copyWith(
                                        color: APPSTYLE_Grey80, fontWeight: APPSTYLE_FontWeightBold))),
                          ],
                        ),
                      ),
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
                        Get.back();
                      },
                      style: getElevatedButtonStyle(context),
                      child: Text(
                          "update".tr,
                          style: getHeadlineMediumStyle(context).copyWith(
                              color: APPSTYLE_BackgroundWhite,
                              fontWeight: APPSTYLE_FontWeightBold),
                          textAlign: TextAlign.center
                      ),
                    ),
                  ),
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
