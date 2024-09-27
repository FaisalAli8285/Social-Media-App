import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Utils {
  static void fieldFocus(
      BuildContext context, FocusNode currentfocus, FocusNode nextFocus) {
    currentfocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Color(0xff242424),
        textColor: Color(0xffffffff),
        fontSize: 16);
  }

  static String formatTime(String timestamp) {
    //parse the timestam as integer
    int timeInMicroseconds = int.tryParse(timestamp) ?? 0;
    //convert a microsecond into a DateTime Object,
    DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(timeInMicroseconds);
    // Format the DateTime object into a human-readable string
    // You can format it as per your requirement (e.g., "HH:mm a" for time, "MMM d, y" for date)
    //HH: Represents the hours in 24-hour format (00 to 23). If you want a 12-hour clock, you could
    //use hh instead.
    //mm: Represents the minutes (00 to 59)
    //a: Stands for the AM/PM 
    String formattedTime =
        DateFormat('hh:mm a').format(dateTime); // e.g., "12:30 PM"
    return formattedTime;
  }
}
