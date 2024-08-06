import 'package:doneapp/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp/shared_module/models/my_subscription.model.shared.dart';
import 'package:doneapp/shared_module/models/notification.model.shared.dart';
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

  //  Mobile Verification
  var mobileToVerify = "".obs;
  var otpForMobileVerification = "".obs;
  var routeToRedirectAfterOtpVerification = "".obs;
  var routeFromOtpVerificationTriggered = "".obs;
  var isOtpVerificationForRegistration = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> setInitialScreen() async {
    var sharedHttpService = SharedHttpService();
    await sharedHttpService.getAccessToken();
    print("isUpdateAvailable 1");
    selectedLanguage.value = "";
    mobile.value = "";
    print("isUpdateAvailable 2");
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

        isUserDataFetching.value = false;

        // Decide route based on user data id and subscription status.
        if (userData.value.id != -1) {
          debugPrint("setInitialScreen");
          debugPrint("setInitialScreen after address");
          debugPrint(userData.value.subscription_status);
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

  triggerMobileVerification(String mobile, String fromRoute, String toRoute,bool isForRegistration) {
    mobileToVerify.value = mobile;
    otpForMobileVerification = "".obs;
    routeToRedirectAfterOtpVerification.value = toRoute;
    routeFromOtpVerificationTriggered.value = fromRoute;
    isOtpVerificationForRegistration.value = isForRegistration;
  }
}
