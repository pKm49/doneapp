
import 'package:doneapp/feature_modules/address/models/shipping_address.model.address.dart';
import 'package:doneapp/feature_modules/address/services/http.services.address.dart';
import 'package:doneapp/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp/shared_module/constants/valid_addressauthor_modes.constants.shared.dart';
import 'package:doneapp/shared_module/models/general_item.model.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressController extends GetxController {

  Rx<TextEditingController> streetTextEditingController = TextEditingController().obs;
  Rx<TextEditingController> apartmentNumberTextEditingController = TextEditingController().obs;
  Rx<TextEditingController> houseNumberTextEditingController = TextEditingController().obs;
  Rx<TextEditingController> floorNumberTextEditingController = TextEditingController().obs;
  Rx<TextEditingController> commentsTextEditingController = TextEditingController().obs;
  Rx<TextEditingController> jedhaTextEditingController = TextEditingController().obs;

  var addressAuthorMode = VALIDADDRESSAUTHOR_MODES.complete_registration.obs;

  var areaCount = 0.obs;
  var blockCount = 0.obs;
  var areaName = "".obs;
  var blockName = "".obs;
  var areaId =  (-1).obs;
  var blockId =  (-1).obs;

  var selectedArea = "Select Area".obs;
  var isAddressAuditing = false.obs;
  var isAddressDeleting = false.obs;

  var areas = <GeneralItem>[].obs;
  var isAreasFetching = false.obs;
  var blocks = <GeneralItem>[].obs;
  var isBlocksFetching = false.obs;
  var customerAddressList = <Address>[].obs;
  var isCustomerAddressListFetching = false.obs;
  var currentAddress = mapAddress({}).obs;

  @override
  void onInit() {
    super.onInit();
  }

  void setFromRoute(VALIDADDRESSAUTHOR_MODES tFrom) {
    addressAuthorMode.value = tFrom;
  }


  Future<void> getAreas(  ) async {
    isAreasFetching.value = true;
    areas.value = [];
    var addressHttpService = new AddressHttpService();
    areas.value =
    await addressHttpService.getAreas();
    isAreasFetching.value = false;

  }

  Future<void> getBlocks(int tAreaId ) async {
    isBlocksFetching.value = true;
    blocks.value = [];
    areaId.value = tAreaId;
    var addressHttpService = new AddressHttpService();
    blocks.value =
    await addressHttpService.getBlocks(tAreaId);
    isBlocksFetching.value = false;

  }

  changeBlock(int tBlockId){
    blockId.value = tBlockId;
  }


  Future<void> getCustomerAddressList() async {

    var sharedPreferences = await SharedPreferences.getInstance();
    final String? mobile = sharedPreferences.getString('mobile');

    if(mobile != null && mobile !=""){
      isCustomerAddressListFetching.value = true;
      customerAddressList.value = [];
      var addressHttpService = new AddressHttpService();
      customerAddressList.value =
      await addressHttpService.getUserAddressess(mobile);
      isCustomerAddressListFetching.value = false;
    }

  }

  Future<void> deleteAddress(int id) async {
    List<Address> tAddressList = customerAddressList.where((p0) => p0.id==id).toList();

    if(tAddressList.isNotEmpty){
      isAddressDeleting.value = true;
      var addressHttpService = new AddressHttpService();
      bool isSuccess =
      await addressHttpService.deleteUserAddressess( id);
      isAddressDeleting.value = false;
      getCustomerAddressList();

    }

  }


  Future<void> changeAuditAddress(int id) async {

    List<Address> tAddressList = customerAddressList.where((p0) => p0.id==id).toList();

    if (tAddressList.isNotEmpty) {

      currentAddress.value = tAddressList[0];


      streetTextEditingController.value.text = currentAddress.value.street;
      apartmentNumberTextEditingController.value.text =currentAddress.value.apartmentNo==-1?"": currentAddress.value.apartmentNo.toString();
      houseNumberTextEditingController.value.text = currentAddress.value.houseNumber==-1?"":currentAddress.value.houseNumber.toString();
      floorNumberTextEditingController.value.text = currentAddress.value.floorNumber==-1?"":currentAddress.value.floorNumber.toString();
       areaId.value = currentAddress.value.areaId;
      debugPrint("changeAuditAddress");
      debugPrint(areaId.value.toString());
      debugPrint( streetTextEditingController.value.text.toString());
      blockId.value = currentAddress.value.blockId;

      if(areaId.value != -1){
        getBlocks(areaId.value);
      }


    }else{
      currentAddress.value = mapAddress({});
    }

    Get.toNamed(AppRouteNames.addressAuditRoute,arguments: [VALIDADDRESSAUTHOR_MODES.author_address]);
  }


  Future<void> auditAddress() async {

        if(   streetTextEditingController.value.text !=""
            && houseNumberTextEditingController.value.text !="" && floorNumberTextEditingController.value.text !=""){


          var sharedPreferences = await SharedPreferences.getInstance();
          final String? mobile = sharedPreferences.getString('mobile');

          if(mobile != null && mobile !=""){
            isAddressAuditing.value = true;
            var addressHttpService = new AddressHttpService();
            bool isSuccess =
            await addressHttpService.auditAddress( Address(
                id: currentAddress.value.id,
                name: "",
                comments: commentsTextEditingController.value.text,
                apartmentNo: int.parse(apartmentNumberTextEditingController.value.text.toString().trim()),
              houseNumber: int.parse(houseNumberTextEditingController.value.text.toString().trim()),
              floorNumber: int.parse(floorNumberTextEditingController.value.text.toString().trim()),
                street: streetTextEditingController.value.text,
                areaId: areaId.value,
                areaName: '',
                areaNameArabic: '',
                blockId: blockId.value,
                blockName: '',
                blockNameArabic: '',
                jedha:  jedhaTextEditingController.value.text,
            ),mobile,currentAddress.value.id == -1);
            isAddressAuditing.value = false;
            if(isSuccess){
              getCustomerAddressList();
              showSnackbar(Get.context!,currentAddress.value.id == -1?
              "address_added_successfully".tr:"address_updated_successfully".tr, "info");
              Get.back();
            }
          }
        }else{
          showSnackbar(Get.context!, "check_input_and_try_again".tr, "error");
        }


  }




}
