import 'dart:ui';

import 'package:doneapp/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:doneapp/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:doneapp/shared_module/controllers/controller.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class HomePage_Core extends StatelessWidget {
    HomePage_Core({super.key});
  final sharedController = Get.find<SharedController>();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return   Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        handleRequestSupportClick(context,true);

      },
        child: Icon(Ionicons.logo_whatsapp,color: APPSTYLE_BackgroundWhite),
        backgroundColor: APPSTYLE_WhatsappGreen,
        shape: const CircleBorder(),

      ),
      body: Container(
        decoration: BoxDecoration(

          image: DecorationImage(
            alignment: Alignment(-.2, 0),
            image: AssetImage(ASSETS_HOME_BG),
            fit: BoxFit.cover,
          ),
        ),
        width: screenwidth,
        height: screenheight,
        child: SafeArea(
          child: Obx(
            ()=> Column(
              children: [
                Container(
                  width: screenwidth,
                  height: (screenwidth*.13)+(APPSTYLE_SpaceMedium*2),
                  padding: EdgeInsets.all(APPSTYLE_SpaceMedium),
                  margin: EdgeInsets.only(bottom: APPSTYLE_SpaceMedium),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Container(
                      //     decoration: APPSTYLE_BorderedContainerDarkMediumDecoration.copyWith(
                      //         borderRadius: BorderRadius.circular(1000),
                      //         color: APPSTYLE_BackgroundWhite
                      //     ),
                      //     padding: APPSTYLE_ExtraSmallPaddingAll,
                      //     width: screenwidth*.13,
                      //     child: Image.asset(ASSETS_DEFAULTPROFILEPIC,)),
                      // addHorizontalSpace(APPSTYLE_SpaceSmall),
                      Expanded(
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(

                                child: Text('hey_username'.tr.replaceAll('username', sharedController.userData.value.firstName+" "+sharedController.userData.value.lastName),
                                  textAlign: TextAlign.start,
                                  style: getBodyMediumStyle(context).copyWith(
                                      color: APPSTYLE_BackgroundWhite,
                                      fontWeight: APPSTYLE_FontWeightBold),
                                ),
                                fit:BoxFit.scaleDown,
                              ),
                              FittedBox(
                                fit:BoxFit.scaleDown,
                                child: Text(getGreetingText().tr,
                                  textAlign: TextAlign.start,
                                  style: getLabelLargeStyle(context).copyWith(
                                    color: APPSTYLE_BackgroundWhite,

                                  ),
                                ),
                              ),
                            ],
                          )),
                      InkWell(
                        onTap:(){
                          Get.toNamed(AppRouteNames.notificationsRoute);
                        },
                        child: Badge(
                          backgroundColor:sharedController.notifications.isNotEmpty? APPSTYLE_BackgroundWhite:Colors.transparent,
                          child: Icon(Ionicons.notifications_outline,
                              color: APPSTYLE_BackgroundWhite,
                              size: APPSTYLE_FontSize24),
                        ),
                      ),
                      addHorizontalSpace(APPSTYLE_SpaceMedium),

                      InkWell(
                        onTap:()   {
                          handleRequestSupportClick(context,false);
                        },
                        child: Icon(Ionicons.call_outline,
                            color: APPSTYLE_BackgroundWhite,
                            size: APPSTYLE_FontSize24),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: ListView(
                  children: [
                    addVerticalSpace(APPSTYLE_SpaceLarge),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: screenwidth*.7,
                          height: screenheight*.4,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                height: screenheight*.4,
                                width: screenwidth*.7,
                                margin: const EdgeInsets.only(top:70),
                                decoration: APPSTYLE_ShadowedContainerSmallDecoration.copyWith(
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ),
                              Container(
                                height: screenheight*.4,
                                width: screenwidth*.7,
                                margin: const EdgeInsets.only(top:70),
                                child:   ClipRRect(
                                  borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusSmall),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                      decoration: APPSTYLE_ShadowedContainerSmallDecoration.copyWith(
                                        color: Colors.transparent
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: screenheight*.4,
                                width: screenwidth*.7,
                                padding: APPSTYLE_MediumPaddingAll,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        decoration: APPSTYLE_BorderedContainerDarkMediumDecoration.copyWith(
                                            borderRadius: BorderRadius.circular(1000),
                                            color: APPSTYLE_BackgroundWhite
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                        padding: APPSTYLE_SmallPaddingAll,
                                        width: screenwidth*.3,
                                        child: Image.asset(ASSETS_DEFAULTPROFILEPIC,)),
                                    addVerticalSpace(APPSTYLE_SpaceLarge ),
                                    FittedBox(

                                      fit:BoxFit.scaleDown,
                                      child: Text("2 Diet Meals",
                                        textAlign: TextAlign.start,
                                        style: getHeadlineLargeStyle(context).copyWith(
                                            color: APPSTYLE_BackgroundWhite,
                                            fontWeight: APPSTYLE_FontWeightBold),
                                      ),
                                    ),
                                    addVerticalSpace(APPSTYLE_SpaceSmall),
                                    FittedBox(
                                      fit:BoxFit.scaleDown,
                                      child: Text("Ends on 06-09-2024".tr,
                                        textAlign: TextAlign.start,
                                        style: getBodyMediumStyle(context).copyWith(
                                          color: APPSTYLE_BackgroundWhite,

                                        ),
                                      ),
                                    ),
                                    addVerticalSpace(APPSTYLE_SpaceSmall),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                          Text(
                                            Localizations.localeOf(context)
                                                .languageCode
                                                .toString() ==
                                                'en'
                                                ?
                                          "Remain":"يوما",
                                          style: getBodyMediumStyle(context).copyWith(
                                              color: APPSTYLE_BackgroundWhite
                                          ),
                                        ),
                                        addHorizontalSpace(APPSTYLE_SpaceSmall),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            border:
                                            Border.all(color: APPSTYLE_PrimaryColorBg, width: 2),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                              child: Text(
                                                "30",
                                                style: getHeadlineLargeStyle(context).copyWith(
                                                  color: APPSTYLE_PrimaryColorBg
                                                ),
                                              )),
                                        ),
                                        addHorizontalSpace(APPSTYLE_SpaceSmall),
                                          Text(
                                            Localizations.localeOf(context)
                                                .languageCode
                                                .toString() ==
                                                'en'
                                                ?"Days":"بقي",
                                          style: getBodyMediumStyle(context).copyWith(
                                              color: APPSTYLE_BackgroundWhite
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ),
                      ],
                    ),
                    addVerticalSpace(APPSTYLE_SpaceLarge),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: screenwidth*.6,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(APPSTYLE_BackgroundWhite),
                                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                        const EdgeInsets.symmetric(
                                            horizontal: APPSTYLE_SpaceMedium, vertical: APPSTYLE_SpaceExtraSmall)),
                                    shape: MaterialStateProperty.all<OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(1000)))
                                ),
                                child:   FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text('renew_subscription'.tr,
                                      style: getLabelLargeStyle(context).copyWith(
                                          color: APPSTYLE_PrimaryColor,fontWeight: APPSTYLE_FontWeightBold),
                                      textAlign: TextAlign.center),
                                ),
                                onPressed: () {
                                  Get.toNamed(AppRouteNames.planPurchaseSubscriptionPlansCategoryListRoute);
                                })),
                      ],
                    ),
                    addVerticalSpace(APPSTYLE_SpaceExtraSmall ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: screenwidth*.6,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      const EdgeInsets.symmetric(
                                          horizontal: APPSTYLE_SpaceMedium, vertical: APPSTYLE_SpaceExtraSmall)),
                                  shape: MaterialStateProperty.all<OutlinedBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(1000)))
                              ),
                                child:   FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text('book_an_appointment'.tr,
                                      style: getLabelLargeStyle(context).copyWith(
                                          color: APPSTYLE_BackgroundWhite,fontWeight: APPSTYLE_FontWeightBold),
                                      textAlign: TextAlign.center),
                                ),
                                onPressed: () {
                                  showLogoutConfirmDialogue(context);
                                })),
                      ],
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

    String getGreetingText() {
      DateTime currentDate = DateTime.now();
      print("currentDate.hour");
      print(currentDate.hour);
      if(currentDate.hour<12){
        return "good_morning";
      }else if(currentDate.hour<16){
        return "good_afternoon";
      }else{
        return "good_evening";
      }
    }



    void showLogoutConfirmDialogue(BuildContext context ) async {

      final dialogTitleWidget = Text('confirm_appointment'.tr,style: getHeadlineMediumStyle(context).copyWith(color: APPSTYLE_Grey80,fontWeight: APPSTYLE_FontWeightBold));
      final dialogTextWidget = Text(  'confirm_appointment_message'.tr,style: getBodyMediumStyle(context));

      final updateButtonTextWidget = Text('yes'.tr,style: TextStyle(color: APPSTYLE_PrimaryColor),);
      final updateButtonCancelTextWidget = Text('no'.tr,style: TextStyle(color: APPSTYLE_Black),);

      updateLogoutAction() {

      }

      updateAction() {
        Navigator.pop(context);
      }

      List<Widget> actions = [

        TextButton(
            onPressed:updateAction,
            style: APPSTYLE_TextButtonStylePrimary.copyWith(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(
                    horizontal: APPSTYLE_SpaceLarge,
                    vertical: APPSTYLE_SpaceSmall))),
            child:  updateButtonCancelTextWidget),


        TextButton(
            onPressed:updateLogoutAction,
            style: APPSTYLE_TextButtonStylePrimary.copyWith(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
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

  Future<void> handleRequestSupportClick(BuildContext buildContext ,bool isWhatsapp) async {
    final Uri callUrl = Uri(
        scheme: 'tel',
        path: sharedController.supportNumber.value
    );
    final whatsappUrl = Uri.parse("https://wa.me/${sharedController.supportNumber.value}");
    var canLaunch = false;
    if(isWhatsapp){
      canLaunch = await UrlLauncher.canLaunchUrl(whatsappUrl);
    }else{
      canLaunch = await UrlLauncher.canLaunchUrl(callUrl);
    }
    if(canLaunch){
      if(isWhatsapp){
        UrlLauncher.launchUrl(whatsappUrl);
      }else{
        UrlLauncher.launchUrl(callUrl);
      }
    }else{
      showSnackbar(buildContext, "not_able_to_connect".tr, "error");
    }

  }
}
