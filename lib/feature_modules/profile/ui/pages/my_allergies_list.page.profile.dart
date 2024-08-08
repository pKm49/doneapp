  import 'package:doneapp/shared_module/constants/style_params.constants.shared.dart';
 import 'package:doneapp/shared_module/constants/widget_styles.constants.shared.dart';
 import 'package:doneapp/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:doneapp/shared_module/ui/components/custom_back_button.component.shared.dart';
 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class MyAllergiesListPage_Profile extends StatefulWidget {
  const MyAllergiesListPage_Profile({super.key});

  @override
  State<MyAllergiesListPage_Profile> createState() =>
      _MyAllergiesListPage_ProfileState();
}

class _MyAllergiesListPage_ProfileState
    extends State<MyAllergiesListPage_Profile> {
  List<String> selectedItems = [];

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
                    'allergies'.tr,
                    style: getHeadlineLargeStyle(context).copyWith(
                        fontWeight: APPSTYLE_FontWeightBold),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
          actions: [
            Icon(Ionicons.search,color: APPSTYLE_Grey60),
            addHorizontalSpace(APPSTYLE_SpaceLarge)
          ],
        ) ,
        body: SafeArea(
          child: Container(
            height: screenheight,
            child:Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: APPSTYLE_LargePaddingHorizontal,
                    child: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Soybeans',
                                style: getBodyMediumStyle(context)),
                            Checkbox(
                                checkColor: APPSTYLE_BackgroundOffWhite,
                                activeColor: APPSTYLE_PrimaryColor,
                                value: selectedItems.contains("Soybeans"),
                                onChanged: (value) {
                                  if(selectedItems.contains("Soybeans")){
                                    selectedItems.remove("Soybeans");
                                  }else{
                                    selectedItems.add("Soybeans");
                                  }
                                  setState(() {});
                                }),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                addVerticalSpace(APPSTYLE_SpaceMedium),
                Container(
                  width: screenwidth-(APPSTYLE_SpaceLarge*2),
                  height: 150,
                  padding: APPSTYLE_SmallPaddingAll,
                  decoration: APPSTYLE_ShadowedContainerSmallDecoration.copyWith(color: APPSTYLE_Grey20),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      for(var i=0;i<selectedItems.length;i++)
                        InkWell(
                          onTap: (){
                            selectedItems.remove(selectedItems[i]);
                            setState(() {

                            });
                          },
                          child: Container(
                            decoration: APPSTYLE_BorderedContainerSmallDecoration,
                            margin: EdgeInsets.only(right: APPSTYLE_SpaceSmall,bottom: APPSTYLE_SpaceSmall),
                            padding: APPSTYLE_ExtraSmallPaddingAll.copyWith(right: APPSTYLE_SpaceSmall,left: APPSTYLE_SpaceSmall),
                            child: Wrap(
                              children: [Text(selectedItems[i],style: getLabelLargeStyle(context)),addHorizontalSpace(APPSTYLE_SpaceSmall),
                                Icon(Ionicons.close,size: APPSTYLE_FontSize14)],
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                addVerticalSpace(APPSTYLE_SpaceMedium),
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
            )
          ),
        ));
  }
}
