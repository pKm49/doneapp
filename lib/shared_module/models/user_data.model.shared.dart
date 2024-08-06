import 'package:doneapp/shared_module/models/general_item.model.shared.dart';
import 'package:intl/intl.dart';

class UserData {
  final int id;
  final String firstName;
  final String lastName;
  final String bmi;
  final String firstNameArabic;
  final String lastNameArabic;
  final String? profilePictureUrl;
  final String mobile;
  final String mobile2;
  final String email;
  final String gender;
  final String medicalReport1;
  final String medicalReport2;
  final String subscription_progress;
  final String subscription_status;
  final String subscription_name;
  final DateTime subscription_expiryDate;
  final DateTime birthday;
  final double height;
  final double weight;
  final List<GeneralItem> allergies;
  final List<GeneralItem> allergyCategories;
  final List<GeneralItem> dislikes;
  final List<GeneralItem> dislikeCategories;

  UserData(
      {required this.id,
        required this.firstName,
        required this.lastName,
        required this.firstNameArabic,
        required this.lastNameArabic,
        required this.profilePictureUrl,
        required this.mobile,
        required this.mobile2,
        required this.email,
        required this.gender,
        required this.birthday,
        required this.subscription_progress,
        required this.medicalReport1,
        required this.medicalReport2,
        required this.height,
        required this.weight,
        required this.allergies,
        required this.allergyCategories,
        required this.dislikes,
        required this.bmi,
        required this.subscription_status,
        required this.subscription_name,
        required this.subscription_expiryDate,
        required this.dislikeCategories});
  Map toJson(){
    return profilePictureUrl==null? {
      "firstname": firstName,
      "bmi": bmi,
      "lastname": lastName,
      "mobile": mobile,
      "mobile2": mobile2,
      "email": email,
      "gender": gender,
      "birthday": convertBirthDay(birthday),
      "medical_report1": medicalReport1 == 'false' ? '' : medicalReport1,
      "medical_report2": medicalReport2 == 'false' ? '' : medicalReport2,
      "height": height,
      "weight": weight
    }:{
      "firstname": firstName,
      "lastname": lastName,
      "profile_picture":
      profilePictureUrl == 'false' ? '' : profilePictureUrl,
      "mobile": mobile,
      "mobile2": mobile2,
      "email": email,
      "gender": gender,
      "birthday": convertBirthDay(birthday),
      "medical_report1": medicalReport1 == 'false' ? '' : medicalReport1,
      "medical_report2": medicalReport2 == 'false' ? '' : medicalReport2,
      "height": height,
      "weight": weight
    };
  }
}

String convertBirthDay(DateTime birthDay) {
  final f = new DateFormat('yyyy-MM-dd');
  return f.format(birthDay);
}

UserData mapUserData(dynamic payload) {
  print("mapUserData");
  print(payload["bmi"]);
  print(payload["birthday"]);
  print(payload["subscription_end_date"]);
  print(payload["subscription_progress"]);
  print(payload["subscription_name"]);
  print(payload["subscription_status"]);
  DateTime birthday = DateTime.now();
  try {
    birthday = payload["birthday"] != null
        ? getParsableDate(payload["birthday"])
        : DateTime(1900,1,1);
  } catch (e, stack) {
    print("mapUserData birthday error");
    print(e);
    print(stack);
    birthday = DateTime(1900,1,1);
  }

  DateTime subscription_expiryDate = DateTime.now();
  try {
    subscription_expiryDate = payload["subscription_end_date"] != null
        ? getParsableDate(payload["subscription_end_date"])
        : DateTime(1900,1,1);
  } catch (e) {
    print("mapUserData subscription_expiryDate error");
    print(e);
    subscription_expiryDate = DateTime(1900,1,1);
  }
  return UserData(
    subscription_expiryDate:subscription_expiryDate,
    subscription_name: payload["subscription_name"] ?? "",
    subscription_status: getStatus(payload),
    subscription_progress: payload["subscription_progress"] ?? "",
    id: payload["id"] ?? -1,
    profilePictureUrl: payload["profile_picture"] != null
        ? payload["profile_picture"].toString()
        : "",
    mobile: payload["mobile"] ?? "",
    mobile2: payload["mobile2"] != null
        ? payload["mobile2"].toString() == 'false'
        ? ''
        : payload["mobile2"].toString()
        : "",
    email: payload["email"] != null
        ? payload["email"].toString() == 'false'
        ? ''
        : payload["email"].toString()
        : "",

    birthday: birthday,
    bmi: payload["bmi"] != null ? payload["bmi"].toString() : "",
    firstName: payload["firstname"] != null ? payload["firstname"].toString() : "",
    firstNameArabic: payload["firstname_arabic"] != null ? payload["firstname_arabic"].toString() : "",
    lastName: payload["lastname"] != null ? payload["lastname"].toString() : "",
    lastNameArabic: payload["lastname_arabic"] != null ? payload["lastname_arabic"].toString() : "",
    gender: payload["gender"] != null ? payload["gender"].toString() : "",
    height: payload["height"] !=null ? double.parse(payload["height"].toString()):0.0,
    weight: payload["weight"] !=null ? double.parse(payload["weight"].toString()):0.0,
    allergyCategories: payload["allergy_categories"] != null
        ? getGeneralItemList(payload["allergy_categories"])
        : [],
    allergies: payload["allergies"] != null
        ? getGeneralItemList(payload["allergies"])
        : [],
    dislikeCategories: payload["dislike_categories"] != null
        ? getGeneralItemList(payload["dislike_categories"])
        : [],
    dislikes: payload["dislikes"] != null
        ? getGeneralItemList(payload["dislikes"])
        : [],
    medicalReport1: payload["medical_report1"] != null
        ? payload["medical_report1"].toString()
        : "",
    medicalReport2: payload["medical_report2"] != null
        ? payload["medical_report2"].toString()
        : "",
  );
}

getStatus(payload) {
  if(payload["subscription_status"] != null && payload["subscription_status"] !=""){
    return payload["subscription_status"];
  }
  if(payload["latest_subscription_status"] != null && payload["latest_subscription_status"] !=""){
    return payload["latest_subscription_status"];
  }
  return "";
}

getParsableDate(payload) {
  List<String> dateItems = [];
  List<String> dateItemsInt = [];
  dateItems = payload.toString().split("-").toList();
  dateItems.forEach((element) {
    if(int.parse(element)<10 && !element.startsWith("0")){
      dateItemsInt.add('0$element');
    }else{
      dateItemsInt.add(element);
    }
  });
  print("getParsableDate");
  print(dateItemsInt);
  print(dateItemsInt.join("-"));
  print(dateItemsInt.reversed.join("-"));

  return DateTime.parse(dateItemsInt.reversed.join("-"));
}

List<GeneralItem> getGeneralItemList(List<dynamic> list) {
  List<GeneralItem> feneralItemList = [];
  for (var i = 0; i < list.length; i++) {
    feneralItemList.add(mapGeneralItem(list[i]));
  }
  return feneralItemList;
}
