String readableTime(DateTime dateTime) => "${dateTime.hour}:${dateTime.minute}";
String readableDate(DateTime dateTime) =>
    "${dateTime.day} ${_month(dateTime.month)}";
DateTime _today = DateTime.now();
String today() =>
    "${_day(_today.weekday)} ${_today.day} ${_month(_today.month)}";
String _day(int day) =>
    ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][day - 1];
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
      "Dec"
    ][month - 1];
