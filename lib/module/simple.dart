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
        if (v["goals"]['b'] == v["goals"]['r'])
          return "Draw";
        else if (v["goals"]['b'] > v["goals"]['r'])
          return "Blue Win";
        else if (v["goals"]['b'] < v["goals"]['r'])
          return "Red Win";
        else
          return "";
      } catch (e) {
        return "error";
      }
    }
  } else {
    return "";
  }
}
