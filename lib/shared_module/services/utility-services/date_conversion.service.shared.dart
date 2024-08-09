
import 'package:intl/intl.dart';

String getFormattedDate(DateTime dateTime) {
  String formattedDate = DateFormat('EEEE, dd MMMM, yyyy').format(dateTime);
  return formattedDate;
}