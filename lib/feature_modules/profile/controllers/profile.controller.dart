import 'package:doneapp/feature_modules/profile/models/referral_data.profile.model.dart';
import 'package:doneapp/feature_modules/profile/services/http.profile.service.dart';
import 'package:doneapp/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:doneapp/shared_module/controllers/controller.shared.dart';
import 'package:doneapp/shared_module/models/general_item.model.shared.dart';
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
  var referralData = mapReferralData({}).obs;

  var isUserDataFetching = false.obs;
  var isRefferalDataFetching = false.obs;
  var userData = mapUserData({}).obs;
  var isProfileUpdating = false.obs;
  var isAllergiesFetching = false.obs;
  var isAllergiesUpdating = false.obs;
  var isIngredientsFetching = false.obs;
  var ingredients = <GeneralItem>[].obs;
  var allergies = <GeneralItem>[].obs;
  var ingredientsToShow = <GeneralItem>[].obs;

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
      showSnackbar(Get.context!, "couldnt_load_profiledata".tr, "error");
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
        Get.back();
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

  getRefferalData() async {
    if(! isRefferalDataFetching.value){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? tMobile = prefs.getString('mobile');
      if (tMobile != null && tMobile != '') {
        isRefferalDataFetching.value = true;
        var profileHttpService = ProfileHttpService();
        referralData.value = await profileHttpService.getRefferalData(tMobile);
        isRefferalDataFetching.value = false;
      }else {
        showSnackbar(Get.context!, "couldnt_load_profiledata".tr, "error");
        showSnackbar(Get.context!, "login_message".tr, "error");
        Get.offAllNamed(AppRouteNames.loginRoute);
      }

    }

  }

  getIngredients() async {
    if(! isIngredientsFetching.value){
      isIngredientsFetching.value = true;
      var profileHttpService = ProfileHttpService();
      ingredients.value = await profileHttpService.getIngredients();
      ingredientsToShow.value = ingredients.value;
      print("getIngredients");
      print(ingredientsToShow.length);
      print(ingredients.length);
      isIngredientsFetching.value = false;
    }
  }

  getAllergies() async {
    if(! isAllergiesFetching.value){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? tMobile = prefs.getString('mobile');
      if (tMobile != null && tMobile != '') {
        isAllergiesFetching.value = true;
        var profileHttpService = ProfileHttpService();
        allergies.value = await profileHttpService.getAllergies(tMobile);
        isAllergiesFetching.value = false;
      }else {
        showSnackbar(Get.context!, "couldnt_load_profiledata".tr, "error");
        showSnackbar(Get.context!, "login_message".tr, "error");
        Get.offAllNamed(AppRouteNames.loginRoute);
      }

    }

  }
  updateAllergies() async {
    if(! isAllergiesUpdating.value && allergies.isNotEmpty){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? tMobile = prefs.getString('mobile');
      if (tMobile != null && tMobile != '') {
        isAllergiesUpdating.value = true;
        var profileHttpService = ProfileHttpService();
        bool isSuccess = await profileHttpService.updateAllergies(allergies,tMobile);
        isAllergiesUpdating.value = false;
        if(isSuccess){
          Get.back();
          showSnackbar(Get.context!, "allergies_updated_successfully".tr, "info");

        }
      }else {
        showSnackbar(Get.context!, "couldnt_load_profiledata".tr, "error");
        showSnackbar(Get.context!, "login_message".tr, "error");
        Get.offAllNamed(AppRouteNames.loginRoute);
      }

    }

  }

  Future<void> deleteAccount() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    final String? mobile = sharedPreferences.getString('mobile');

    if (mobile != null && mobile != "") {
      var profileHttpService = new ProfileHttpService();
      bool isSuccess = await profileHttpService.deleteAccount(mobile);

      if (isSuccess) {
        showSnackbar(Get.context!, "account_delete_success_message".tr, "info");
        showSnackbar(Get.context!, "our_rep_will_contact".tr, "info");
      }
    }
  }

  void updateIngredientsListByQuery(String query) {
    if (query== "") {
      ingredientsToShow.value = ingredients.value;
    } else {
       List<GeneralItem> tIngredients = [];
       for (var element in ingredients) {
         if(element.name.toLowerCase().contains(query) ||
         element.arabicName.contains(query)){
           tIngredients.add(element);
         }
       }
       ingredientsToShow.value = tIngredients;
    }
  }

  void updateAllergyValues(GeneralItem ingredient) {
    if(allergies.map((element) => element.id).toList().contains(ingredient.id)){
      List<GeneralItem> tAllergies = [];
      for (var element in allergies) {
        if(element.id != ingredient.id){
          tAllergies.add(element);
        }
      }
      allergies.value = tAllergies;
    }else{
      allergies.add(ingredient);
    }
  }

}
