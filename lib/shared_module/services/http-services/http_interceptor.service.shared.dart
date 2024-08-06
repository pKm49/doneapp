import 'dart:convert';
import 'dart:io';
import 'package:doneapp/shared_module/services/http-services/http.service.shared.dart';
import 'package:http/src/base_request.dart';
import 'package:http/src/base_response.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http_interceptor/models/interceptor_contract.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doneapp/env.dart' as env;

class AppHttpInterceptor implements InterceptorContract {

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    try {
      var sharedPreferences = await SharedPreferences.getInstance();
      var Bearer = await sharedPreferences.getString("access_token");

      request.headers["Accept"] = "*/*";
      request.headers["Content-Type"] = "application/json";

      if (Bearer != null && Bearer != "") {
        request.headers["Authorization"] = "Bearer $Bearer";
      }
    } catch (e) {
      print(e);
    }
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    // TODO: implement interceptResponse
    try {
      if (response is Response) {
        var httpResponseBody = json.decode(response.body);
        if (httpResponseBody['result'] != null) {
          if (httpResponseBody['result'] is String &&
              httpResponseBody["result"].toString().contains('UNAUTHORIZED')) {
            var sharedHttpService = new SharedHttpService();
            await sharedHttpService.getAccessToken();
          } else {
            if (httpResponseBody['result']['access_token'] != null) {
              var sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.setString("access_token",
                  httpResponseBody['result']['access_token'].toString());
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }
    return response;

  }

   @override
  Future<bool> shouldInterceptRequest() {
     return Future.value(true);

  }

  @override
  Future<bool> shouldInterceptResponse() {
    return Future.value(true);

  }
}
