String readableTime(DateTime dateTime) => "${dateTime.hour}:${dateTime.minute}";
String readableDate(DateTime dateTime) =>
    "${dateTime.day} ${_month(dateTime.month)}";
String _month(int month) => [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ][month - 1];
