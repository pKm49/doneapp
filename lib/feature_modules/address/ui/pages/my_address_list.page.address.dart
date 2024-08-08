 import 'package:doneapp/feature_modules/address/controllers/address.controller.dart';
import 'package:doneapp/feature_modules/address/models/shipping_address.model.address.dart';
import 'package:doneapp/feature_modules/address/ui/components/address_card.component.address.dart';
import 'package:doneapp/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp/shared_module/constants/valid_addressauthor_modes.constants.shared.dart';
import 'package:doneapp/shared_module/constants/widget_styles.constants.shared.dart';
 import 'package:doneapp/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:doneapp/shared_module/ui/components/custom_back_button.component.shared.dart';
 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class MyAddressListPage_Address extends StatefulWidget {
  const MyAddressListPage_Address({super.key});

  @override
  State<MyAddressListPage_Address> createState() =>
      _MyAddressListPage_AddressState();
}

class _MyAddressListPage_AddressState
    extends State<MyAddressListPage_Address> {

   VALIDADDRESSAUTHOR_MODES addressAuthorMode = VALIDADDRESSAUTHOR_MODES.complete_registration;
   int selectedAddress = -1;

   final GlobalKey<FormState> addressAuditFormKey = GlobalKey<FormState>();
   final addressController = Get.find<AddressController>();

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
                    'shipping_address'.tr,
                    style: getHeadlineLargeStyle(context).copyWith(
                        fontWeight: APPSTYLE_FontWeightBold),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
          actions: [
            Container(
                decoration: APPSTYLE_ShadowedContainerExtraSmallDecoration.copyWith(
                  color: APPSTYLE_Black,
                  boxShadow: [
                    const BoxShadow(
                      color: APPSTYLE_Grey80Shadow24,
                      offset: Offset(0, 1.0),
                      blurRadius: APPSTYLE_BlurRadiusLarge,
                    ),
                  ],
                ),
                padding: APPSTYLE_SmallPaddingAll,
                child: Icon(Ionicons.add,color: APPSTYLE_BackgroundWhite,)),
            addHorizontalSpace(APPSTYLE_SpaceLarge)
          ],
        ) ,
        body: SafeArea(
          child: Container(
            height: screenheight,
            child:ListView.builder(
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return AddressCardComponentShared(
                  isSelected: selectedAddress == index,
                  onSelected: () {
                  },
                  onEditSelected: () {
                    Get.toNamed(AppRouteNames.addressAuditRoute);
                  },
                  shippingAddress:mapAddress({

                  }),
                );
              },
            )
          ),
        ));
  }
}
