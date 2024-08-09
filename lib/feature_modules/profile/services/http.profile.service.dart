import 'package:doneapp/feature_modules/profile/constants/http_request_endpoints.constants.profile.dart';
import 'package:doneapp/feature_modules/profile/models/allergy_dislikes.profile.model.dart';
import 'package:doneapp/feature_modules/profile/models/query_response.profile.model.dart';
import 'package:doneapp/feature_modules/profile/models/referral_data.profile.model.dart';
import 'package:doneapp/shared_module/models/general_item.model.shared.dart';
import 'package:doneapp/shared_module/models/http_response.model.shared.dart';
import 'package:doneapp/shared_module/models/user_data.model.shared.dart';
import 'package:doneapp/shared_module/services/http-services/http_request_handler.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:get/get.dart'; 
class ProfileHttpService {
  Future<UserData> getProfileData(String mobile) async {
    try{
      Map<String, dynamic> params = {};
      params["mobile"]=mobile;
      AppHttpResponse response =
      await getRequest(ProfileHttpRequestEndpoint_Profile,params);
      if(response.statusCode== 200 && response.data != null){
        return mapUserData(response.data[0]);
      }
      return mapUserData({});
    }catch (e){
      return mapUserData({});
    }
  }

  Future<ReferralData> getRefferalData(String mobile) async {
    try{
      Map<String, dynamic> params = {};
      params["mobile"]=mobile;
      AppHttpResponse response =
      await getRequest(ProfileHttpRequestEndpoint_GetRefferalData,params);
      if(response.statusCode== 200 && response.data != null){
        return mapReferralData(response.data[0]);
      }
      return mapReferralData({});
    }catch (e){
      return mapReferralData({});
    }
  }
  Future<String> updateProfileData(UserData userData, String mobile ) async {

    try{
      AppHttpResponse response = await patchRequest(ProfileHttpRequestEndpoint_Profile,
          userData.toJson() );
      return response.statusCode == 200?"":response.message;

    }catch (e){
      showSnackbar(Get.context!, "something_wrong".tr, "error");
      return "something_wrong".tr;
    }
  }

  Future<bool> updateAllergyDislikes(AllergyDislikes allergyDislikes, String mobile ) async {

    try{
      AppHttpResponse response = await postRequest(ProfileHttpRequestEndpoint_UpdateAllergyDislikes,
          {"params":{
            "mobile": mobile,
            "allergy_categories": allergyDislikes.allergyCategories,
            "allergies": allergyDislikes.allergies,
            "dislike_categories": allergyDislikes.dislikeCategories ,
            "dislikes": allergyDislikes.dislikes
          }});

      return response.statusCode == 200;

    }catch (e){
      showSnackbar(Get.context!, "something_wrong".tr, "error");
      return false;
    }
  }

  Future<List<GeneralItem>> getIngredientCategories() async {

    try{
      AppHttpResponse response =
      await getRequest(ProfileHttpRequestEndpoint_GetIngredientCategories,null);
      final List<GeneralItem> tempItems = [];

      if (response.statusCode == 200 && response.data != null) {
        for (var i = 0; i < response.data.length; i++) {
          tempItems.add(mapGeneralItem(response.data[i]));
        }
      }
      return tempItems;

    }catch (e){
      showSnackbar(Get.context!, "something_wrong".tr, "error");
      return [];
    }
  }

  Future<List<GeneralItem>> getIngredients(int categoryId) async {

    try{
      Map<String, dynamic> params = {};
      params["category"]=categoryId;
      AppHttpResponse response =
      await getRequest(ProfileHttpRequestEndpoint_GetIngredients,params);

      final List<GeneralItem> tempItems = [];

      if (response.statusCode == 200 && response.data != null) {
        for (var i = 0; i < response.data.length; i++) {
          tempItems.add(mapGeneralItem(response.data[i]));
        }
      }
      return tempItems;

    }catch (e){
      showSnackbar(Get.context!, "something_wrong".tr, "error");
      return [];
    }
  }

  Future<QueryResponse> getIngredientsByQuery(String searchQuery) async {

    try{
      Map<String, dynamic> params = {};
      params["keyword"]=searchQuery;
      AppHttpResponse response =
      await getRequest(ProfileHttpRequestEndpoint_SearchAllergyDislike,params);

      final List<GeneralItem> tempCategories = [];
      final List<GeneralItem> tempIngredients = [];

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['categories'] != null) {
          for (var i = 0; i < response.data['categories'].length; i++) {
            tempCategories.add(mapGeneralItem(response.data['categories'][i]));
          }
        }
        if (response.data['ingredients'] != null) {
          for (var i = 0; i < response.data['ingredients'].length; i++) {
            tempIngredients.add(mapGeneralItem(response.data['ingredients'][i]));
          }
        }

      }
      return QueryResponse(ingredients: tempIngredients, categories: tempCategories);

    }catch (e){
      showSnackbar(Get.context!, "something_wrong".tr, "error");
      return QueryResponse(ingredients: [], categories: []);
    }
  }

  Future<bool> deleteAccount(String mobile) async {

    try{
      Map<String, dynamic> params = {};
      params["mobile"]=mobile;
      AppHttpResponse response =
          await getRequest(ProfileHttpRequestEndpoint_DeleteAccount,params);

      return response.statusCode == 200;

    }catch (e){
      showSnackbar(Get.context!, "something_wrong".tr, "error");
      return false;
    }
  }

}
