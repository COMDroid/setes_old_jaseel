import 'dart:convert';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/gb_var.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

getTrufs(type, date) async {
  var link = "trufs?type=$type&date=$date";
  var res = await http.get(setApi(link));
  print("'''''1'''''");
  if (res.statusCode == 200) {
    print("'''''2'''''");
    return [false, res.body];
  } else {
    print("'''''3'''''");
    return [true, res.body];
  }
}

getSlot(id, date) async {
  var prams = "slot?slot_id=" + id + "&date=" + date;
  var res = await http.get(setApi(prams));
  if (res.statusCode == 200) {
    return [false, res.body];
  } else {
    return [true, res.body];
  }
}

verifyBookingTruf(props) async {
  var slot = props.slot;
  var date = props.date;
  var body = {
    "slot_id": slot['_id'],
    "date": date,
    "type": slot['type'],
    "user_id": gbUserId
  };
  try {
    var res = await http.post(setApi("verifybooking"), body: body);
    if (res.statusCode == 200) {
      return [true];
    } else {
      return [false, await jsonDecode(res.body)['msg']];
    }
  } catch (e) {
    return [false, "Network Error"];
  }
}

bookTruf(props) async {
  var slot = props.slot;
  var date = props.date;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String id = prefs.getString('userid').toString();
  var body = {
    "slot_id": slot['_id'],
    "date": date,
    "type": slot['type'],
    "user_id": id
  };
  var res = await http.post(setApi("booktruf"), body: body);
  if (res.statusCode == 200) {
    return [false, jsonDecode(res.body)];
  } else {
    return [true, jsonDecode(res.body)];
  }
}
