import 'package:doneapp/shared_module/models/general_item.model.shared.dart';
import 'package:intl/intl.dart';

class UserData {
  final int id;
  final String customerCode;
  final String firstName;
  final String lastName;
  final String firstNameArabic;
  final String lastNameArabic;
  final String gender;
  final double height;
  final double weight;
  final String birthday;
  final String mobile;
  final String email;
  final String? profilePictureUrl;
  final String subscriptionRemainingDays;
  final String subscriptionEndDate;


  UserData(
      {required this.id,
        required this.firstName,
        required this.lastName,
        required this.firstNameArabic,
        required this.lastNameArabic,
        required this.profilePictureUrl,
        required this.mobile,
        required this.customerCode,
        required this.email,
        required this.gender,
        required this.birthday,
        required this.height,
        required this.weight,
        required this.subscriptionEndDate,
        required this.subscriptionRemainingDays });

  Map toJson(){
    return profilePictureUrl==null? {
      "first_name": firstName,
      "last_name": lastName,
      "first_name_arabic": firstNameArabic,
      "last_name_arabic": lastNameArabic,
      "mobile": mobile,
      "email": email,
    }:{
      "first_name": firstName,
      "last_name": lastName,
      "first_name_arabic": firstNameArabic,
      "last_name_arabic": lastNameArabic,
      "profile_picture":
      profilePictureUrl == 'false' ? '' : profilePictureUrl,
      "mobile": mobile,
      "email": email,
    };
  }
}

String convertBirthDay(DateTime birthDay) {
  final f = new DateFormat('yyyy-MM-dd');
  return f.format(birthDay);
}

UserData mapUserData(dynamic payload) {
  print("mapUserData");
  print(payload["subscription_end_date"]);
  print(payload["subscription_end_in"]);


  return UserData(
    subscriptionRemainingDays: payload["subscription_end_in"] ?? "No active subscription.",
    subscriptionEndDate: payload["subscription_end_date"] ?? "No active subscription.",
    id: payload["id"] ?? -1,
    profilePictureUrl: payload["profile_picture"] != null
        ? payload["profile_picture"].toString()
        : "",
    mobile: payload["mobile"] ?? "",
    customerCode: payload["customer_code"] != null ?
        payload["customer_code"].toString()
        : "",
    email: payload["email"] != null
        ? payload["email"].toString() == 'false'
        ? ''
        : payload["email"].toString()
        : "",

    firstName: payload["first_name"] != null ? payload["first_name"].toString() : "",
    firstNameArabic: payload["first_name_arabic"] != null ? payload["first_name_arabic"].toString() : "",
    lastName: payload["last_name"] != null ? payload["last_name"].toString() : "",
    lastNameArabic: payload["last_name_arabic"] != null ? payload["last_name_arabic"].toString() : "",
    gender: payload["gender"] != null ? payload["gender"].toString() : "",
    birthday: payload["birthday"] != null ? payload["birthday"].toString() : "",
    height: payload["height"] !=null ? double.parse(payload["height"].toString()):0.0,
    weight: payload["weight"] !=null ? double.parse(payload["weight"].toString()):0.0,


  );
}

