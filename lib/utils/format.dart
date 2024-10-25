


import 'package:intl/intl.dart';

String formatDate(data){
  DateTime parsedDate = DateTime.parse(data);

  return DateFormat('dd MMMM yyyy').format(parsedDate);
}