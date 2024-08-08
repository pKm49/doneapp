import 'package:doneapp/feature_modules/auth/models/register_credential.model.auth.dart';
import 'package:doneapp/shared_module/models/sendotp_credential.model.auth.dart';
import 'package:doneapp/feature_modules/auth/services/http.services.auth.dart';
import 'package:doneapp/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:doneapp/shared_module/constants/available_genders.shared.constant.dart';
import 'package:doneapp/shared_module/constants/available_sources.shared.constant.dart';
import 'package:doneapp/shared_module/controllers/controller.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {

  Rx<TextEditingController> firstNameEnglishTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> lastNameEnglishTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> firstNameArabicTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> lastNameArabicTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> emailTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> mobileTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> passwordTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> confirmPasswordTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> heightTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> weightTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> streetTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> jedhaTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> houseNumberTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> floorNumberTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> flatNumberTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> commentsTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> otherSourceTextEditingController =
      TextEditingController().obs;

  var isRegisterSubmitting = false.obs;
  var isOtpSending = false.obs;

  var gender = VALID_GENDERS.male.name;
  var source = VALID_SOURCES.social.name;
  var nickname = "".obs;

  var zoneId =  (-1).obs;
  var zoneCount = 0.obs;
  var areaCount = 0.obs;
  var blockCount = 0.obs;
  var zoneName = "".obs;
  var areaName = "".obs;
  var blockName = "".obs;
  var areaId =  (-1).obs;
  var blockId =  (-1).obs;
  var profilePictureUrl = ASSETS_DEFAULTPROFILEPIC.obs;

  handleRegistration() async {
    isRegisterSubmitting.value = true;
    var authHttpService = new AuthHttpService();
    bool isSuccess = await authHttpService.register(RegisterCredential(
        mobile: mobileTextEditingController.value.text,
        password: passwordTextEditingController.value.text,
        firstName: firstNameEnglishTextEditingController.value.text,
        lastName: lastNameEnglishTextEditingController.value.text,
        firstNameArabic: firstNameArabicTextEditingController.value.text,
        lastNameArabic: lastNameArabicTextEditingController.value.text,
        email: emailTextEditingController.value.text,
        dateOfBirth: "",
        gender: gender,
        height: double.parse(heightTextEditingController.value.text),
        weight: double.parse(heightTextEditingController.value.text),
        source: source,
        nickname: nickname.value,
        area: areaId.value,
        block: blockId.value,
        street: streetTextEditingController.value.text,
        jedha: jedhaTextEditingController.value.text,
        houseNumber: int.parse(houseNumberTextEditingController.value.text),
        floorNumber: int.parse(floorNumberTextEditingController.value.text),
        comments: commentsTextEditingController.value.text,
        profile_picture: profilePictureUrl.value,
        other_source: otherSourceTextEditingController.value.text));
    isRegisterSubmitting.value = false;
    if (isSuccess) {
      var sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString(
          "mobile", mobileTextEditingController.value.text);
      showSnackbar(Get.context!, "account_created".tr, "info");
      final sharedController = Get.find<SharedController>();
      sharedController.fetchUserData(
          AppRouteNames.planPurchaseSubscriptionPlansCategoryListRoute,
          mobileTextEditingController.value.text);
    }
  }

}
