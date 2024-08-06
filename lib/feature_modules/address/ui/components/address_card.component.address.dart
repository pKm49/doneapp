
import 'package:doneapp/feature_modules/address/models/shipping_address.model.address.dart';
import 'package:doneapp/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:doneapp/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';

class AddressCardComponentShared extends StatelessWidget {
  ShippingAddress shippingAddress;
  GestureTapCallback onSelected;
  GestureTapCallback onEditSelected;
  bool isSelected;

  AddressCardComponentShared(
      {super.key,
      required this.shippingAddress,
      required this.isSelected,
      required this.onEditSelected,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      decoration: APPSTYLE_ShadowedContainerSmallDecoration.copyWith(
        color:APPSTYLE_BackgroundWhite,
        boxShadow: [
          const BoxShadow(
            color: APPSTYLE_Grey80Shadow24,
            offset: Offset(0, 2.0),
            blurRadius: APPSTYLE_BlurRadiusLarge,
          ),
        ],
      ),
      padding: APPSTYLE_MediumPaddingAll,
      margin: APPSTYLE_LargePaddingAll.copyWith(bottom: 0),
      width: screenwidth,
      child: Wrap(
        direction: Axis.vertical,
        children: [
          Container(
            width: screenwidth - ((APPSTYLE_SpaceMedium*2)+(APPSTYLE_SpaceLarge*2)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: onSelected,
                    child: Text(shippingAddress.name,
                        style: getBodyMediumStyle(context).copyWith(
                            color:isSelected?APPSTYLE_PrimaryColor: APPSTYLE_Grey60, fontWeight: APPSTYLE_FontWeightBold)),
                  ),
                ),

                InkWell(
                    onTap: onEditSelected,
                    child: Icon(Ionicons.create_outline))
              ],
            ),
          ),
          InkWell(
              onTap: onSelected,child: addVerticalSpace(APPSTYLE_SpaceMedium)),
          InkWell(
            onTap: onSelected,
            child: Container(
              width: screenwidth - ((APPSTYLE_SpaceMedium*2)+(APPSTYLE_SpaceLarge*2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(shippingAddress.addressString,
                        style: getLabelLargeStyle(context).copyWith(
                            color: isSelected?APPSTYLE_Grey60: APPSTYLE_Grey40)),
                  ),
                  addHorizontalSpace(APPSTYLE_SpaceMedium),
                  Container(
                    width: screenwidth*.15,
                    height: screenwidth*.15,
                      decoration: APPSTYLE_BorderedContainerSmallDecoration,
                      clipBehavior: Clip.hardEdge,
                      child: Center(child: Image.asset(ASSETS_LOCATIONPICKER, width:screenwidth*.06)))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
