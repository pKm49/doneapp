import 'package:doneapp/shared_module/constants/available_languages.shared.constant.dart';
import 'package:doneapp/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:doneapp/shared_module/controllers/controller.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class LanguagePreviewButtonComponentShared extends StatelessWidget {

  bool? isPrimaryMode;

  LanguagePreviewButtonComponentShared({super.key, this.isPrimaryMode});

  final sharedController = Get.find<SharedController>();


  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth * .18,
      height: 35,
      decoration: APPSTYLE_BorderedContainerDarkSmallDecoration.copyWith(
          borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),

          border: Border.all(color: APPSTYLE_Grey40, width: .5),

          color: APPSTYLE_BackgroundWhite),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                 sharedController.changeLanguage('en', false);
              },
              child: Container(
                alignment: Alignment.center,
                decoration:
                    APPSTYLE_BorderedContainerDarkSmallDecoration.copyWith(
                        borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),

                        border:
                            Border.all(color: Colors.transparent, width: .2),
                        color: Localizations.localeOf(context)
                                    .languageCode
                                    .toString() ==
                                'en'
                            ? isPrimaryMode==true?APPSTYLE_PrimaryColor: APPSTYLE_Black
                            : APPSTYLE_BackgroundWhite),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'En',
                    style: TextStyle(
                        color: Localizations.localeOf(context)
                                    .languageCode
                                    .toString() ==
                                'en'
                            ? APPSTYLE_BackgroundWhite
                            : APPSTYLE_Black,
                        fontSize: APPSTYLE_FontSize12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                  sharedController.changeLanguage('ar', false);
              },
              child: Container(
                alignment: Alignment.center,
                decoration:
                    APPSTYLE_BorderedContainerDarkSmallDecoration.copyWith(
                        borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),

                        border:
                            Border.all(color: Colors.transparent, width: .2),
                        color: Localizations.localeOf(context)
                                    .languageCode
                                    .toString() ==
                                'ar'
                            ? isPrimaryMode==true?APPSTYLE_PrimaryColor: APPSTYLE_Black
                            : APPSTYLE_BackgroundWhite),
                child:  FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text('ع',
                      style: TextStyle(
                          color: Localizations.localeOf(context)
                                      .languageCode
                                      .toString() ==
                                  'ar'
                              ? APPSTYLE_BackgroundWhite
                              : APPSTYLE_Black,

                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
