
import 'package:intl/intl.dart';

String getFormattedDate(DateTime dateTime) {
  String formattedDate = DateFormat('EEEE, dd MMMM, yyyy').format(dateTime);
  return formattedDate;
}

String getFormattedSubscriptionDuration(DateTime startDateTime,DateTime endDateTime) {
  String formattedStartDate = DateFormat('dd MMMM, yyyy').format(startDateTime);
  String formattedEndDate = DateFormat('dd MMMM, yyyy').format(endDateTime);
  return formattedStartDate+" - " +formattedEndDate;
}