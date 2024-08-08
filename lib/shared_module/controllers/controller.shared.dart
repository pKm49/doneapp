import 'package:doneapp/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:doneapp/shared_module/constants/default_values.constants.shared.dart';
import 'package:doneapp/shared_module/constants/valid_addressauthor_modes.constants.shared.dart';
import 'package:doneapp/shared_module/constants/valid_phoneverification_modes.constants.shared.dart';
import 'package:doneapp/shared_module/models/my_subscription.model.shared.dart';
import 'package:doneapp/shared_module/models/notification.model.shared.dart';
import 'package:doneapp/shared_module/models/sendotp_credential.model.auth.dart';
import 'package:doneapp/shared_module/models/user_data.model.shared.dart';
import 'package:doneapp/shared_module/services/http-services/http.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/app_update_checker.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/local_storage.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedController extends GetxController {
  var selectedLanguage = "".obs;
  var mobile = "".obs;
  var isUserDataFetching = false.obs;
  var isNotificationsFetching = false.obs;
  var isDeviceTokenUpdating = false.obs;
  var userData = mapUserData({}).obs;
  var notifications = <AppNotification>[].obs;
  var mySubscriptions = <MySubscription>[].obs;
  var supportNumber = "".obs;

  //  Mobile Verification
  var isOtpVerifying = false.obs;
  var isOtpSending = false.obs;

  Rx<TextEditingController> mobileTextEditingController = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> setInitialScreen() async {
    var sharedHttpService = SharedHttpService();
    await sharedHttpService.getAccessToken();
    getSupportNumber();
    selectedLanguage.value = "";
    mobile.value = "";
    AppUpdateChecker appUpdateChecker = AppUpdateChecker();

    bool isUpdateAvailable = await appUpdateChecker.checkStatus();

    print("isUpdateAvailable");
    print(isUpdateAvailable);
    if (!isUpdateAvailable) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final String? tSelectedLanguage = prefs.getString('selectedLanguage');
      final String? tMobile = prefs.getString('mobile');

      if (tSelectedLanguage != null && tSelectedLanguage != '') {
        changeLanguage(tSelectedLanguage, false);
        selectedLanguage.value = tSelectedLanguage;
      }

      if (tMobile != null && tMobile != '') {
        mobile.value = tMobile;
      }

      if (mobile.value.isNotEmpty) {
        isUserDataFetching.value = true;
        userData.value = await sharedHttpService.getProfileData(mobile.value);
        mySubscriptions.value =
            await sharedHttpService.getMySubscriptions(mobile.value);
        print("user data fetched");
        print("mySubscriptions data fetched");
        isUserDataFetching.value = false;

        // Decide route based on user data id and subscription status.
        if (userData.value.id != -1) {
          saveDeviceToken();
          Get.offAllNamed(AppRouteNames.homeRoute);
        } else {
          var sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString("mobile", "");
          Get.toNamed(AppRouteNames.welcomeScreenRoute);
        }
      } else {
        debugPrint("no mobile set but language is set");
        Get.toNamed(AppRouteNames.welcomeScreenRoute);
      }
    }
  }

  updateUserData(UserData tUserData) {
    userData.value = tUserData;
  }

  saveDeviceToken() async {
    var sharedHttpService = SharedHttpService();
    String deviceToken = await getFirebaseMessagingToken();
    bool isSuccess = await sharedHttpService.saveDeviceToken(
        userData.value.mobile, deviceToken);
  }

  fetchUserData(String targetRoute, String tMobile) async {
    var sharedHttpService = SharedHttpService();
    isUserDataFetching.value = true;
    mobile.value = tMobile;
    print("fetchUserData");
    print(tMobile);
    userData.value = await sharedHttpService.getProfileData(tMobile);
    mySubscriptions.value =
        await sharedHttpService.getMySubscriptions(mobile.value);
    isUserDataFetching.value = false;
    print("userData");
    print(userData.value.id);
    if (userData.value.id != -1) {
      saveDeviceToken();
      if (targetRoute != "") {
        Get.offAllNamed(targetRoute);
      }
    } else {
      if (targetRoute != "") {
        showSnackbar(Get.context!, "something_wrong".tr, "error");
      }
    }
  }

  Future<void> handleLogout() async {
    saveAuthTokenToSharedPreference("");
    userData.value = mapUserData({});
    notifications.value = [];
    Get.offAllNamed(AppRouteNames.loginRoute);
  }

  Future<void> setDeviceToken() async {
    isDeviceTokenUpdating.value = true;
    await Future<void>.delayed(
      const Duration(
        seconds: 2,
      ),
    );
    String firebaseToken = await getFirebaseMessagingToken();
  }

  Future<String> getFirebaseMessagingToken() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      String firebaseMessagingToken =
          await FirebaseMessaging.instance.getToken() ?? "";

      return firebaseMessagingToken;
    } catch (e) {
      return e.toString();
    }
  }

  changeLanguage(String language, bool isNavigation) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('selectedLanguage', language);

    selectedLanguage.value = language;
    Get.updateLocale(Locale(selectedLanguage.value));
    if (isNavigation) {
      Get.toNamed(AppRouteNames.loginRoute);
    }
  }

  Future<void> getNotifications() async {
    isNotificationsFetching.value = true;
    var sharedHttpService = SharedHttpService();
    notifications.value =
        await sharedHttpService.getNotifications(userData.value.id);
    isNotificationsFetching.value = false;
  }

  sendOtp(bool isResetPassword, bool isNavigationRequired) async {

    if(mobileTextEditingController.value.text.toString().length<7){
      showSnackbar(Get.context!, "enter_valid_mobile".tr, "error");
    }else{
      showSnackbar(Get.context!, "otp_sent".tr, "info");
      Get.toNamed(AppRouteNames.otpVerificationOtpInputRoute,
          arguments: [
            isResetPassword? VALIDPHONEVERIFICATION_MODES.reset_password:
            VALIDPHONEVERIFICATION_MODES.register]);
      // isOtpSending.value = true;
      // var sharedHttpService = new SharedHttpService();
      // bool isSuccess = await sharedHttpService.sendOtp(
      //     SendOTPCredential(mobile: "+965${mobileTextEditingController.value.text}", isResetPassword: isResetPassword));
      // isOtpSending.value = false;
      //
      // if(isSuccess){
      //   showSnackbar(Get.context!, "otp_sent".tr, "info");
      //   Get.toNamed(AppRouteNames.otpVerificationOtpInputRoute,
      //       arguments: [
      //         isResetPassword? VALIDPHONEVERIFICATION_MODES.reset_password:
      //         VALIDPHONEVERIFICATION_MODES.register]);
      // }
    }
  }

  verifyOtp (String otp, bool isResetPassword) async {
    if(otp.length!=6){
      showSnackbar(Get.context!, "enter_valid_otp".tr, "error");
    }else{
      showSnackbar(Get.context!, "otp_verified_success".tr, "info");
      if(isResetPassword){
        Get.offNamed(AppRouteNames.resetPasswordNewpasswordRoute,
            arguments: [mobileTextEditingController.value.text]);
      }else{
        Get.offNamed(AppRouteNames.otpVerificationSuccessRoute,arguments: [
          ASSETS_SUCCESSMARK,
          "otp_verified".tr,
          "otp_verified_message".tr,
          'continue'.tr,
          true,
          AppRouteNames.addressAuditRoute,
          mobileTextEditingController.value.text
        ]) ;
      }
      // isOtpVerifying.value = true;
      // var sharedHttpService = new SharedHttpService();
      // bool isVerificationSuccess = await sharedHttpService.verifyOtp( "+965${mobileTextEditingController.value.text}",otp);
      // isOtpVerifying.value = false;
      //
      // if(isVerificationSuccess){
      //   showSnackbar(Get.context!, "otp_verified".tr, "info");
      //   if(isResetPassword){
      //     Get.offNamed(AppRouteNames.resetPasswordNewpasswordRoute,arguments: [mobileTextEditingController.value.text]);
      //   }else{
      //     Get.toNamed(AppRouteNames.otpVerificationSuccessRoute,arguments: [
      //       ASSETS_SUCCESSMARK,
      //       "otp_verified".tr,
      //       "otp_verified_message".tr,
      //       'continue'.tr,
      //       true,
      //       AppRouteNames.addressAuditRoute
      //     ]) ;
      //   }
      // }

    }

  }

  getSupportNumber() async {
    var sharedHttpService = SharedHttpService();
    String tSupoortNumber = await sharedHttpService.getSupportNumber( );
    if(tSupoortNumber !=""){
      supportNumber.value = tSupoortNumber;
    }else{
      supportNumber.value = DefaultSupportNumber;
    }
  }

}
