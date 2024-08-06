 
import 'package:doneapp/env.dart' as env;
import 'package:doneapp/shared_module/constants/http_request_endpoints.constants.shared.dart';
import 'package:doneapp/shared_module/models/http_response.model.shared.dart';
import 'package:doneapp/shared_module/models/my_subscription.model.shared.dart';
import 'package:doneapp/shared_module/models/notification.model.shared.dart';
import 'package:doneapp/shared_module/models/user_data.model.shared.dart';
import 'package:doneapp/shared_module/services/http-services/http_request_handler.service.shared.dart';

class SharedHttpService {
  
  getAccessToken() async {
    Map<String, dynamic> params = {};
    params["client_id"] = env.clientId;
    params["client_secret"] = env.clientSecret;
    AppHttpResponse response = await postRequest(
        SharedHttpRequestEndpoint_GetAccessToken, {'params': params});
    print("response is");
    print(response.statusCode);
    print(response.message);
    return;
  }

  Future<UserData> getProfileData(String mobile) async {
    try {
      Map<String, dynamic> params = {};
      params["mobile"] = mobile;
      AppHttpResponse response =
          await getRequest(SharedHttpRequestEndpoint_GetProfileData, params);
      print("getProfileData");
      print(response);
      if (response.statusCode == 200 && response.data != null) {
        return mapUserData(response.data);
      }
      return mapUserData({});
    } catch (e) {
      return mapUserData({});
    }
  }

  Future<List<MySubscription>> getMySubscriptions(String mobile) async {


    try{
      Map<String, dynamic> params = {};
      params["mobile"]=mobile;
      AppHttpResponse response =
      await getRequest(SharedHttpRequestEndpoint_GetCustomerSubscriptions,params);

      List<MySubscription> tempMealCategories = [];
      if (response.statusCode == 200 && response.data != null) {
        for (var i = 0; i < response.data.length; i++) {
          tempMealCategories.add(mapMySubscription(response.data[i]));
        }
      }

      return tempMealCategories;

    }catch (e){
      return [];
    }
  }


  Future<List<AppNotification>> getNotifications(int userId) async {
    try {
      List<AppNotification> notifications = [];
      AppHttpResponse response =
          await getRequest("/notification/$userId", null);
      if (response.statusCode == 200 && response.data != null) {
        for (var i = 0; i < response.data.length; i++) {
          notifications.add(mapAppNotification(response.data[i]));
        }
      }
      return notifications;
    } catch (e) {
      return [];
    }
  }

  Future<bool> saveDeviceToken(String mobile, String deviceToken) async {
    try {
      Map<String, dynamic> body = {};
      body["mobile"] = mobile;
      body["device_token"] = deviceToken;
      AppHttpResponse response =
          await postRequest("/device_token", body);

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
