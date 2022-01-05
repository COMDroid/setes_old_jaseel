import 'package:flutter/cupertino.dart';

getScreen(context) {
  return MediaQuery.of(context).size;
}

dateTomyFormat(DateTime d) {
  return d.day.toString() + "-" + d.month.toString() + "-" + d.year.toString();
}

getDateName(d) {
  return d;
}
