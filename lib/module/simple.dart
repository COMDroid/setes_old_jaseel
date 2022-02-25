import 'package:flutter/cupertino.dart';

getScreen(context) {
  return MediaQuery.of(context).size;
}

dateTomyFormat(DateTime d) {
  return d.day.toString() + "-" + d.month.toString() + "-" + d.year.toString();
}

dateFrommyFormat(String d) {
  List spittedD = d.split('-');
  String yr = spittedD[2];
  String mo = spittedD[1];
  String dy = spittedD[0];
  if (mo.length == 1) mo = '0' + mo;
  if (dy.length == 1) dy = '0' + dy;
  return yr + mo + dy + "T00:00:00";
}

getDateName(d) {
  try {
    if (d == dateTomyFormat(DateTime.now())) return "Today";
    return d;
  } catch (e) {
    return d;
  }
}

toint(v) {
  try {
    return (v / 100).toString();
  } catch (e) {
    return '0';
  }
}

findWInner(v) {
  if (v['status'] == "Started") {
    return "LIVE";
  } else if (v['status'] == "Fulltime") {
    if (v["goals"] == null) {
      return "";
    } else {
      try {
        if (v["goals"]['b'] == v["goals"]['r']) {
          return "Draw";
        } else if (v["goals"]['b'] > v["goals"]['r']) {
          return "Blue Win";
        } else if (v["goals"]['b'] < v["goals"]['r']) {
          return "Red Win";
        } else {
          return "";
        }
      } catch (e) {
        return "error";
      }
    }
  } else {
    return "";
  }
}
