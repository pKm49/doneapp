import 'package:doneapp/feature_modules/profile/services/http.profile.service.dart';
import 'package:doneapp/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:doneapp/shared_module/controllers/controller.shared.dart';
import 'package:doneapp/shared_module/models/user_data.model.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
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

  var profilePictureUrl = ASSETS_DEFAULTPROFILEPIC.obs;
  var isFileSelected = false.obs;

  var isUserDataFetching = false.obs;
  var userData = mapUserData({}).obs;
  var isProfileUpdating = false.obs;

  void updateProfilePicture(String base64encode) {
    isFileSelected.value = true;
    profilePictureUrl.value = base64encode;
  }

  getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tMobile = prefs.getString('mobile');
    if (tMobile != null && tMobile != '') {
      isUserDataFetching.value = true;
      var profileHttpService = ProfileHttpService();
      userData.value = await profileHttpService.getProfileData(tMobile);
      isUserDataFetching.value = false;
      if (userData.value.id == -1) {
        showSnackbar(Get.context!, "couldnt_load_profiledata".tr, "error");
        showSnackbar(Get.context!, "login_message".tr, "error");
        Get.offAllNamed(AppRouteNames.loginRoute);
      } else {
        firstNameEnglishTextEditingController.value.text =
            userData.value.firstName;
        firstNameArabicTextEditingController.value.text =
            userData.value.firstNameArabic;
        lastNameEnglishTextEditingController.value.text =
            userData.value.lastName;
        lastNameArabicTextEditingController.value.text =
            userData.value.lastNameArabic;
        emailTextEditingController.value.text = userData.value.email;
        profilePictureUrl.value = userData.value.profilePictureUrl;
      }
    } else {
      showSnackbar(Get.context!, "login_message".tr, "error");
      Get.offAllNamed(AppRouteNames.loginRoute);
    }
  }

  updateProfile() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    final String? mobile = sharedPreferences.getString('mobile');

    if (mobile != null && mobile != "") {
      isProfileUpdating.value = true;
      var profileHttpService = new ProfileHttpService();
      String message = await profileHttpService.updateProfileData(
          UserData(
            id: userData.value.id,
            gender: userData.value.gender,
            height: userData.value.height,
            birthday: userData.value.birthday,
            weight: userData.value.weight,
            subscriptionEndDate: userData.value.subscriptionEndDate,
            subscriptionNameArabic: userData.value.subscriptionNameArabic,
            subscriptionName: userData.value.subscriptionName,
            subscriptionRemainingDays: userData.value.subscriptionRemainingDays,
            mobile: userData.value.mobile,
            firstName: firstNameEnglishTextEditingController.value.text,
            firstNameArabic: firstNameArabicTextEditingController.value.text,
            lastName: lastNameEnglishTextEditingController.value.text,
            lastNameArabic: lastNameArabicTextEditingController.value.text,
            email: emailTextEditingController.value.text,
            customerCode: userData.value.customerCode,
            profilePictureUrl:
                isFileSelected.value ? profilePictureUrl.value : "",
          ),
          mobile);
      isProfileUpdating.value = false;

      if (message == "") {
        final sharedController = Get.find<SharedController>();
        sharedController.fetchUserData("", mobile);
        showSnackbar(Get.context!, "profile_updated_successfully".tr, "info");

      } else {
        showSnackbar(Get.context!, message, "error");
      }
    } else {
      showSnackbar(Get.context!, "couldnt_load_profiledata".tr, "error");
      showSnackbar(Get.context!, "login_message".tr, "error");
      Get.offAllNamed(AppRouteNames.loginRoute);
    }
  }
}
