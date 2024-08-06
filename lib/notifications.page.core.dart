
import 'package:doneapp/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:doneapp/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:doneapp/shared_module/ui/components/language_preview_button.component.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsPage_Core extends StatelessWidget {
  const NotificationsPage_Core({super.key});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
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
                  'notifications'.tr,
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
          child: Column(
            children: [
              Expanded(child: ListView(
                children: [
                  Container(
                    decoration: APPSTYLE_ShadowedContainerSmallDecoration.copyWith(
                        color:  APPSTYLE_BackgroundWhite
                    ),
                    padding: APPSTYLE_MediumPaddingAll,
                    margin: APPSTYLE_LargePaddingAll.copyWith(bottom: 0),
                    width: screenwidth,
                    child: Wrap(
                      direction: Axis.vertical,
                      children: [
                        Container(
                          width: screenwidth - ((APPSTYLE_SpaceMedium*2)+(APPSTYLE_SpaceLarge*2)),
                          child: Text("New Year Offers waiting for you",
                              style: getBodyMediumStyle(context).copyWith(
                                  color: APPSTYLE_Grey60, fontWeight: APPSTYLE_FontWeightBold)),
                        ),
                        addVerticalSpace(APPSTYLE_SpaceSmall),
                        Container(
                          width: screenwidth - ((APPSTYLE_SpaceMedium*2)+(APPSTYLE_SpaceLarge*2)),
                          child: Text('At DietStep, we\'re committed to helping you achieve your health'
                              ' and wellness goals in a way that\'s tailored to your lifestyle. ',
                              style: getLabelLargeStyle(context).copyWith(
                                  color:  APPSTYLE_Grey40)),
                        ),
                        addVerticalSpace(APPSTYLE_SpaceSmall),
                        Container(
                          width: screenwidth - ((APPSTYLE_SpaceMedium*2)+(APPSTYLE_SpaceLarge*2)),
                          child: Text("25 January, 2024",
                              style: getBodyMediumStyle(context).copyWith(
                                  color: APPSTYLE_Grey80, fontWeight: APPSTYLE_FontWeightLight)),
                        ),
                      ],
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
