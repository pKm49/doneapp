import 'package:doneapp/shared_module/constants/asset_urls.constants.shared.dart';
 import 'package:doneapp/feature_modules/auth/services/http.services.auth.dart';
import 'package:doneapp/shared_module/constants/app_route_names.constants.shared.dart';
 import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ResetPasswordController extends GetxController {

  Rx<TextEditingController> passwordTextEditingController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordTextEditingController = TextEditingController().obs;
  var isOtpVerifying = false.obs;
  var isOtpSending = false.obs;
  var isResetingPassword = false.obs;
  var mobile = "".obs;

  updateMobile(String nMobile){
    mobile.value = nMobile;
  }


  resetPassword() async {
    isResetingPassword.value = true;
    var authHttpService = new AuthHttpService();
    bool isResetSuccess = await authHttpService.resetPassword( "${mobile}",
        passwordTextEditingController.value.text);
    isResetingPassword.value = false;

    if(isResetSuccess){
      // Get.offAllNamed(AppRouteNames.loginRoute);
      Get.toNamed(AppRouteNames.otpVerificationSuccessRoute,arguments: [
        ASSETS_SUCCESSMARK,"password_changed","password_changed_message",
        'back_to_login',false,AppRouteNames.loginRoute,mobile.value
      ])?.then((value) => Get.toNamed(AppRouteNames.loginRoute));
    }
  }

}