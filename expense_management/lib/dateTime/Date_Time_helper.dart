// convert DateTime object to a string yyyymmdd

String converDateTimeToString(DateTime dateTime) {
  String year = dateTime.year.toString();

  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0' + month;
  }

  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0' + day;
  }

  String yyyymmddd = year + month + day;

  return yyyymmddd;
}
